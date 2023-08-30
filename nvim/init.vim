call plug#begin('~/.config/nvim/plugged')
"Plug 'sainnhe/gruvbox-material'
Plug 'JetpackJackson/farin-colors'
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rktjmp/lush.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
colorscheme dusche
"""
if has('termguicolors')
	set termguicolors
endif

function! PrintBuffer()
  silent execute '!lpoptions -d HP_LaserJet_2200_LOCAL_hpcups'
  silent execute 'w !lp -n 1 -o media=a4 -o sides=two-sided-long-edge -'
endfunction


command! Ha call PrintBuffer()
command! Hardcopy call PrintBuffer()
function! PrintBufferWithCR()
  silent execute 'w !lp'
endfunction

command! Hc call PrintBufferWithCR()

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
                    notes = "$XDG_DOCUMENTS_DIR/notes",
		    deutsch  = "$XDG_DOCUMENTS_DIR/deutsch",
                },
            },
        },
    },
}
EOF

"" Bone layout rebinding, with hands on jkl/ (nrsk) to prevent conflicts with
"" g on home row causing delays and stuff
noremap n h
noremap r j
noremap s k
noremap k l

noremap h n
noremap H N

"" remap replace
noremap ß r

