" Properties
set encoding=utf8       " Use UTF8 everywhere
set showmatch           " Show matching brackets
set lazyredraw          " Redraw only when we need to
set autoread            " Automatically reload file on external changes
set report=0            " Don't hide messages
set clipboard+=unnamed  " Share clipboard with system clipboard
set hidden              " Don't ask to save when leaving the buffer
set number              " Numbers

" Tabs & Spaces
set expandtab    " Use spaces instead of tabs
set tabstop=4    " A tab is 4 spaces
set autoindent   " Always set autoindenting on
set copyindent   " Copy the previous indentation on autoindenting
set shiftwidth=4 " Number of spaces to use for autoindenting
set smarttab     " Insert tabs on the start of a line

" Backspace
set backspace=indent,eol,start  " Don't limit backspace

" Filetype Specific Settings
augroup filetype_specific
    au!
    au FileType make :setlocal ts=8 sw=8 sts=0 noet
    au BufRead,BufNewFile *.cshtml :setf html
augroup END

" Search
set ignorecase " Ignore case when searching
set smartcase  " Ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch   " Highlight search terms
set incsearch  " Show search matches as you type

" Command Menu Autocompletion
set wildmenu                                     " Enable it
set wildignorecase                               " Who needs case anyways
set wildmode=list:longest,full                   " Wildmenu display options
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " Binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " Compiled object files
set wildignore+=*.spl                            " Compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

" No Annoyances
set novisualbell " No blinking
set noerrorbells " No noise
set vb t_vb=     " Disable any beeps or flashes on error

" Key Bindings
nmap <silent> <leader>/ :nohlsearch<CR> " Cleans hilighted text after search

" Plugins
call plug#begin('~/.vim/bundle')

Plug 'ycm-core/YouCompleteMe'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'frazrepo/vim-rainbow'
let g:rainbow_active=1


" Git
Plug 'airblade/vim-gitgutter'

" Colorschemes
Plug 'w0ng/vim-hybrid'

call plug#end()

" Syntax & Colorschemes
filetype plugin indent on
syntax on
colorscheme hybrid
set background=dark
