call plug#begin('~/.config/nvim/plugged')

"Plug 'sainnhe/gruvbox-material'
Plug 'JetpackJackson/farin-colors'
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-tree/nvim-web-devicons' " optional
Plug 'nvim-tree/nvim-tree.lua'
"Plug 'rktjmp/lush.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ellisonleao/glow.nvim'
Plug '0x00-ketsu/markdown-preview.nvim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'wesQ3/vim-windowswap'
call plug#end()
colorscheme dusche

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

lua << EOF
require('glow').setup()
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

let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> ,yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> ,pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> ,ww :call WindowSwap#EasyWindowSwap()<CR>
