" Modeline and Notes {
" vim:tw=78 foldmarker={,} foldlevel=0 foldmethod=marker nospell :
" ======================================================
"   This is the personal .vimrc file of Nicolas Poulain.
" ------------------------------------------------------
" Instalation :
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
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

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"}

"CONOLINE :F10: Highlight the line of the cursor{
Bundle 'miyakogi/conoline.vim'
fu! ToggleCurcol ()
  if &cursorcolumn
    set nocursorcolumn
  else
    set cursorcolumn
  endif
endfunction
map <F10> :call ToggleCurcol()<CR>
"}
" TABULAR : Configurable, flexible, intuitive text aligning {
" --- BEFORE plasticboy
Bundle 'godlygeek/tabular'
"}
" EASYMOTION : Vim motions on speed! {
Bundle 'Lokaltog/vim-easymotion'
"}
" VIM-SIGNATURE : place, toggle and display marks {
Bundle 'kshenoy/vim-signature'
"}
" VIM-SURROUND : deleting, changing, and adding surroundings {
Bundle 'tpope/vim-surround'
"}
" SYNTASTIC : Syntax checking on the fly has never been so pimp {
Bundle 'scrooloose/syntastic'
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
Bundle 'scrooloose/nerdcommenter'
let NERDCommentWholeLinesInVMode=1
let NERDRemoveExtraSpaces=1
let NERDSpaceDelims=1
"}
" CTRLP : Fuzzy file, buffer, mru, tag, ... finder {
Bundle 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" r - the nearest ancestor that contains a .git directory
" a - the directory of the current file, but only if the current working
" directory outside of CtrlP is not a direct ancestor of the directory of
" the current file.
let g:ctrlp_working_path_mode = 'ra'
"}
" NERDTREE :F7: A tree explorer plugin that owns your momma! {
Bundle 'scrooloose/nerdtree'
nmap <F7> :NERDTreeToggle<CR>
"}
" NERDTREE-GIT-PLUGIN : A plugin of NERDTree showing git status flags {
Plugin 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ "Unknown"   : "?"
      \ }
"}
" VIM-FUGITIVE : A Git wrapper so awesome, it should be illegal {
Bundle 'tpope/vim-fugitive'
"}
" VIM-GITGUTTER : shows a git diff in the gutter and stages/reverts hunks {
Bundle 'airblade/vim-gitgutter'
"}
" VIM-AIRLINE : Lean and mean status/tabline that's light as air {
Bundle 'bling/vim-airline'
" the last windows always have a status-line
set laststatus=2
" pretty display
let g:airline_symbols = {}
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
" }
" TAGBAR :F8: Display tags of a file ordered by scope {
if executable('ctags')
  Bundle 'majutsushi/tagbar'
  let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
        \ 'h:headings',
        \ 'l:links',
        \ 'i:images'
        \ ],
        \ "sort" : 0
        \ }
  nmap <F8> :TagbarToggle<CR>
endif
"}
" SUPERTAB : Perform all your vim insert mode completions with Tab {
Bundle 'ervandew/supertab'
"}

" Bundle Vundle setup END {
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }

" General settings {
" ESC mapped to jk or kj
inoremap jk <Esc>
inoremap kj <Esc>

set t_Co=256        " Colors in the terminal
colorscheme elflord
" color the 81st column of wide lines
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

set number          " display line numbers
set numberwidth=5   " nuw: width of number column
set showcmd         " display incomplete commands
set scrolloff=4     " keep 4 lines between current line and screen edge
set sidescrolloff=2 " keep 2 cols between the current col screen edge
let mapleader=','   " change map leader from \ to ,
let maplocalleader=','   " change map leader from \ to ,
set list " Show invisible characters
let &listchars = "tab:>-,trail:\u2591,extends:>,precedes:<,nbsp:\u00b7"

set wrap            " wrap lines (we map leader-W to toggle)
nmap <leader>W :set invwrap<CR>:set wrap?<CR>
" Moving around long lines made easy if wrap is on
map j gj
map k gk

command! -nargs=1 Silent
      \ | execute ':silent !'.<q-args>
      \ | execute ':redraw!'
      \ | execute ':set autoread'

"}
" Tabulations and shift {
set tabstop=2         " number of spaces that a tab renders as
set shiftwidth=2      " number of spaces to use for autoindent
set softtabstop=2     " number of spaces that tabs insert
set expandtab         " uses spaces whent tab is inserted
set smarttab          " helps with backspacing because of expandtab
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
" Enable Syntax Highlighting for special filetypes
autocmd BufRead,BufNewFile *.twig set filetype=htmljinja
autocmd BufRead,BufNewFile *.md   set filetype=markdown spelllang=fr spell

hi SpellBad ctermfg=015 ctermbg=000 cterm=none guifg=#FFFFFF guibg=#000000



"}
" Folds {
set foldmethod=syntax " fdm: fold by the indentation by default
set foldnestmax=10    " fdn: deepest fold is 10 levels
"set nofoldenable      " nofen: don't fold by default
set foldlevel=1
" }
" Splits, Tabs and Buffers{

" Move between tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
" Move between buffers
nnoremap <F2> :bnext<CR>
nnoremap <F3> :bprevious<CR>

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
set showmatch       " show matching brackets "(:),{:},[:]"
set matchpairs+=<:> " add "<:>" as a matching pair
"}
"Misc {
"
" Toggle Display VimMyTips.md
function OpenVMT()
  vsp ~/.vim/VimMyTips.md
  vertical resize 74
  call cursor(40,1)
  normal! zz
endfunction

map hh :call OpenVMT()<CR>
autocmd BufRead  VimMyTips.md map hh :q<CR>
autocmd BufLeave VimMyTips.md map hh :call OpenVMT()<CR>


" Allow writing via sudo
cnoremap w!! w !sudo tee > /dev/null %


" Move lines up/down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
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
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
"}
" Setting up the directories {
function! InitializeDirectories()
  let parent = $HOME
  let prefix = '.vim'
  " with  prefix = 'my/dir/prefix_ this will create
  "  ~/my/dir/prefix_backup,     ~/my/dir/prefix_views
  "  ~/my/dir/prefix_swap   and  ~/my/dir/prefix_undo
  let dir_list = {
        \ 'backup': 'backupdir',
        \ 'views': 'viewdir',
        \ 'swap': 'directory' }

  if has('persistent_undo')
    let dir_list['undo'] = 'undodir'
  endif

  let common_dir = parent . '/' . prefix

  for [dirname, settingname] in items(dir_list)
    let directory = common_dir . dirname . '/'
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif
    if !isdirectory(directory)
      echo "Warning: Unable to create backup directory: " . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction
call InitializeDirectories()
" }
