vim.cmd([[
    let s:header_cmd = 'fortune deutsch | cowsay -W 80'
    "let s:header_cmd = 'cat ~/zettel-.txt | cowsay -n'
    let g:startify_custom_header = startify#pad(split(system(s:header_cmd), '\n'))
    let g:startify_bookmarks = [ {'a': '$XDG_DOCUMENTS_DIR/notes/notes-zettelkasten/agenda.md'}, {'c': '~/.config/nvim/init.lua'}, {'n': '~/docs/notes/notes-zettelkasten/'} ]
    let s:bookmarks2 = ['~/docs/notes/notes-zettelkasten/', '~/docs/notes/school/EEL3111C/lectures/']
    let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   MRU '.getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU' ]           },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ ]
    ]])
----#center is centered, #pad is padded
