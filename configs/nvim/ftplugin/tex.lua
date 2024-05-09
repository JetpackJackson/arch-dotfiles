vim.o.makeprg = 'pandoc % -o %:r.pdf && zathura %:r.pdf'
vim.cmd([[syntax match Comment "/^- \[X\].*$/"]])
vim.cmd([[syntax match Comment "/^    - \[X\].*$/"]])
vim.cmd([[syntax match Comment "/^        - \[X\].*$/"]])
vim.cmd([[syntax match Directory "/^- \[-\].*$/"]])
vim.cmd([[syntax match Directory "/^    - \[-\].*$/"]])
vim.cmd([[syntax match Directory "/^        - \[-\].*$/"]])

local function update_tex_root()
 local current_path = vim.fn.expand("%:p")
 local pattern = "%! TEX root = .*"
 local replacement = "%! TEX root = " .. current_path

 local content = vim.api.nvim_buf_get_lines(0, 0, -1, true)
 local updated_content = {}

 for i, line in ipairs(content) do
   if string.match(line, pattern) then
     table.insert(updated_content, replacement)
   else
     table.insert(updated_content, line)
   end
 end

 vim.api.nvim_buf_set_lines(0, 0, -1, true, updated_content)
end

vim.keymap.set({'n'}, '<A-t>', '', {
    desc = "Update TEX file path.",
    callback = update_tex_root
})


