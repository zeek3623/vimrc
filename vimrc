"===============================================================================
" VIM Config
"-------------------------------------------------------------------------------
" Plugins managed by VIM's own package manager
"===============================================================================
set nocompatible " Work like vim not vi please

filetype plugin indent on
syntax enable

" Load the matchit plugin (pre-installed with VIM)
"runtime! macros/matchit.vim

" Backspace works like normal...
set backspace=indent,eol,start

" <leader> is now space
let mapleader=" "

" Save having to press shift a lot...
nnoremap ; :

" Times
set updatetime=750
set timeout timeoutlen=3000 ttimeoutlen=100 " Timeout settings (mappings=3s, keycodes=1s)

" Rooter - change to project root when opening project files
let g:rooter_patterns = ['.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/', ',prjroot', 'ref_*/']

"-------------------------------------------------------------------------------
" User Interface
"-------------------------------------------------------------------------------

" Colourscheme
"if has('gui_running')
"  colorscheme molokai-custom
"  "set guifont=Monospace\ 8
"else
"  set t_Co=256
"  colorscheme distinguished
"endif
" Allow color schemes to do bright colors without forcing bold.
"if &t_Co == 8 && $TERM !~# '^linux'
"  set t_Co=16
"endif

" Commands
set showcmd     " Show commands in bottom-right
set cmdheight=2 " show more on the command line
set wildmenu
set history=1000

" Line numbers
set number
set relativenumber

" Scrolling and wrapping
set scrolloff=1
" set sidescrolloff=5
set display+=lastline " Show as much of the last line as possible

" Line/column highlighting
set cursorline         " Highlight the current lin
" Note: hlsearch has a lower priority so the column is not highlighted. Bit annoying.
set colorcolumn=81,133 "Mark end of 80 cols and 132

" Clearly show some formatting such as explicit tabs
set listchars=tab:>- " ,trail:.,extends:>,precedes:< " eol:$
set list

" Don't beep
set visualbell

" Mouse
set mousemodel=popup " behaves more like windows than an xterm. Also popup for spelling fixes
set mouse=a          " allow mouse use in all modes for terminal as well

" Status line (airline used)
set ruler " Not really needed as airline used
set laststatus=2 " Always show

" Spelling. Only turn on locally when wanted (setlocal spell)
set spelllang=en_gb

" airline
"let g:airline_left_sep=''
"let g:airline_right_sep=''
"let g:airline#extensions#tabline#enabled    = 1
"let g:airline#extensions#whitespace#enabled = 0 " Does not seem to work properly... (or as I expect)

" GUI Options
set guioptions-=T " Remove toolbar

" Navigation
" -----------

" Quicker window switching
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"-------------------------------------------------------------------------------
" File/Buffer Handling
"-------------------------------------------------------------------------------

" Swap files - store in common place
let s:swaplocal=$HOME."/tmp/swaps/"
if (!isdirectory(s:swaplocal))
  call mkdir(s:swaplocal,"p")
endif
set dir=$HOME/tmp/swaps//,.

" File I/O
set confirm
set autoread

" Buffers
set hidden " Hide buffers do not close them!

" Ignore certain files for various vim things
set wildignore=*~,*.swp         " temp files
set wildignore+=*.o,*.obj,*.pyc " Object files
set wildignore+=*.so            " Library files
set wildignore+=*.bin           " Binary files
set wildignore+=*.elf,*.ELF     " ELF Files

" Buffer Management
nnoremap <Leader>q :Bdelete<CR>
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>

" Version Control
" ---------------
" Just map some Fugitive commands
nmap <leader>vh :Glog<CR>
nmap <leader>vd :Gdiff<CR>
nmap <leader>vr :Gread<CR>
nmap <leader>vb :Gblame<CR>
nmap <leader>vs :Gstatus<CR>

"-------------------------------------------------------------------------------
" Editing
"-------------------------------------------------------------------------------

" Allow virtual editing in visual block mode
set ve=block

" Sensible indent and tab settings
set autoindent " Consider smartindent but check no negative effects
set smarttab
" Use 2 and no tabs
set shiftwidth=2
set softtabstop=2
set expandtab

" Format. Do not physically wrap lines
set textwidth=0
set formatoptions=roq " Do not wrap and auto-insert comment leaders. Note:
" Note: syntax files often change formatoptions for the file so remove comment wrapping for sure!
au FileType * setlocal formatoptions-=c

" Searching - sensible options :)
set incsearch
set ignorecase
set smartcase
set hlsearch
set gdefault " S/R by default global. Add a /g for single

" Whitespace management
let g:better_whitespace_enabled = 0 " Don't show
let g:strip_whitespace_on_save  = 1 " But strip

" Misc
set nrformats-=octal  " C-A/X should only assume numbers are decimal or hex.
set nostartofline     " Certain movement commands should try to keep the cursor in the same place
set isfname-=, 	      " Remove comma from isfname

" Navigation
" ----------

" Up/Down includes wrapped lines (much more what is expected)
nmap j gj
nmap k gk

" Smart home
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" Alignment
" ---------
vmap <Enter>   <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" Easy Align Delimiters
if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
" - Overwrite '|' to be used in comments
let g:easy_align_delimiters['|'] = {'pattern': '|', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0, 'ignore_groups': ['string']}
" - Align left paren
let g:easy_align_delimiters['('] = {'pattern': '(', 'left_margin': 1, 'right_margin': 0, 'ignore_groups': ['string','comment']}
let g:easy_align_delimiters[']'] = {'pattern': '\[[^\]]\+\]', 'left_margin': 0, 'right_margin': 1, 'ignore_groups': ['string','comment']}
" - Align comments after text only (not headers).
"let g:easy_align_delimiters['/'] = {'pattern': '\S\@<=\s*//',  'left_margin': 0, 'right_margin': 1, 'ignore_groups': ['string']}

"-------------------------------------------------------------------------------
" Misc
"-------------------------------------------------------------------------------

" Use Gutentags for tag handling
let g:gutentags_enabled = 0
let g:gutentags_ctags_tagfile = '.tags'
"let g:gutentags_ctags_exclude

