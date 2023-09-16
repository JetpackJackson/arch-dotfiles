local cmp = require 'cmp'
local lsp = require 'lspconfig'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    }),
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function on_attach_general(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end
local function on_attach_lsp(_, bufnr)
    on_attach_general(bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format({
            filter = function(client)
                return client.name ~= "null-ls"
            end,
            bufnr = bufnr,
            { async = true }
        })
    end, bufopts)
end
local function on_attach_null_ls(_, bufnr)
    on_attach_general(bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format({
            filter = function(client)
                return client.name == "null-ls"
            end,
            bufnr = bufnr,
            { async = true }
        })
    end, bufopts)
end

-- bash
lsp.bashls.setup {
    on_attach = on_attach_lsp,
    capabilities = capabilities
}
-- markdown
lsp.marksman.setup {
    on_attach = on_attach_null_ls,
    capabilities = capabilities
}
-- vue
lsp.volar.setup {
    on_attach = on_attach_null_ls,
    capabilities = capabilities
}
lsp.svelte.setup {
    on_attach = on_attach_null_ls,
    capabilities = capabilities
}
-- tailwind
lsp.tailwindcss.setup {
    on_attach = on_attach_null_ls,
    capabilities = capabilities
}
-- rust
lsp.rust_analyzer.setup {
    on_attach = on_attach_lsp,
    capabilities = capabilities
}
-- toml
lsp.taplo.setup {
    on_attach = on_attach_lsp,
    capabilities = capabilities
}
-- json
lsp.jsonls.setup {
    on_attach = on_attach_null_ls,
    capabilities = capabilities
}
lsp.yamlls.setup {
    on_attach = on_attach_null_ls,
    capabilities = capabilities
}
-- typescript
lsp.tsserver.setup {
    on_attach = on_attach_null_ls,
    capabilities = capabilities,
    root_dir = lsp.util.root_pattern("package.json"),
    single_file_support = false,
}
-- deno ts
vim.g.markdown_fenced_languages = {
    "ts=typescript"
}
lsp.denols.setup {
    on_attach = on_attach_lsp,
    capabilities = capabilities,
    root_dir = lsp.util.root_pattern("deno.jsonc"),
}

-- lua
lsp.lua_ls.setup {
    on_attach = on_attach_lsp,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
