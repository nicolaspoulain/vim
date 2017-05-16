" Modeline and Notes {
" vim:tw=78 foldmarker={,} foldlevel=0 foldmethod=marker nospell :
" ======================================================
"   This is the personal .vimrc file of Nicolas Poulain.
" ------------------------------------------------------
" Instalation :
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Launch vim with this .vimrc, then :BundleInstall
" sudo apt-get install build-essential cmake python-dev python3-dev
" cd ~/.vim/bundle/YouCompleteMe && ./install.py
" ======================================================
" }

" Bundle Vundle setup BEGIN {
" The next lines ensure that the ~/.vim/bundle/ system works
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" }

" VIM-MUCOMPLETE : Chained completion that works the way you want! {
Plugin 'lifepillar/vim-mucomplete'
set completeopt+=menuone
let g:mucomplete#chains = {}
let g:mucomplete#chains.default=['path', 'ulti', 'incl', 'omni', 'uspl']
let g:mucomplete#chains.markdown = ['path', 'ulti', 'incl', 'omni']

" vim 7 doesn't support noinsert and noselect options for completeopt
if v:version >= 800
  set shortmess+=c
  set completeopt+=noinsert
  set completeopt+=noselect
  let g:mucomplete#enable_auto_at_startup = 1
endif
" }
" ULTISNIPS/VIM-SNIPPETS - The ultimate snippet solution for Vim {
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

if has('python')
  let g:UltiSnipsUsePythonVersion = 2
elseif has('python3')
  let g:UltiSnipsUsePythonVersion = 3
endif

let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-snippets"]
let g:UltiSnipsExpandTrigger="<C-J>"
let g:UltiSnipsJumpForwardTrigger="<C-J>"
let g:UltiSnipsJumpBackwardTrigger="<C-K>"
" }
" TABULAR : Configurable, flexible, intuitive text aligning {
" --- BEFORE plasticboy
Plugin 'godlygeek/tabular'
"}
" VIM-SIGNATURE : place, toggle and display marks {
Plugin 'kshenoy/vim-signature'
"}
" VIM-SURROUND : deleting, changing, and adding surroundings {
Plugin 'tpope/vim-surround'
"}
" SYNTASTIC : Syntax checking on the fly has never been so pimp {
Plugin 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"}
" NERDCOMMENTER : Vim plugin for intensely orgasmic commenting {
Plugin 'scrooloose/nerdcommenter'
let NERDCommentWholeLinesInVMode=1
let NERDRemoveExtraSpaces=1
let NERDSpaceDelims=1
"}
" CTRLP : Fuzzy file, buffer, mru, tag, ... finder {
Plugin 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" r - the nearest ancestor that contains a .git directory
" a - the directory of the current file, but only if the current working
" directory outside of CtrlP is not a direct ancestor of the directory of
" the current file.
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|~)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
"}
" VIM-FUGITIVE : A Git wrapper so awesome, it should be illegal {
Plugin 'tpope/vim-fugitive'
nnoremap ,gg :Gstatus<CR>
nnoremap ,gp :Gpush<CR>
"}
" VIM-GITGUTTER : shows a git diff in the gutter and stages/reverts hunks {
Plugin 'airblade/vim-gitgutter'
"}
" VIM-AIRLINE : Lean and mean status/tabline that's light as air {
Plugin 'bling/vim-airline'
" the last windows always have a status-line
set laststatus=2
" pretty display
let g:airline_symbols = {}
let g:airline_symbols.linenr = 'Ξ'
let g:airline_symbols.branch = '⎇'
let g:airline_mode_map = {'n' : 'N', 'i' : 'I',} " Short mode
let g:airline#extensions#tabline#enabled = 1     " Enable the list of buffers
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
" Change airline display
function! AirlineInit()
  " Only branch (no hunks)
  let g:airline_section_b = airline#section#create(['branch'])
  " full path %F instead of filename %f
  call airline#parts#define_raw('myft', ' ≈%{&filetype}')
  call airline#parts#define_accent('myft', 'italic')
  let g:airline_section_c = airline#section#create(['%F', 'myft'])
  " Do not display fileencoding
  let g:airline_section_x =''
  let g:airline_section_y =''
  call airline#parts#define_raw('linenr', '%l')
  call airline#parts#define_accent('linenr', 'bold')
  let g:airline_section_z = airline#section#create(['%3p%% ', g:airline_symbols.linenr, 'linenr', ':%c'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
" }
"MARKDOWN {
if v:version > 703
  " Plugin 'vim-pandoc/vim-pandoc'
  " Plugin 'vim-pandoc/vim-pandoc-syntax'
  Plugin 'plasticboy/vim-markdown'
  set conceallevel=2
" Plugin 'prurigro/vim-markdown-concealed'
endif
"}
" VIMTEX {
Plugin 'lervag/vimtex'
let g:vimtex_compiler_latexmk = {'callback' : 0}
"}
" TMUX-NAVIGATOR : Seamless navigation between tmux panes and vim splits {
Plugin 'christoomey/vim-tmux-navigator'
"}
" NERDTREE : A tree explorer plugin for vim {
Plugin 'scrooloose/nerdtree'
nnoremap ,n  :NERDTreeToggle<CR>
"}
" TAGBAR : Vim plugin that displays tags in a window, ordered by scope {
Plugin 'majutsushi/tagbar'
nmap ,t :TagbarToggle<CR>
" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '/opt/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
"}
" VIM-TWIG : Twig syntax highlighting, snipMate, auto-indent, etc. {
Plugin 'lumiliet/vim-twig'
"}
" PAPERCOLOR-THEME {
Plugin 'NLKNguyen/papercolor-theme' " colorscheme PaperColor
Plugin 'pbrisbin/vim-colors-off'    " colorscheme off
Plugin 'vim-scripts/xoria256.vim'   " colorscheme xoria256
Plugin 'tomasr/molokai'             " colorscheme molokai
set t_Co=256        " Colors in the terminal
set background=dark
"}

" Plugin Vundle setup END {
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }

" General settings {

let mapleader=','      " change map leader from \ to ,
let maplocalleader=',' " change map leader from \ to ,

" Automatically change the current directory
autocmd BufEnter * silent! lcd %:p:h

" color the 81st column of wide lines
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

set number          " display line numbers
set numberwidth=4   " nuw: width of number column
set showcmd         " display incomplete commands
set scrolloff=4     " keep 4 lines between current line and screen edge
set sidescrolloff=2 " keep 2 cols between the current col screen edge
set list " Show invisible characters
let &listchars = "tab:>-,trail:\u2591,extends:>,precedes:<,nbsp:\u00b7"

set wrap            " wrap lines (we map leader-W to toggle)
nmap <leader>W :set invwrap<CR>:set wrap?<CR>
" Moving around long lines made easy if wrap is on
map j gj
map k gk

" command! -nargs=1 Silent | execute ':silent !'.<q-args> | execute ':redraw!' | execute ':set autoread'

"}
" Tabulations and shift {
set tabstop=2         " number of spaces that a tab renders as
set shiftwidth=2      " number of spaces to use for autoindent
set softtabstop=2     " number of spaces that tabs insert
set expandtab         " uses spaces whent tab is inserted
set smarttab          " helps with backspacing because of expandtab
set backspace=2       " make backspace work like most other apps
set smartindent       " indent is automatically and smartly inserted
set autoindent        " autoindent should be on when using 'smartindent'.
set pastetoggle=<F12> " pastetoggle (sane indentation on pastes)
" }
" Filetype {
filetype on              " enable file type detection
filetype plugin on       " load the plugin files for specific file types
filetype indent on       " load the indent file for specific file types
let g:tex_flavor='latex' " Prevent vim from setting filetype to `plaintex`
syntax enable            " active la coloration syntaxique

" comments in italic
highlight Comment cterm=italic

" Enable Syntax Highlighting for special filetypes
if has("autocmd")
  augroup module "For Drupal
    " autocmd BufRead,BufNewFile *.twig set filetype=phtml
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.php set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
    autocmd BufRead,BufNewFile *.engine set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.md   set filetype=markdown
    autocmd BufRead,BufNewFile *.md   set spell! spelllang=fr
  augroup END
endif


hi SpellBad ctermfg=015 ctermbg=000 cterm=none guifg=#FFFFFF guibg=#000000
" Highlight trailing whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red
let a = matchadd('ExtraWhitespace', '\s\+$')


"}
" Folds {
set foldmethod=syntax " fdm: fold by the indentation by default
set foldnestmax=10    " fdn: deepest fold is 10 levels
"set nofoldenable      " nofen: don't fold by default
set foldlevel=1
" save and restore folds
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview


" }
" Splits and Buffers{

" Move between buffers
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

" move x buffer in a vsplitted window
nnoremap <leader>w :call VerticalSplitBuffer(input('Vsplit buffer No: '))<CR>
function VerticalSplitBuffer(buffer)
  execute "vert belowright sb" a:buffer
endfunction


set splitright " Puts new vsplit windows to the right of the current
set splitbelow " Puts new split windows to the bottom of the current
" Key repeat hack for resizing splits, i.e., <C-w>+++- vs <C-w>+<C-w>+<C-w>-
" see: http://www.vim.org/scripts/script.php?script_id=2223
nmap <C-w>+ <C-w>+<SID>ws
nmap <C-w>- <C-w>-<SID>ws
nmap <C-w>> <C-w>><SID>ws
nmap <C-w>< <C-w><<SID>ws
nnoremap <script> <SID>ws+ <C-w>+<SID>ws
nnoremap <script> <SID>ws- <C-w>-<SID>ws
nnoremap <script> <SID>ws> <C-w>><SID>ws
nnoremap <script> <SID>ws< <C-w><<SID>ws
nmap <SID>ws <Nop>

" Split into 2 continuous columns
:noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
"}
" Search {
set incsearch  " incremental searching : search as you type
set hlsearch   " Highlight search matches
set ignorecase " Ignore case in search patterns
set smartcase  " Case sensitive if pattern contains upper case characters
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
"set showmatch       " show matching brackets "(:),{:},[:]"
"set matchpairs+=<:> " add "<:>" as a matching pair
let loaded_matchparen = 1 " do not show matching brackets
"}
"Misc {

fun! StripTrailingWhitespace()
    " Don't strip on these filetypes
    if &ft =~ 'markdown\|perl'
        return
    endif
    %s/\s\+$//e
endfun
" remove trailing spaces on save
autocmd BufWritePre * call StripTrailingWhitespace()

" load vimrc
map <leader>s :e ~/.vim/vimrc<CR>

" Toggle Display VimMyTips.md
function OpenVMT()
  vsp ~/.vim/VimMyTips.md
  vertical resize 74
  call cursor(40,1)
  normal! zz
endfunction
map vv :call OpenVMT()<CR>
autocmd BufRead  VimMyTips.md map vv :q<CR>
autocmd BufLeave VimMyTips.md map vv :call OpenVMT()<CR>

" Allow writing via sudo
cnoremap W w !sudo tee > /dev/null %

function IndentPHPHTML()
  set ft=phtml
  normal gg=G
  set ft=php
endfunction


" Move lines up/down
" nnoremap <C-j> :m .+1<CR>==
" nnoremap <C-k> :m .-2<CR>==
" inoremap <C-j> <Esc>:m .+1<CR>==gi
" inoremap <C-k> <Esc>:m .-2<CR>==gi
" vnoremap <C-j> :m '>+1<CR>gv=gv
" vnoremap <C-k> :m '<-2<CR>gv=gv
"}
"Wildmenu settings {
set wildmenu            " Turn on the Wild menu for completion on opening files
set wildignore+=*.~     "wig: ignore compiled objects and backups
set wig+=*.o,*.obj,*.pyc
set wig+=.sass-cache,tmp
" <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full
"}
" History, swap and undo settings {
set history=100   " how many lines of history VIM has to remember
set nobackup      " in this age of version control, who needs it
set nowritebackup " don't make a backup before overwriting
set noswapfile    " don't litter swap files everywhere

" Change working directory to the directory of the open buffer.
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" undo
if has('persistent_undo')
  " save/restore undo history to/from an undo file :
  " see InitializeDirectories() function
  set undofile
  " maximum number of changes that can be undone
  set undolevels=1000
endif

" Return to last edit position when opening files
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |   exe "normal! g`\"" | endif

" https://gist.github.com/tpope/287147
" for tables like this
"  | aa | bb | cc |
"  | a  | b  | c  |
"  see http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
"}
"

" LIGHTLINE : A light and configurable statusline/tabline for vim {
" Plugin 'itchyny/lightline.vim'
" Plugin 'taohex/lightline-buffer'
set hidden  " allow buffer switching without saving
set showtabline=2  " always show tabline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }


" use lightline-buffer in lightline
let g:lightline = {
\ 'tabline': {
 \ 'left': [ [ 'bufferinfo' ], [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
 \ 'right': [ [ 'close' ], ],
 \ },
\ 'component_expand': {'buffercurrent': 'lightline#buffer#buffercurrent2', },
\ 'component_type': { 'buffercurrent': 'tabsel', },
\ 'component_function': {
 \ 'bufferbefore': 'lightline#buffer#bufferbefore',
 \ 'bufferafter': 'lightline#buffer#bufferafter',
 \ 'bufferinfo': 'lightline#buffer#bufferinfo',
 \ },
\ }
" lightline-buffer ui settings
" replace with ascii characters if your environment does not support unicode
let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = ' '
" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1
let g:lightline_buffer_rotate = 0
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_excludes = ['vimfiler']
"
let g:lightline_buffer_maxflen = 30
let g:lightline_buffer_maxfextlen = 3
let g:lightline_buffer_minflen = 16
let g:lightline_buffer_minfextlen = 3
let g:lightline_buffer_reservelen = 20
"}

