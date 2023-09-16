local luasnip = require("luasnip")

luasnip.filetype_extend("typescriptreact", { "html" })
require("luasnip/loaders/from_vscode").lazy_load()

luasnip.setup({
    update_events = 'TextChanged, TextChangedI',
})

vim.keymap.set({ "i", "s" }, "<C-]>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })
