call plug#begin('~/.vim/plugged')
"call plug#begin()

"Plug 'sainnhe/gruvbox-material'
Plug 'JetpackJackson/farin-colors'
"Plug 'pablopunk/sick.vim'

call plug#end()
colorscheme dusche
"colorscheme sick

if has('termguicolors')
	set termguicolors
endif
"set background=dark
"let g:gruvbox_material_background = 'hard'
"let g:gruvbox_material_better_performance = 1
"let g:gruvbox_material_transparent_background = 2
"let g:gruvbox_material_foreground = 'original'
"colorscheme gruvbox-material
