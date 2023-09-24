local function escape(str)
  -- You need to escape these characters to work correctly
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

-- Recommended to use lua template string
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local de = [[8jduaxphlmwß8ctieobnrsgqfvüäöyz]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local de_shift = [[8JDUAXPHLMWẞ„CTIEOBNRSGQFVÜÄÖYZ–•]]

vim.opt.langmap = vim.fn.join({
    -- | `to` should be first     | `from` should be second
    escape(de_shift) .. ';' .. escape(en_shift),
    escape(de) .. ';' .. escape(en),
}, ',')
