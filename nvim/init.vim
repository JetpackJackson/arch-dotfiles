call plug#begin('~/.config/nvim/plugged')
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
"let g:XkbSwitchEnabled = 1
"let g:XkbSwitchLib = '~/.sway-vim-kbswitch/target/release/libswaykbswitch.so'
"let g:XkbSwitchILayout = 'us'
"let g:XkbSwitchNLayout = 'us'
"let b:XkbSwitchILayout = 'us'

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

"let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.so'
"set background=dark
"let g:gruvbox_material_background = 'hard'
"let g:gruvbox_material_better_performance = 1
"let g:gruvbox_material_transparent_background = 2
"let g:gruvbox_material_foreground = 'original'
"colorscheme gruvbox-material
