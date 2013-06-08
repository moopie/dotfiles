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
set clipboard+=unnamed  " Yanks go on clipboard instead."
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
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
set nobackup
set noswapfile

set showmatch  " Show matching brackets.
set matchtime=5  " Bracket blinking.
set novisualbell  " No blinking
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.
" statusline {{{
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
" }}}
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%))
set vb t_vb= " disable any beeps or flashes on error
set ruler  " Show ruler
set showcmd " Display an incomplete command in the lower right corner of the Vim window
set shortmess=atI " Shortens messages"

set fo+=o " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r " Do not automatically insert a comment leader after an enter
set fo-=t " Do no auto-wrap text using textwidth (does not apply to comments)"

" Folding
set foldenable " Turn on folding
set foldmethod=marker " Fold on the marker
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds "

" Mouse
set mouse-=a   " Disable mouse
set mousehide  " Hide mouse after chars typed

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


" GUI
if has("gui_running")
	set guifont=inconsolata-g\ 9
	set guioptions-=m  "remove menu bar
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar"
	set guioptions-=l
	set guioptions-=b
	set guioptions-=L
	set lines=60 columns=120
endif

" ctags
set tags+=./tags;$HOME " walk directory tree upto $HOME looking for tags"

"" Plugins

" let Vundle manage Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'

Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

Bundle 'Raimondi/delimitMate.git'

Bundle 'docunext/closetag.vim.git'

" Programming
Bundle 'kevinw/pyflakes-vim.git'
Bundle 'vim-scripts/javacomplete'
" Ruby-vim for all the ruby goodness
Bundle 'vim-ruby/vim-ruby'
Bundle 'SirVer/ultisnips'
Bundle "jQuery"
Bundle "rails.vim"

" Lint
Bundle 'godlygeek/tabular'
Bundle 'hallettj/jslint.vim'
Bundle 'walm/jshint.vim'

" Syntax
Bundle 'jelera/vim-javascript-syntax'
Bundle 'kchmck/vim-coffee-script'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'
Bundle 'scrooloose/syntastic'

" Utility
Bundle 'repeat.vim'
Bundle 'surround.vim'
Bundle 'mileszs/ack.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'YankRing.vim'
let g:yankring_history_dir = "~/.vim"

" tComment
Bundle "tComment"
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

Bundle 'scrooloose/nerdtree'
nnoremap <F3> :NERDTreeToggle<CR>
if has('autocmd')
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif

Bundle 'majutsushi/tagbar.git'
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

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

" Supertab - always keep last for the autocomplete plugins
Bundle 'ervandew/supertab'
if has('autocmd')
	autocmd Filetype java setlocal omnifunc=javacomplete#Complete
endif
let g:SuperTabDefaultCompletionType = 'context'

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
