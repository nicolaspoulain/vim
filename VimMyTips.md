" vim:tw=78 nospell nonumber norelativenumber:
                          | ENTERING INSERT MODE
------------------------- | ---------------------------------------------
i , a , I , A             | InsertBefore, AppendAfter cursor (I=^i, A=$a)
o , O                     | insert a new line after, before current line
R , r{char}               | Replace instead of insert (r is for one char)
c{motion} , ciw , C , cc  | Change ie delete then insert (C=c$, cc=0C)
s                         | Substitute char on cursor (s is cl)

                          | MOTIONS
------------------------- | ---------------------------------------------
 █k { H  C-U C-B ?str gg  | moves up
0^ Fx Tx b h█l e w tx fx $| moves on line
 G /str C-F C-D L } j █   | moves down
NG (or :N)                | move to line N
f{char} , F{char}         | jump For next,prev {char} (Repeat ;/,)
/{ptrn} , ?{ptrn}         | search   next,prev {ptrn} (Repeat n/N)
%                         | matching brace {}[]()

:h recording              | RECORDING
------------------------- | ---------------------------------------------
q{0-9a-zA-Z"}             | record into reg {0-9a-zA-Z"} (A-Z to append)
q                         | stop recording
[cnt]@{0-9a-zA-Z"}        | exec. content of reg {0-9a-z".=*+} [cnt]times
[cnt]@@                   | repeat the previous @{0-9a-z":*} [cnt] times
"hp , C-R    h            | display recording h normal/insert mode
"hdd                      | record text as action into register h

:h ins-completion         | |MUCOMPLETE| & |ULTISNIPS|
------------------------- | ---------------------------------------------
TAB   (C-H   )            | complete list (try another µcompl chain)
C-J                       | snippet expand & jump
C-X   -C-O                | omnicompletion
C-X   -C-N                | file completion
C-N                       | all buffers completion

                          | SPELL
------------------------- | ---------------------------------------------
zg, zw                    | add word under cursor as good / bad
]s, [s                    | move to next/previous misspelled word

                          | SPLITS |VIM-MAXIMIZER|
------------------------- | ---------------------------------------------
C-W    s , v , q          | split/vspilt/close window
C-W    =   , C-W    _ , | | make Windows same, max height/width
C-W    +-<> , C-W    +++  | resize window
C-W    hjkl , CTRL arrows | focus to far left,down,up,right window
C-W    HJKL               | move current window to far left,down,up,right
map: <Leader>vs           | split long file into 2 continuous windows

                          | BUFFERS
------------------------- | ---------------------------------------------
:e[dit] {file}  :Sex :Vex | open {file} in new, split, vsplit window
:sb x , vsp | bx, (map:,W | x buffer in a (v)splited window
:sball , :bw              | split all buffers , close current buffer
:bn , :bp                 | next/prev buffer (maped to C-→  C-←)

                          | VISUAL MODE ie TEXT BLOCKS
------------------------- | ---------------------------------------------
v , C-V     , V           | Visual mode perChar/ linewise / blockwise
gv                        | visual mode with same area as previous

                          | INSERT ON MANY LINES
------------------------- | ---------------------------------------------
C-V     jjj $ A foo Esc   | insert at end of each line of visual block
C-V     jjj I foo Esc     | insert in the column of visual block

                          | INDENT, AUTOINDENT, FORMAT
------------------------- | ---------------------------------------------
>>  << , C-T     C-D      | shift right left, norml/insrt mode Tabularize
gg=G                      | eventually: set filetype=js + set smartindent
== , =                    | autoIndent current line, current block
Vu , VU , V~              | lowercase, uppercase, toggle entire line
gggug                     | lowercase entire file
gq{motion}                | format the lines that {motion} moves over
gqap                      | format paragraph
[range]J , gJ             | Join [range] lines (insert/remove space)
,W                        | toggle Wrap lines

                          | REGISTERS
------------------------- | ---------------------------------------------
"{a-zA-Z0-9}              | use registr {a-zA-Z0-9} for next delete, yank
                          |    or put (use uppercase char to append with)
"5yy , "hyy               | Yank line into register 5 (or h)
:reg                      | list registers
"5p  , "hp , i C-R    h   | Put register 5 (or h) content after cursor
"_dd                      | Delete to BlackHole don't affect any register

                          | FOLDING COMMANDS
------------------------- | ---------------------------------------------
zR , zM                   | open/close ALL folds (zr, zm not recursive)
zA                        | toggle state of fold (za is not recursive)
zf{motion} , {visual}zf   | creates a fold (e.g zf% fold matching pair)

                          | MARKS (better with |VIM-SIGNATURE|)
------------------------- | ---------------------------------------------
m{a-zA-Z}                 | set/unset mark at cursor position (no motion)
'{a-z} '{A-Z0-9}          | jump to mark in buffer/ file where it was set
'', ``                    | move cursor to last position
C-O   , C-I               | back/forward in jumplist (see :ju)
:marks  : delmarks!       | list, delete current marks

                          | MISC
------------------------- | ---------------------------------------------
.   ,   @:                | repeat last modification/ :command (then @@)
:history                  | list of all your commands
/C-R    C-W               | pull <cword> onto search/command line
ga                        | display hex value of char under cursor
C-V    233                | insert é (ins mode) see :dig for utf8 chars
C-A     , C-X             | add, Substract N to the number after cursor
C-R    =5*5               | insert 25 into text
:set paste :set nopaste   | toggle paste mode (maped to <F12>)
:m :qsort [n]             | sort column 1 [numeric]
:%!sort -t';' -k3 [-n]    | sort column 3 of coma separated [numeric]
:[range]hardcopy > out.ps | send [range] lines (def. all) to printer
:w!!                      | write RO files :w !sudo tee > /dev/null %
g<C-G> , :%s/{ptnr}//gn   | count words, occurences of {ptrn}
:h[elp] {subject}         | {subject} is cmd, i_cmd, v_cmd, c_cmd, :cmd
:helpg[rep]               | search through all help docs
,cd                       | change to open buffer's directory

                          | PLUGINS
------------------------- | ---------------------------------------------
:Gstatus                  | |FUGITIVE| - to un/stage, cc to commit msg
:TagbarToggle             | |TAGBAR| (maped to <Leader>t )
<Leader>n :NERDTreeToggle | |NERDTREE|
,c<Space>  ,  cs          | |NERDCOMMENTER| toggle comment, sexy comment
:Tabularize /x/r0c1l0     | |TABULAR| aligns statements on x
<Leader>tm                | |TABLE_MODE| toggle table mode : | and ||
<Leader>tt                |            tabulize visually selected content
<Leader>f,L,w   ,   s     | |EASYMTION| move to {chr},line,wrd, {chr}{chr}
<C-p>                     | |FZF| search
<C-v>, <C-x>              |     open search in vsplit, hsplit


                          | TEXT-OBJECT and *SURROUND*
--------------------------| ---------------------------------------------
╔╓a<    ┌ a" ┐ ╖      at╗ | Around the delimitor
 <p id= " xy " > abc </p> |    example
  ╚i<    └i"┘ ╝ └ it┘     | Inside the delimitor (t for a pair of tags)
cst<i>                    | <p>abc</p> to <i>abc</i>  |SURROUND|
dst                       | <i>abc</i> to abc            "
viw S" or ysiw"           | abc to "abc"                 "
cs")                      | "abc" to (abc)               "
cs)<p>                    | (abc) to <p>abc</p>          "

                          | RECHERCHE, REMPLACEMENT ET SUPPRESSIONS
--------------------------| ---------------------------------------------
:vimgrep /ptrn/ **        | search files containing ptrn recursively
:vimgrep /ptrn/ **/*.txt  |  idem in txt files
:copen              |  open result lists
* , g*                    | search forwd whole/partial word under cursor
[I                        | display all lines contain word under cursor
:g[!]/{prtn}/[cmd]        | execute [cmd] on lines matching(!NOT) {ptrn}
:g/{ptrn}    , :v/{ptrn}  | display all lines {ptrn} matches/NOT (v=g!)
:g/{ptrn}/#  , :v/{ptrn}/#|   idem with line numbers
:g/^[\.]*$/d              | delete empty lines
:[%]s/{ptrn}/{str}/[flag] | {str} replace {ptrn} on current/|all| line
                          | flags: *c*onfirm, *g*lobal, *i*gnoreCase
:& , :~                   | repeat last substitute
g%                        | normal mode repeat last substitute

:%s/\s\+$//               | supprime les espaces de fin de ligne
:s/foo/bar/               | remplace le 1er  foo de ligne courante par bar
:s/.*\zsfoo/bar/          | remplace dernier foo de ligne courante par bar
:s/foo/bar/g              | remplace tous foo de ligne courante par bar
:%s/foo/bar/g             | remplace TOUS foo du fichier par bar
:%s/foo/bar/gc            | " " idem avec demande de confirmation
:%s/\<foo\>//g            | supprime le mot "foo".
:%s/.*\<foo\>//           | supprime le mot "foo" et ce qui le précède.
:%s/\<foo\>.*//           | supprime le mot "foo" et ce qui le suit.
:%s/.*\ze\<foo\>//        | supprime ce qui précède le mot "foo"
:%s/\<foo\>\zs.*//        | supprime ce qui suit le mot "foo"
:%s/\<foo\>.\{5}//        | supprime "foo" + les 5 catactères qui suivent
:%s#<\_.\{-1,}>##g        | delete html tags possibly multi-line
:%s/<!--\_p\{-}-->//g     | delete multiple line comments
:%s/^\(.*\)\n\1$/\1/      | delete duplicate lines
:%s/^\(.*\)\(\n\1\)\+$/\1/| delete muliple duplicate lines

                          | --- ANCHORS ----
                  ^   $   | start/end of line
                  \<  \>  | beginning/end of a word
                  [ ]     | any characters listet
                  [^ ]    | any characters except those listet

                          | ---- METACARACTÈRES ---
         .                | any character except newline
        \d                | digit character [0-9]
        \a                | alphabetic character [A-Za-z]
        \w                | word character [0-9A-Za-z_]
        \l , \u           | lowercase, uppercase  character
        \p                | printable character
        \s                | whitespace character
        \_\x              | any character of class x, including newline
        Greedy : ^Greedy  | quantifier
        *      : \{-}     | 0 ou plus
        \+     : \{-1}    | 1 ou plus
        \=     : \{-0,1}  | 0 ou 1 fois
        \{n}   :          | n fois exactement
        \{n,}  : \{-n,}   | n fois au moins
        \{,m}  : \{-,m}   | m fois au plus
        \{n,m} : \{-n,m}  | entre n et m fois

                          | ---- REPLACEMENT ----
                 &        | the whole matched pattern
                 \1 \2... | matches text in 1st, 2nd ... pair of \(\)
                 \l  \u   | next char  made lowercase / uppercase
                 \L  \U   | next chars made lowercase / uppercase
                 \E       | end of \U and \L

vim:tw=78:ts=8:ft=help:norl:
