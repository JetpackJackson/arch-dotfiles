call plug#begin('~/.config/nvim/plugged')

"Plug 'sainnhe/gruvbox-material'
Plug 'JetpackJackson/farin-colors'
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'pablopunk/sick.vim'

call plug#end()
colorscheme dusche
"colorscheme sick

if has('termguicolors')
	set termguicolors
endif


lua << EOF
require('neorg').setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
	["core.ui"] = {},
	["core.ui.calendar"] = {},
	["core.export.markdown"] = {},
	["core.export"] = {},
	["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "$XDG_DOCUMENTS_DIR/neorg-notes",
		    work  = "$XDG_DOCUMENTS_DIR/neorg-work",
                },
            },
        },
    },
}
EOF
