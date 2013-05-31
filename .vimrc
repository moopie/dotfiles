" This must be first, because it changes other options as side effect
set nocompatible

" Change the mapleader from \ to ,
let mapleader=","

set hidden 	" hides buffers instead of closing them
set nowrap	" don't wrap lines
set tabstop=4	" a tab is 4 spaces
set backspace=indent,eol,start
		" allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup
set noswapfile

filetype plugin indent on
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
if has('autocmd')
	autocmd filetype python set expandtab
endif

" Hilights whitespaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
" Paste mode for pasting large amounts of text
set pastetoggle=<F2>

" Shortcut mappings
nnoremap ; :


" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Cleans hilighted text after search
nmap <silent> ,/ :nohlsearch<CR>

" Lets you to :w!! if you forgot to sudo into a file
cmap w!! w !sudo tee % >/dev/null

" Statusline
set laststatus=2
" statusline
" " cf the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
" " format markers:
" "   %< truncation point
" "   %n buffer number
" "   %f relative path to file
" "   %m modified flag [+] (modified), [-] (unmodifiable) or nothing
" "   %r readonly flag [RO]
" "   %y filetype [ruby]
" "   %= split point for left and right justification
" "   %-35. width specification
" "   %l current line number
" "   %L number of lines in buffer
" "   %c current column number
" "   %V current virtual column number (-n), if different from %c
" "   %P percentage through buffer
" "   %) end of width specification
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%))

" GUI
if has("gui_running")
	set guifont=Consolas\ 9
	set guioptions-=m  "remove menu bar
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar"
	set guioptions-=l
	set guioptions-=b
	set guioptions-=L
	set lines=60 columns=120
endif

" ctags
set tags+=/home/platypus/.vim/tags

"" Plugins

" let Vundle manage Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Fugitive
Bundle 'tpope/vim-fugitive'

" Sparkup
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

" delimitMate
Bundle 'Raimondi/delimitMate.git'

" Closetag
Bundle 'docunext/closetag.vim.git'

" PyFlakes
Bundle 'kevinw/pyflakes-vim.git'

" NERDTree
Bundle 'scrooloose/nerdtree'
nnoremap <F3> :NERDTreeToggle<CR>
if has('autocmd')
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif

" Tagbar
Bundle 'majutsushi/tagbar.git'
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

" CtrlP
Bundle 'kien/ctrlp.vim'
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = 'find %s -type f'
noremap <leader>b <Esc>:CtrlPBuffer<CR>

" Monokai
Bundle 'sickill/vim-monokai'
if has("gui_running")
	colorscheme Monokai
endif

" UltiSnips
Bundle 'SirVer/ultisnips'

" JavaComplete
Bundle 'vim-scripts/javacomplete'

" Supertab - always keep last for the autocomplete plugins
Bundle 'ervandew/supertab'
if has('autocmd')
	autocmd Filetype java setlocal omnifunc=javacomplete#Complete
endif
let g:SuperTabDefaultCompletionType = 'context'

" Ruby-vim for all the ruby goodness
Bundle 'vim-ruby/vim-ruby'

" Functions

" Autoimport in java

noremap <F9> :call JavaInsertImport()<CR>
function! JavaInsertImport()
  exe "normal mz"
  let cur_class = expand("<cword>")
  try
    if search('^\s*import\s.*\.' . cur_class . '\s*;') > 0
      throw getline('.') . ": import already exist!"
    endif
    wincmd }
    wincmd P
    1
    if search('^\s*public.*\s\%(class\|interface\)\s\+' . cur_class) > 0
      1
      if search('^\s*package\s') > 0
        yank y
      else
        throw "Package definition not found!"
      endif
    else
      throw cur_class . ": class not found!"
    endif
    wincmd p
    normal! G
    " insert after last import or in first line
    if search('^\s*import\s', 'b') > 0
      put y
    else
      1
      put! y
    endif
    substitute/^\s*package/import/g
    substitute/\s\+/ /g
    exe "normal! 2ER." . cur_class . ";\<Esc>lD"
  catch /.*/
    echoerr v:exception
  finally
    " wipe preview window (from buffer list)
    silent! wincmd P
    if &previewwindow
      bwipeout
    endif
    exe "normal! `z"
  endtry
endfunction
