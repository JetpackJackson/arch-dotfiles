return {
--    {
--      "iurimateus/luasnip-latex-snippets.nvim",
--      dependencies = { "l3mon4d3/luasnip", "lervag/vimtex" },
--      config = function()
--        require('luasnip-latex-snippets').setup({
--          use_treesitter = false,
--          allow_on_markdown = false,
--        })
--        require("luasnip").config.setup {
--            enable_autosnippets = true,
--        }
--      end,
--    },
    { "lervag/vimtex" };
    {
        "Pocco81/auto-save.nvim",
        config = function()
             require("auto-save").setup {
             }
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            local lsp = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local on_attach = function(client)
                client.server_capabilities.semanticTokensProvider = nil
            end

            for _, server in ipairs({ "clangd", "pyright", "marksman", "lua_ls", "nil_ls" }) do
                lsp[server].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end
            lsp.efm.setup({
                init_options = {documentFormatting = true},
                settings = {
                    rootMarkers = {".git/"},
                },
                filetypes = { "bash", "sh" },
                capabilities = capabilities,
--                --on_attach = on_attach,
            })
            lsp.nil_ls.setup({
                capabilities = capabilities,
                filetypes = { "nix" },
                --on_attach = on_attach,
            })
            lsp.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    diagnostics = {
                        disable = { "lowercase-global" },
                    },
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                    },
                },
            })
            lsp.matlab_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lsp.arduino_language_server.setup({
                capabilities = capabilities,
                filetypes = { "arduino" },
                --debug = true,
                --'-cli-config', '/Users/ubaldot/Library/Arduino15/arduino-cli.yaml'
                --on_attach = on_attach,
                cmd = {
                    "arduino-language-server",
                    "-cli", "/usr/bin/arduino-cli",
                    "-clangd", "/usr/bin/clangd",
                }
            })
            lsp.texlab.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lsp.ltex.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                autostart = false,
                settings = {
                    ltex = {
                        language = "en-US","de-DE",
                    },
                },
            })

            require("lspconfig.ui.windows").default_options.border = "single"
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",--buffer text
            "hrsh7th/cmp-cmdline",--cmdline
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",--dir paths
            "l3mon4d3/luasnip",
            "saadparwaiz1/cmp_luasnip",
            "mstanciu552/cmp-matlab",
        },
        config = function()
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local cmp = require("cmp")
            local luasnip = require("luasnip")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    documentation = {
                        border = "single",
                    },
                },
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.kind = vim_item.kind
                        vim_item.menu = ({
                            buffer = "[Buffer]",
                            cmdline = "[CMD-Line]",
                            luasnip = "[LuaSnip]",
                            nvim_lsp = "[LSP]",
                            path = "[Path]",
                            cmp_matlab = "[MATLAB]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                }),
                sources = cmp.config.sources({
                    { name = "path", option = { trailing_slash = true } },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "papis" },
                    { name = "cmp_matlab" },
                }),
--                experimental = { ghost_text = true },
                experimental = { ghost_text = {hl_group = 'FoldColumn'} },
                enabled = function()
                    local context = require("cmp.config.context")
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    else
                        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                    end
                end,
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path", option = { trailing_slash = true } },
                    { name = "cmdline" },
                }),
            })

            --cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
