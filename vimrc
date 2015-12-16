" Properties
set encoding=utf8   " Use UTF8 everywhere
set showcmd         " Display an incomplete command in the lower right corner of the Vim window
set shortmess=atI   " Shortens messages
set showmatch       " Show matching brackets
set ruler           " Show ruler
set lazyredraw      " Redraw only when we need to
set nowrap          " Don't wrap the lines
set hidden          " Don't ask to save when leaving the buffer
set autoread        " Automatically reload file on external changes

" Clipboard
set clipboard=unnamed,unnamedplus

" Invisible chars
set listchars=tab:▸\ ,
set list

" Command menu autocompletion
set wildmenu                    " Enable it
set wildignorecase              " Who needs case anyways
set wildmode=list:longest,full  " Wildmenu display options

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
set noswapfile
set nobackup

" No annoyances
set novisualbell        " No blinking
set noerrorbells        " No noise
set vb t_vb=            " Disable any beeps or flashes on error

" Folding
set foldenable          " Enable folding
set foldmethod=indent   " Fold by indent
set foldlevelstart=20   " Don't automatically fold opened files

" Key Bindings

" Leader
map <leader> <space>

" Cleans hilighted text after search
nmap <silent> <leader>/ :nohlsearch<CR>

" set syntax on after vim-plug does it's thing
filetype plugin indent on
syntax on " Enable syntax highlighting
