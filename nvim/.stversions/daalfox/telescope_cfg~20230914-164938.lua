local actions = require("telescope.actions")

require("telescope").setup {
    pickers = {
        buffers = {
            initial_mode = "normal",
            mappings = {
                i = {
                    ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
                },
                n = {
                    ["d"] = actions.delete_buffer + actions.move_to_top,
                }
            }
        }
    }
}
