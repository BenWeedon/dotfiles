" easy editing of vimrc file
nmap <silent> <leader>ev :tabe $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set number
set nowrap
set showmatch

" remaps
imap hh <Esc>
nnoremap ; :

" search
set ignorecase
set smartcase
set incsearch

" tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set autoindent
set smarttab