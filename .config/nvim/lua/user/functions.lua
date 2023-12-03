function Tip()
    print(os.execute('curl -s -m 3 https://vtip.43z.one'))
end

vim.cmd([[function! Vtip()
  echomsg system('curl -s -m 3 https://vtip.43z.one')
endfunction]])

local function bufmap()
    vim.keymap.set('i', '<tab>', '<c-x><c-v>', {buffer=true})
end
vim.api.nvim_create_autocmd("filetype", {pattern="cmdpalette", callback=bufmap})
------------------------------ Statusline ---------------------------------------------------
Modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}
function Mode()
  Current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", Modes[Current_mode]):upper()
end

function Update_mode_colors()
  Current_mode = vim.api.nvim_get_mode().mode
  Mode_color = "%#Grey#"
  if Current_mode == "n" then
      Mode_color = "%#Fg#"
  elseif Current_mode == "i" or Current_mode == "ic" then
      Mode_color = "%#Green#"
  elseif Current_mode == "v" or Current_mode == "V" or Current_mode == "" then
      Mode_color = "%#Blue#"
  elseif Current_mode == "R" then
      Mode_color = "%#Orange#"
  elseif Current_mode == "c" then
      Mode_color = "%#Red#"
  elseif Current_mode == "t" then
      Mode_color = "%#Purple#"
  end
  return Mode_color
end

function Filepath()
  Fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if Fpath == "" or Fpath == "." then
      return " "
  end

--  return string.format(" %%<%s/", Fpath)
  return string.format(" ", Fpath)
end

function Filename()
  Fname = vim.fn.expand "%:t"
  if Fname == "" then
      return ""
  end
  return Fname .. " "
end

function Filetype()
  return string.format(" %s ", vim.bo.filetype)
  --:upper()
end

function Lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %l:%c "
end

function FileEncoding()
    local encoding = vim.bo.fileencoding or vim.bo.encoding
    local format = vim.bo.fileformat
    return string.format("%s[%s]", encoding, format)
end

function Words()
    local num = string.format(vim.fn.wordcount().words)
    return string.format("%s words", num)
--    return tostring(vim.fn.wordcount().words)
end


------------------------------ Indentation --------------------------------------------------
function _G.AdjustListchars()
  local lead = "┊"
  for _ = 1, vim.bo.shiftwidth - 1 do
    lead = lead .. " "
  end
  vim.opt_local.listchars:append({ leadmultispace = lead })
end

function SearchCount()
  local search = vim.fn.searchcount({maxcount = 0}) -- maxcount = 0 makes the number not be capped at 99
  local searchCurrent = search.current
  local searchTotal = search.total
  if searchCurrent > 0 then
    return "/"..vim.fn.getreg("/").." ["..searchCurrent.."/"..searchTotal.."]"
  else
    return ""
  end
end

------------------------------ Word Counts --------------------------------------------------
function MixedIndents()
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = vim.fn.search(space_pat, 'nwc')
  local tab_indent = vim.fn.search(tab_pat, 'nwc')
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
    mixed = mixed_same_line > 0
  end
  if not mixed then return '' end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
     return 'MI:'..mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
  local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
  if space_indent_cnt > tab_indent_cnt then
    return 'MI:'..tab_indent
  else
    return 'MI:'..space_indent
  end
end

function TrailingSpace()
  local space = vim.fn.search([[\s\+$]], 'nwc')
  return space ~= 0 and "TS" or ""
end

function GetWords()
  return tostring(vim.fn.wordcount().words)
end

function ExportColorsKitty()
    local fn = vim.fn
    local filename = os.getenv("HOME") .. "/.config/kitty/nvim_export.conf"
    local file = io.open(filename, "w")
    io.output(file)
    io.write("# vim:ft=kitty" .. "\n\n")
    io.write("# exported from " .. vim.g.colors_name .. "\n\n")
    local fg = fn.synIDattr(fn.hlID("Normal"), "fg")
    local bg = fn.synIDattr(fn.hlID("Normal"), "bg")
    io.write("foreground " .. fg .. "\n")
    io.write("background " .. bg .. "\n")
    io.write("selection_foreground " .. bg .. "\n")
    io.write("selection_background " .. fg .. "\n")
    for i = 0,15 do
        local var = "g:terminal_color_" .. tostring(i)
        if fn.exists(var) == 1 then
            local tc = fn.eval(var)
            io.write("color" .. tostring(i) .. " " .. tc .. "\n")
            if i == 2 then
                io.write("cursor " .. tc .. "\n")
            end
        end
    end
    io.close(file)
    print("Colors exported to " .. filename)
end
