--[[ vim.g.coq_settings = {
     auto_start = true
} ]]

local lsp = require("lspconfig")
local coq = require("coq")
-- set up servers below with ensure_capabilities etc
--local coq_settings = {coq_settings.auto_start = true | 'shut-up'}
vim.g.coq_settings = {
    ["auto_start"] = "shut-up",
    ["clients.third_party.enabled"]=false,
}
