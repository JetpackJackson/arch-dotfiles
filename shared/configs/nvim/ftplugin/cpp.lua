-- from https://stackoverflow.com/questions/76954973/how-to-set-keybindings-to-execute-python-files-in-neovim-using-the-built-in-term
local function run_curr_cpp_file()
    -- Get file name in the current buffer
    local file_name = vim.api.nvim_buf_get_name(0)

    -- Get terminal codes for running cpp file
    -- ("i" to enter insert before typing rest of the command)
    local cpp_cmd = vim.api.nvim_replace_termcodes("ig++ \"" .. file_name .. "\" && ./a.out<cr>", true, false, true)
--    local cpp_cmd = "ig++ \"" .. file_name .. "\" && ./a.out<cr>"

    -- Determine terminal window split and launch terminal
    local percent_of_win = 0.4
    local curr_win_height = vim.api.nvim_win_get_height(0) -- Current window height
    local term_height = math.floor(curr_win_height * percent_of_win) -- Terminal height
    vim.cmd(":below " .. term_height .. "split | term") -- Launch terminal (horizontal split)

    -- Press keys to run cpp command on current file
    vim.api.nvim_feedkeys(cpp_cmd, "t", false)
end

vim.keymap.set({'n'}, '<A-r>', '', {
    desc = "Run .cpp file via Neovim built-in terminal",
    callback = run_curr_cpp_file
})

local function run_all_cpp_files()
    -- Get terminal codes for running cpp file
    -- ("i" to enter insert before typing rest of the command)
    local cpp_cmd = vim.api.nvim_replace_termcodes("ig++ *.cpp && ./a.out<cr>", true, false, true)
    -- Determine terminal window split and launch terminal
    local percent_of_win = 0.4
    local curr_win_height = vim.api.nvim_win_get_height(0) -- Current window height
    local term_height = math.floor(curr_win_height * percent_of_win) -- Terminal height
    vim.cmd(":below " .. term_height .. "split | term") -- Launch terminal (horizontal split)

    -- Press keys to run cpp command on current file
    vim.api.nvim_feedkeys(cpp_cmd, "t", false)
end

vim.keymap.set({'n'}, '<A-t>', '', {
    desc = "Run .cpp files via Neovim built-in terminal",
    callback = run_all_cpp_files
})

