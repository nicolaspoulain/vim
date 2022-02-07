" Modeline and Notes {
" vim:tw=78 foldmarker={,} foldlevel=0 foldmethod=marker nospell :
" ======================================================
"   This is the personal .vimrc file of Nicolas Poulain.
" ------------------------------------------------------
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
" ======================================================
" }
set nocompatible            " disable compatibility to old-time vi
let mapleader=','      " change map leader from \ to ,
let maplocalleader=';' " change map leader from \ to ,

" Plugin Section
call plug#begin('~/.config/nvim/plugged')
" STARTIFY {
Plug 'mhinz/vim-startify'
"}
" VIM-FUGITIVE : A Git wrapper so awesome, it should be illegal {
Plug 'tpope/vim-fugitive'
nnoremap <Leader>gg :Git<CR>
nnoremap <Leader>gp :Gpush<CR>
"}
" NERDTREE : A tree explorer plugin for vim {
Plug 'scrooloose/nerdtree'
nnoremap <Leader>e  :NERDTreeToggle<Cr>
nnoremap <C-e>  :NERDTreeToggle<Cr>
"}
" FZF fuzzy find {
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
nnoremap <C-g> :GFiles<Cr>
nnoremap <C-p> :Files<Cr>
nnoremap <C-b> :Buffers<Cr>
nnoremap <leader>ff :Ag<Cr>
"}
" TABULAR : Configurable, flexible, intuitive text aligning {
" --- BEFORE plasticboy
Plug 'godlygeek/tabular'
"}
" EASYMOTION : vim motion on speed {
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Move to line
map  <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
"}
" VIM-SIGNATURE : place, toggle and display marks {
Plug 'kshenoy/vim-signature'
"}
" NERDCOMMENTER {
Plug 'preservim/nerdcommenter'
"}
" TAGBAR : tags of file and structure overview {
Plug 'preservim/tagbar'
nmap <F8> :TagbarToggle<CR>
nmap <leader>t :TagbarToggle<CR>
"}
" VIM-AIRLINE : Lean and mean status/tabline that's light as air {
Plug 'bling/vim-airline'
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
" COC : Conquer Of Completion {
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"}
" Spécial Markdown {
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
filetype plugin on
"Uncomment to override defaults:
"let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
nnoremap <localleader>e :! evince %:p:r.pdf &<CR>
nnoremap <localleader>v :InstantMarkdownPreview " run instant_markdown
nnoremap <localleader>p :w <bar> :!/home/nico/Dropbox/Applications/neutriNote/notes/compile.sh -p -- %<CR>     " compile pdf from md
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_mermaid = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1


" MARKDOWN : Syntax highlighting, matching rules and mappings
if v:version > 703
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    " Plugin 'plasticboy/vim-markdown'
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
autocmd BufRead,BufNewFile *.md   set textwidth=80
autocmd BufRead,BufNewFile *.md   set formatoptions+=t
"}
" Spécial LaTeX {
" VIMTEX : A modern vim plugin for editing LaTeX files
Plug 'lervag/vimtex'
let g:vimtex_compiler_latexmk = {'callback' : 0}

let g:tex_flavor='latex' " Prevent vim from setting filetype to `plaintex`

autocmd BufRead,BufNewFile *.tex   set spell spelllang=fr
autocmd BufRead,BufNewFile *.tex set wildignore+=*~,*.pdf,*.log,*.aux,*.fls,*.nav,*.snm,*.out,*.idx,*.ing,*.ind,*.ilg
autocmd BufRead,BufNewFile *.tex let g:ctrlp_custom_ignore = {
            \ 'file': '\v(~|\.pdf|\.log|\.aux|\.fls|\.nav|\.snm|\.out|\.idx|\.ing|\.ind|\.ilg)$',
            \ }
" }
call plug#end()

" General settings {
set mouse=v                 " middle-click paste with
set cc=80                  " set an 80 column border for good coding style
set cursorline              " highlight current cursorline
syntax on                   " syntax highlighting
"set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

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

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2


" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif



set wrap            " wrap lines (we map leader-W to toggle)
nmap <Leader>W :set invwrap<CR>:set wrap?<CR>

" Moving around long lines made easy if wrap is on
map j gj
map k gk

" command! -nargs=1 Silent | execute ':silent !'.<q-args> | execute ':redraw!' | execute ':set autoread'

"}
" Tabulations and shift {
set tabstop=2               " number of columns occupied by a tab
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
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
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting

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

" Spécial Python {
autocmd BufNewFile *.py :set omnifunc=python3complete#Complete
autocmd BufEnter *.py :set omnifunc=python3complete#Complete
" }


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
set wildmode=longest,list   " get bash-like tab completions
"}
" History, swap and undo settings {
set history=100   " how many lines of history VIM has to remember
" Some servers have issues with backup files, see #649.
set nobackup      " in this age of version control, who needs it
set nowritebackup " don't make a backup before overwriting
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
set noswapfile    " don't litter swap files everywhere

" Change working directory to the directory of the open buffer.
"nnoremap <Leader>cd :cd %:p:h<cr>:pwd<cr>
" Change to git root directory
nnoremap <leader>cd :exe 'cd '.system('git rev-parse --show-cdup')<CR>

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


" noremap <C-m> :make<BAR>copen<CR>


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

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%'),
  \   <bang>0)

