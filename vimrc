" Modeline and Notes {
" vim:tw=78 foldmarker={,} foldlevel=0 foldmethod=marker nospell :
" ======================================================
"   This is the personal .vimrc file of Nicolas Poulain.
" ------------------------------------------------------
" Instalation :
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Launch vim with this .vimrc, then :BundleInstall
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
let mapleader=','      " change map leader from \ to ,
let maplocalleader=',' " change map leader from \ to ,

" YOUCOMPLETEME : a code-completion engine for Vim {
Plugin 'valloric/youcompleteme'
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
" TODO
Plugin 'freitass/todo.txt-vim'
"}
" VIM-TABLE-MODE : for easy table formatting {
Plugin 'dhruvasagar/vim-table-mode'
let g:table_mode_header_fillchar='='
"<Leader>tm	  to toggle table mode
"<Leader>T    to input delimiter and tabelize visual
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

" Plugin 'w0rp/ale'
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

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
let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" set wildignore+=*~,*.pdf,*.log,*.aux,*.fls,*.nav,*.snm,*.out
" let g:ctrlp_custom_ignore = {
  " \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  " \ 'file': '\v(~|\.pdf|\.log|\.aux|\.fls|\.nav|\.snm|\.out)$',
  " \ 'link': 'some_bad_symbolic_links',
  " \ }
"}
" VIM-FUGITIVE : A Git wrapper so awesome, it should be illegal {
Plugin 'tpope/vim-fugitive'
nnoremap <Leader>gg :Gstatus<CR>
nnoremap <Leader>gp :Gpush<CR>
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
  call airline#parts#define_function('ALE', 'ALEGetStatusLine')
  call airline#parts#define_condition('ALE', 'exists("*ALEGetStatusLine")')
  let g:airline_section_error = airline#section#create_right(['ALE'])
endfunction

autocmd User AirlineAfterInit call AirlineInit()
" }
" NERDTREE : A tree explorer plugin for vim {
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" nnoremap <Leader>n  :NERDTreeToggle<CR>
map <Leader>e <plug>NERDTreeTabsToggle<CR>
"}
" EASYTAGS : Automated tag file generation and syntax highlighting of tags {
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
set tags=tags;/
"}
" TAGBAR : Vim plugin that displays tags in a window, ordered by scope {
Plugin 'majutsushi/tagbar'
nmap <Leader>t :TagbarToggle<CR>
" Tagbar et markdown : voir section «Spécial Markdown»
"}
" EASYMOTION : vim motion on speed {
Plugin 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to line
map  <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
"}
" VIM-TWIG : Twig syntax highlighting, snipMate, auto-indent, etc. {
Plugin 'lumiliet/vim-twig'
"}
" VIM-PASTE-EASY : Automatically set paste for you {
Plugin 'roxma/vim-paste-easy'
"}
" PAPERCOLOR-THEME {
" Plugin 'NLKNguyen/papercolor-theme' " colorscheme PaperColor
" Plugin 'pbrisbin/vim-colors-off'    " colorscheme off
Plugin 'vim-scripts/xoria256.vim'   " colorscheme xoria256
" Plugin 'tomasr/molokai'             " colorscheme molokai
set t_Co=256        " Colors in the terminal
set background=dark
"}

" Obsolete {
" STARTIFY : The fancy start screen for Vim and Neovim {
" Plugin 'mhinz/vim-startify'
    " let g:startify_custom_indices = ['f', 'g', 'h']
    " let g:startify_bookmarks = [
            " \ { 'p': '~/Dropbox/Applications/Plain.txt/' },
            " \ { 's': '~/.vim/vimrc' },
            " \ { 'v': '~/.vim/VimMyTips.md' },
            " \ ]
    " let g:startify_list_order = [
            " \ ['   MRU'], 'files',
            " \ ['   Bookmarks'], 'bookmarks'
            " \]
"}
" VIM-MUCOMPLETE : Chained completion that works the way you want! {
" Plugin 'lifepillar/vim-mucomplete'
" set completeopt+=menuone
" set completeopt+=noselect
" let g:mucomplete#enable_auto_at_startup = 1
" let g:mucomplete#chains = {}
" let g:mucomplete#chains.default = ['omni', 'ulti', 'path', 'keyn', 'file', 'incl']
" let g:mucomplete#chains.markdown = ['path', 'ulti', 'incl', 'omni']

" }
" TMUX-NAVIGATOR : Seamless navigation between tmux panes and vim splits {
" Plugin 'christoomey/vim-tmux-navigator'
"}
" BUFKILL : unload, delete or wipe a buffer without closing the window or split {
" Plugin 'qpkorr/vim-bufkill'
"}
" NUMBERS : a plugin for intelligently toggling line numbers {
" Plugin 'myusuf3/numbers.vim'
" }
"}

" Spécial Markdown {
" MARKDOWN : Syntax highlighting, matching rules and mappings
if v:version > 703
  " Plugin 'vim-pandoc/vim-pandoc'
  " Plugin 'vim-pandoc/vim-pandoc-syntax'
  Plugin 'plasticboy/vim-markdown'
  set conceallevel=2
" Plugin 'prurigro/vim-markdown-concealed'
endif
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
autocmd FileType markdown nmap <Leader>t :Toc<CR>
"}
" Spécial LaTeX {
" VIMTEX : A modern vim plugin for editing LaTeX files
Plugin 'lervag/vimtex'
let g:vimtex_compiler_latexmk = {'callback' : 0}

let g:tex_flavor='latex' " Prevent vim from setting filetype to `plaintex`

autocmd BufRead,BufNewFile *.tex   set spell spelllang=fr
autocmd BufRead,BufNewFile *.tex set wildignore+=*~,*.pdf,*.log,*.aux,*.fls,*.nav,*.snm,*.out,*.idx,*.ing,*.ind,*.ilg
autocmd BufRead,BufNewFile *.tex let g:ctrlp_custom_ignore = {
  \ 'file': '\v(~|\.pdf|\.log|\.aux|\.fls|\.nav|\.snm|\.out|\.idx|\.ing|\.ind|\.ilg)$',
  \ }
" }

" Plugin Vundle setup END {
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }

colorscheme xoria256

" General settings {
autocmd BufNewFile *.py :set omnifunc=python3complete#Complete
autocmd BufEnter *.py :set omnifunc=python3complete#Complete

" Automatically change the current directory
autocmd BufEnter * silent! lcd %:p:h

" color the 81st column of wide lines
au BufWinEnter * let w:m2=matchadd('MatchParen', '\%81v', 100)

set number          " display line numbers
set numberwidth=4   " nuw: width of number column
set showcmd         " display incomplete commands
set scrolloff=4     " keep 4 lines between current line and screen edge
set sidescrolloff=2 " keep 2 cols between the current col screen edge
set list " Show invisible characters
" set listchars = tab:▸\ ,nbsp:\u00b7,trail:\u2591,extends:>,precedes:<,eol:↲
" set listchars = tab:→\ ,nbsp:␣     ,trail:░     ,extends:>,precedes:<
set showbreak=↪\
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

set wrap            " wrap lines (we map leader-W to toggle)
nmap <Leader>W :set invwrap<CR>:set wrap?<CR>

" Moving around long lines made easy if wrap is on
map j gj
map k gk

" command! -nargs=1 Silent | execute ':silent !'.<q-args> | execute ':redraw!' | execute ':set autoread'

"}
" Tabulations and shift {
set expandtab         " uses spaces whent tab is inserted
set softtabstop=2     " number of spaces that tabs insert
set tabstop=2         " number of spaces that a tab renders as
set shiftwidth=2      " number of spaces to use for autoindent
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
syntax enable            " active la coloration syntaxique

" comments in italic
" highlight Comment cterm=italic

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
    autocmd BufRead,BufNewFile *.md   set spell spelllang=fr
    autocmd BufRead,BufNewFile *.md   set spell spelllang=fr
  augroup END
endif


hi SpellBad ctermfg=015 ctermbg=000 cterm=none guifg=#FFFFFF guibg=#000000


"}
" Folds {
" set foldmethod=syntax " fdm: fold by the indentation by default
" set foldnestmax=10    " fdn: deepest fold is 10 levels
" "set nofoldenable      " nofen: don't fold by default
" set foldlevel=1
" " save and restore folds
" set sessionoptions+=folds
" au BufWinLeave *.* mkview
" au BufWinEnter *.* silent loadview


" }
" Splits and Buffers{

" Move between buffers
nnoremap <Leader>n :bnext<CR>     " next buffer
nnoremap <Leader>p :bprevious<CR> " prev buffer
nnoremap <Leader>, :b#<CR>        " alt  buffer

" move x buffer in a vsplitted window
nnoremap <Leader>s :call VerticalSplitBuffer(input('Vsplit buffer No: '))<CR>
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
" Disable highlight when <Leader><cr> is pressed
map <silent> <Leader><cr> :noh<cr>
"set showmatch       " show matching brackets "(:),{:},[:]"
"set matchpairs+=<:> " add "<:>" as a matching pair
let loaded_matchparen = 1 " do not show matching brackets
"}
"Misc {

" Highlight trailing whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red
let a = matchadd('ExtraWhitespace', '\s\+$')
" remove trailing whitespaces on save
autocmd BufWritePre * call StripTrailingWhitespace()
fun! StripTrailingWhitespace()
    " Don't remove on these filetypes
    if &ft =~ 'markdown\|perl'
        return
    endif
    %s/\s\+$//e
endfun

" load vimrc
map <Leader>s :e ~/.vim/vimrc<CR>

" Toggle Display VimMyTips.md
function OpenVMT()
  vsp ~/.vim/VimMyTips.md
  vertical resize 74
  call cursor(40,1)
  normal! zz
  set nonumber
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
" <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full
"}
" History, swap and undo settings {
set history=100   " how many lines of history VIM has to remember
set nobackup      " in this age of version control, who needs it
set nowritebackup " don't make a backup before overwriting
set noswapfile    " don't litter swap files everywhere

" Change working directory to the directory of the open buffer.
nnoremap <Leader>cd :cd %:p:h<cr>:pwd<cr>

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


" Enable Elite mode, No ARRRROWWS!!!!
let g:elite_mode=1
" Disable arrow movement, resize splits instead.
if get(g:, 'elite_mode')
	nnoremap <Up>    :resize +2<CR>
	nnoremap <Down>  :resize -2<CR>
	nnoremap <Left>  :vertical resize +2<CR>
	nnoremap <Right> :vertical resize -2<CR>
endif



" https://gist.github.com/tpope/287147
" for tables like this
"  | aa | bb | cc |
"  | a  | b  | c  |
"  see http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
" function! s:align()
  " let p = '^\s*|\s.*\s|\s*$'
  " if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    " let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    " let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    " Tabularize/|/l1
    " normal! 0
    " call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  " endif
" endfunction
"}
