call plug#begin('~/.vim/plugged')
"call plug#begin()

"Plug 'sainnhe/gruvbox-material'
"Plug 'lifepillar/vim-colortemplate'
"Plug 'https://github.com/JetpackJackson/farin.vim'
"Plug 'https://github.com/JetpackJackson/farin.vim.git'
Plug 'JetpackJackson/farin.vim'
"Plug 'pablopunk/sick.vim'

call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
"
"source /home/jet/.vim/plugged/farin.vim
"source /home/jet/.local/share/nvim/plugged/farin.vim/farin.vim
colorscheme farin
"colorscheme sick

" uncomment for gruvbox
"if has('termguicolors')
"	set termguicolors
"endif
"set background=dark
"let g:gruvbox_material_background = 'hard'
"let g:gruvbox_material_better_performance = 1
"let g:gruvbox_material_transparent_background = 2
"let g:gruvbox_material_foreground = 'original'
"colorscheme gruvbox-material
