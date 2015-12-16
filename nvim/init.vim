set nocompatible
set background=dark

map <space> <leader>

" Windows specific stuff
if has('win32')
    behave mswin
    set term=xterm
    set t_Co=256
    let &t_AB='\e[48;5;%dm'
    let &t_AF='\e[38;5;%dm'

    " set rtp for windows because it is not set to the place we want
    set rtp+=~/.vim/
endif

" GUI
if has('gui_running')
    set anti enc=utf-8
    if has('win32')
        set guifont=Consolas:h9
    else
        set guifont=SourceCodePro\ 9
    endif
    set guioptions-=m  " Remove menu bar
    set guioptions-=T  " Remove toolbar
    set guioptions-=r  " Remove right-hand scroll bar
    set guioptions-=l
    set guioptions-=b
    set guioptions-=L
    set guioptions-=e
    au GUIEnter * set vb t_vb=
endif

" Neovim specific stuff
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Properties
set number          " Show line numbers
set relativenumber  " Show relative numbers in relation to the cursor
set encoding=utf8   " Use UTF8 everywhere
set showcmd         " Display an incomplete command in the lower right corner of the Vim window
set shortmess=atI   " Shortens messages
set showmatch       " Show matching brackets
set ruler           " Show ruler
set cursorline      " Highlight current line
set lazyredraw      " Redraw only when we need to
set nowrap          " Don't wrap the lines
set splitbelow      " Split below the current window
set splitright      " Split right of the current window
set hidden          " Don't ask to save when leaving the buffer
set autoread        " Automatically reload file on external changes

" Statusline
set laststatus=2                            " Always show the statusline
set statusline=%<%f\                        " Filename
set statusline+=%w%h%m%r " Options
set statusline+=%{fugitive#statusline()}    "  Git Hotness
set statusline+=\ [%{&ff}/%Y]               " filetype
set statusline+=\ [%{getcwd()}]             " current dir
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
set statusline+=%=%-14.(%l,%c%V%)\ %p%%     " Right aligned file nav info

" Don't autoselect first item in omnicomplete, show if only one item (for preview)
" Remove preview if you don't want to see any documentation whatsoever
set completeopt=longest,menuone,preview

" Clipboard
set clipboard=unnamed,unnamedplus

" Project-specific vimrc
set exrc            " Enable external vimrc
set secure          " Prevent external vimrc from using dangerous commands

" Invisible chars
set listchars=tab:▸\ ,
set list

" Command menu autocompletion
set wildmenu                    " Enable it
set wildignorecase              " Who needs case anyways
set wildmode=list:longest,full  " Wildmenu display options

" Highlight 81th column
let &colorcolumn='81,'.join(range(121,999),',')
hi ColorColumn guibg=#2d2d2d ctermbg=246

" Tabs & Spaces
set expandtab     " Use spaces instead of tabs
set tabstop=4     " A tab is 4 spaces
set autoindent    " Always set autoindenting on
set copyindent    " Copy the previous indentation on autoindenting
set shiftwidth=4  " Number of spaces to use for autoindenting
set smarttab      " Insert tabs on the start of a line according to shiftwidth, not tabstop

" Search
set ignorecase    " Ignore case when searching
set smartcase     " Ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch      " Highlight search terms
set incsearch     " Show search matches as you type

" Autosave
set swapfile
set backup
set backupdir=~/.vim/bak
set directory=~/.vim/tmp

" No annoyances
set novisualbell        " No blinking
set noerrorbells        " No noise
set vb t_vb=            " Disable any beeps or flashes on error

" Folding
set foldenable          " Enable folding
set foldmethod=indent   " Fold by indent
set foldlevelstart=20   " Don't automatically fold opened files

" Mouse
set mouse=a             " Configure mouse
set mousehide           " Hide mouse after chars typed

" Key Bindings

" Cleans hilighted text after search
nmap <silent> <leader>/ :nohlsearch<CR>

" Window movement
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

" Mirror tmux
nmap <silent> <leader>" :split<CR>
nmap <silent> <leader>% :vsplit<CR>
nmap <silent> <leader>o <C-W>w

" Plugins
call plug#begin('~/.vim/bundle')

" General
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'Raimondi/delimitMate'
Plug 'kshenoy/vim-signature'

" File browsing
Plug 'scrooloose/nerdtree'
nmap <silent> <leader>a :NERDTreeToggle<CR>
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeIndicatorMapCustom = {
\    "Modified"  : "✹",
\    "Staged"    : "✚",
\    "Untracked" : "✭",
\    "Renamed"   : "➜",
\    "Unmerged"  : "═",
\    "Deleted"   : "✖",
\    "Dirty"     : "✗",
\    "Clean"     : "✔︎",
\    "Unknown"   : "?"
\}
Plug 'tpope/vim-vinegar'
Plug 'ctrlpvim/ctrlp.vim'
nmap <leader>p :CtrlPMixed<CR>
nmap <leader>e :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>

" Better ack
Plug 'rking/ag.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'

" Yanks and Undo
Plug 'vim-scripts/YankRing.vim'
let g:yankring_history_dir='~/.vim/doc'
nmap <silent> <leader>y :YRShow<CR>
Plug 'simnalamburt/vim-mundo'
nmap <silent> <leader>u :GundoToggle<CR>
let g:gundo_width=60
let g:gundo_right=1

" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" Comments
Plug 'scrooloose/nerdcommenter'

" Linter
Plug 'scrooloose/syntastic'
let g:syntastic_cs_checkers=['syntax', 'semantic', 'issues']

" Formatter
Plug 'Chiel92/vim-autoformat'

" Tagbar
Plug 'majutsushi/tagbar'
nmap <leader>t :TagbarToggle<CR>

" Autocompletion
Plug 'Valloric/YouCompleteMe', {
\   'do': './install.py --omnisharp-completer --clang-completer'
\}

" Languages

" Rust
Plug 'rust-lang/rust.vim'

" Haskell
Plug 'eagletmt/ghcmod-Vim'
Plug 'eagletmt/neco-ghc'
Plug 'dag/vim2hs'
let g:haskell_conceal=0

" Frontend
Plug 'mattn/emmet-vim'
Plug 'Valloric/MatchTagAlways'
Plug 'gorodinskiy/vim-coloresque'

" CSharp
Plug 'OrangeT/vim-csharp'
Plug 'OmniSharp/omnisharp-vim'
let g:OmniSharp_selector_ui='ctrlp'
let g:OmniSharp_server_type='roslyn'

" C/C++
Plug 'vim-scripts/a.vim'

" JavaScript
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'
Plug 'othree/javascript-libraries-syntax.vim'
let g:used_javascript_libs='angularjs'

" DB
Plug 'vim-scripts/dbext.vim'

" Colorschemes
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'

call plug#end()

" set syntax on after vim-plug does it's thing
filetype plugin indent on
syntax on " Enable syntax highlighting

colorscheme gruvbox

