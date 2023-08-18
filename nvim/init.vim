call plug#begin('~/.config/nvim/plugged')

"Plug 'sainnhe/gruvbox-material'
Plug 'JetpackJackson/farin-colors'
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'pablopunk/sick.vim'

"Plug 'prabirshrestha/vim-lsp'
"Plug 'Shougo/deoplete.nvim'
"Plug 'lighttiger2505/deoplete-vim-lsp'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
colorscheme dusche
"colorscheme sick

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
" setting with vim-lsp
""if executable('ccls')
""   au User lsp_setup call lsp#register_server({
""      \ 'name': 'ccls',
""      \ 'cmd': {server_info->['ccls']},
""      \ 'root_uri': {server_info->lsp#utils#path_to_uri(
""      \   lsp#utils#find_nearest_parent_file_directory(
""      \     lsp#utils#get_buffer_path(), ['.ccls', 'compile_commands.json', '.git/']))""},
""      \ 'initialization_options': {
""      \   'highlight': { 'lsRanges' : v:true },
""      \   'cache': {'directory': stdpath('cache') . '/ccls' },
""      \ },
""      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
""      \ })
""endif

"" Bone layout rebinding, with hands on jkl/ (nrsk) to prevent conflicts with
"" g on home row causing delays and stuff
noremap n h
noremap r j
noremap s k
noremap k l

""noremap gg <Nop>
""noremap g <Nop>
""noremap G <Nop>
""noremap n h
""noremap r j
""noremap s k
""noremap g l

"" remap replace
noremap ß r

""noremap k j|noremap <C-w>k <C-w>j|noremap <C-w><C-k> <C-w>j
""noremap j k|noremap <C-w>j <C-w>k|noremap <C-w><C-j> <C-w>k

