" Vim syntax file
" Language:     Cube2 Engine CubeScript for Red Eclipse v1.4
" Homepage:     https://github.com/ZeroKnight/vim-cubescript
" Last Change:  2014-04-11
" Maintainer:   Alex "ZeroKnight" George <xzeroknightx@gmail.com>
" Contributors:
" Other Thanks: Denilson F. de Sa - CrazyTerabyte <denilson@vialink.com.br>
"                   For 'cube.vim'[1] as a reference and stepping stone.
"               Kevin "Hirato Kirata" Meyer
"                   For his Kate syntax and samples as a reference and
"                   stepping stone.
"               Bram Moolenaar <Bram@vim.org>
"                   For the C syntax file as a reference for some awesome
"                   syntax features
"
" Other Links:  http://cubeengine.com
"               http://redeclipse.net
"               [1]: http://www.vim.org/scripts/script.php?script_id=1042

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

" All commands are lower-case
syn case match

" TBD: Need some way to load this syntax for *.cfg files in a way that isn't
" obtrusive to other non-cubescript *.cfg files

" TBD: How many commands should we keep track of?
" Due to the nature of Red Eclipse commands to change frequently, should we
" bother keeping track of all of them? Or just subsets of "core" and commonly
" used commands?
" Or just keep track of everything anyway...updates to the syntax would be
" easy via pathogen and git submodules

syn keyword cubescriptConditional       if cond
syn keyword cubescriptRepeat            loop loopconcat loopconcatword loopfiles looplist looplistconcat looplistconcatword loopwhile while
syn keyword cubescriptLabel             case casef cases
syn keyword cubescriptStatement         alias clearsleep do exec exists history inputcommand keymap local onrelease push result searchbinds searcheditbinds searchspecbinds searchwaitbinds
syn keyword cubescriptStatementString   concat concatword conout echo error escape filter filterword format strcasecmp strcmp strlen strncasecmp strncmp strreplace strstr substr
syn keyword cubescriptStatementList     at indexof listdel listfind listlen listsplice prettylist shrinklist sublist
syn keyword cubescriptStatementGet      geteditbind getfps getfvarmax getfvarmin getmillis getspecbind gettime getvar getvardef getvarflags getvariable getvarmax getvarmin getvartype getversion getwaitbind
syn keyword cubescriptStatementBind     skipwhite nextgroup=cubescriptKey bind editbind specbind waitbind
syn keyword cubescriptStatementGui      cleargui guibackground guibar guibitfield guibody guiborder guibutton guicheckbox guicount guieditor guifield guifont guiheader guiimage guikeyfield guilist guilistslider guimodelpreview guimodify guinameslider guinohitfx guiplayerpreview guiprogress guiradio guishowbgfx guishowtitle guislice guislider guispring guistayopen guistrut guitab guitext guitextwidth guititle guivisible guivisibletab newcompass newgui showgui showtexgui

" ===== Operators =============================================
" Arithmetic
syn keyword cubescriptOperator         acos asin atan cos div divf exp log2 log10 loge max maxf min minf mod modf pow precf rnd sin sqrt tan
syn match   cubescriptOperator         /[*+-][fs]\?/
" Bitwise
syn match   cubescriptOperator         /\(\~\|[|&^]\~\?\|>>\|<<\)/
" Boolean/Ternary
syn match   cubescriptOperator         /||\|&&\|?/
" Equality
syn match   cubescriptOperator         /\(!\|[<>]=\?[fs]\?\|!\?=[fs]\?\)/

" ===== Numbers ===============================================
syn case ignore
syn match   cubescriptNumbers           display transparent /\<\d\|\.\d/ contains=cubescriptNumber,cubescriptFloat,cubescriptOctalError,cubescriptOctal
" Do not display OctalError in comments
syn match   cubescriptNumbersCom        display contained transparent /\<\d\|\.\d/ contains=cubescriptNumber,cubescriptFloat,cubescriptOctal
" Integer
syn match   cubescriptNumber            display contained /-\?\d\+\>/
" C-Style Octal number, with the first 0 flagged as special (like c.vim)
" TODO: Allow 0 flagging to be toggleable by user (ie. let
" cubescript_no_octal_flag)
syn match   cubescriptOctal             display contained /-\?0\o\+\>/ contains=cubescriptOctalZero
syn match   cubescriptOctalZero         display contained /\<0/
" flag an octal number with digits >7
syn match   cubescriptOctalError        display contained /0\o*[89]\d*/
" C-Style Hexadecimal number
syn match   cubescriptNumber            display contained /-\?0x\x\+\>/
" Floating point number
syn match   cubescriptFloat             display contained /-\?\d\+\.\d*\>/
syn case match

" ===== Identifiers ==================================
" TODO: This is going to need a lot of work to get every stupid obscure case
" properly matched...Start with lots of specifics, then combine as necessary

" Simple lookup, non-nested or recursive ($foo, @bar, etc)
syn match   cubescriptIdentifier        /[$@]\w\+/
" Simple lookup with concatenations ($foo@bar, etc)
syn match   cubescriptIdentifier        contained /[$@]\w\+\(@\?\w\)\+/
" Recursive/nested lookup ($$foo, @@@bar)
syn match   cubescriptIdentifier        /\(\$\+\|\@\+\)\w\+/
" Recursive/nested lookup with concatenations ($$foo@bar, @@@bar@foo)
syn match   cubescriptIdentifier        contained /\(\$\+\|\@\+\)\w\+\(@\?\w\)\+/
" Lookup surrounded with '"' or [] and optional recursive/nested lookup
" NOTE: May need to get clever and use transparency and offsets for hilighting
" since there are nested brackets and whatnot
syn match   cubescriptIdentifier        /\(\$\+\|\@\+\)\(\[\|"\)\([$@]*\)?\w\+\(\]\|"\)/

"syn match   cubescriptIdentifier        /\(\$\+\|@\+\)[$@\S]\+/

" TODO: Special matching for $arg1 to $arg24 (flag > $arg24 as error)

" TODO: ...
" Most of these aren't classed as syntax errors, but as logic errors.
" They can still be used to write perfectly tenable CubeScript.  But they are
" obfuscated and can produce unexpected results. for example $str$str will
" actually look up the alias "str$str" So this is effectively more of a
" warning than anything else You'll be hard pressed to find any of these in
" the wild. -- Kevin "Hirato Kirata" Meyer
" syn match cubescriptIdentifierError ...

" ===== Escape Sequences ======================================
" [:alnum:] used because '\w' matches '_'

" Escapes
syn match   cubescriptEscape            /\^[ntf^"]/
" Basic color escape (ie. ^fy, ^f2, etc)
syn match   cubescriptEscapeCol         /\^f[[:alnum:]]/
" TODO: Same, but with a substitute instead
"syn match   cubescriptEscapeCol         /\^f\(\$/ ...\)/ contains=cubescriptIdentifier,cubescriptIdentifierError
" Blinking color escape (ie. ^fzgp)
syn match   cubescriptEscapeColBlink    /\^fz[[:alnum:]]{2}/
" Advanced color escape (RGB/Hex Sequence)
syn match   cubescriptEscapeColAdv      /\^f\[\(0[xX]\x\+\|\d\+\)\]/
" Image insertion escape (ie. ^f(textures/bomb))
syn match   cubescriptEscapeImg         /\^f(\S\+)/
" Erroneously formed escape sequences
syn match   cubescriptEscapeError       /\^[^ntf^"]/
syn match   cubescriptEscapeError       /\^f[^[:alnum:]]/
syn match   cubescriptEscapeError       /\^fz\([^[:alnum:]]{1,2}\|[[:alnum:]][^[:alnum:]]\)/
" NOTE: may need to explicitly exclude \n along with \X
syn match   cubescriptEscapeError       /\^f\[0[xX]\(\x*\X+\x*\)*\]/
syn match   cubescriptEscapeError       /\^f(\(\S* \S*\)*)/
syn cluster cubescriptEscapeGroups contains=cubescriptEscape,cubescriptEscapeCol,cubescriptEscapeColBlink,cubescriptEscapeColAdv,cubescriptEscapeImg

syn match   cubescriptDelimiter         /;/

" Format Argument (used with `format` commmand)
syn match   cubescriptSpecial           display contained /%[1-9]/

" Comment (C++ one-line style)
syn match   cubescriptComment           display "//.*$" contains=cubescriptTodo

" Various common comment tags
syn keyword cubescriptTodo              contained TODO FIXME XXX NOTE HACK BUG WARNING ATTENTION ALERT DANGER TBD TASK NOTICE TEST DEBUG DEPRECATED ??? !!! WTF

syn cluster cubescriptALL contains=ALLBUT,cubescriptKey

" Strings
" NOTE: CubeScript strings cannot extend over lines, because ';' and '\n'
" denote the end of a call, and strings are automatically closed if needed
syn region  cubescriptString            display transparent oneline start=/"/ skip=/\^"/ end=/"/ contains=cubescriptEscape,cubescriptSpecialChar,@cubescriptEscapeGroups
syn region  cubescriptBlock             start=/\[/ end=/\]/ contains=@cubescriptALL
syn region  cubescriptParen             start=/(/ end=/)/ contains=@cubescriptALL

" Keys do not /have/ to be upper-case
syn case ignore
syn match   cubescriptKey             contained /\<MOUSE[1-9][0-9]{0,2}\>/
syn keyword cubescriptKey             contained BACKSPACE TAB CLEAR RETURN PAUSE ESCAPE SPACE EXCLAIM QUOTEDBL HASH DOLLAR AMPERSAND QUOTE LEFTPAREN RIGHTPAREN ASTERISK PLUS COMMA MINUS PERIOD SLASH 0 1 2 3 4 5 6 7 8 9 COLON SEMICOLON LESS EQUALS GREATER QUESTION AT LEFTBRACKET BACKSLASH RIGHTBRACKET CARET UNDERSCORE BACKQUOTE A B C D E F G H I J K L M N O P Q R S T U V W X Y Z DELETE KP0 KP1 KP2 KP3 KP4 KP5 KP6 KP7 KP8 KP9 KP_PERIOD KP_DIVIDE KP_MULTIPLY KP_MINUS KP_PLUS KP_ENTER KP_EQUALS UP DOWN RIGHT LEFT INSERT HOME END PAGEUP PAGEDOWN F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12 F13 F14 F15 NUMLOCK CAPSLOCK SCROLLOCK RSHIFT LSHIFT RCTRL LCTRL RALT LALT RMETA LMETA LSUPER RSUPER MODE COMPOSE HELP PRINT SYSREQ BREAK MENU POWER EURO UNDO
syn case match

" FIXME: Not yet sure how to properly set this...
" exec "syn sync minlines=" . b:cubescript_minlines  ???
syn sync fromstart

" Define the highlighting
hi def link cubescriptConditional       Conditional
hi def link cubescriptRepeat            Repeat
hi def link cubescriptLabel             Label
hi def link cubescriptStatement         Statement
hi def link cubescriptStatementString   Statement
hi def link cubescriptStatementList     Statement
hi def link cubescriptStatementGet      Statement
hi def link cubescriptStatementBind     Statement
hi def link cubescriptStatementGui      Statement
hi def link cubescriptOperator          Operator
hi def link cubescriptNumber            Number
hi def link cubescriptOctal             Number
hi def link cubescriptOctalZero         PreProc
hi def link cubescriptFloat             Float
hi def link cubescriptIdentifier        Identifier
" WARNING: This may need to be set individually
" Potentially needs better group...however some colorschemes don't actually
" underline and just use a different color (eg. solarized)
hi def link cubescriptEscapeGroups      Underlined
hi def link cubescriptDelimiter         Delimiter
hi def link cubescriptSpecial           Special
hi def link cubescriptComment           Comment
hi def link cubescriptTodo              Todo
hi def link cubescriptString            String
hi def link cubescriptKey               Constant
hi def link cubescriptOctalError        Error
hi def link cubescriptIdentifierError   Error
hi def link cubescriptEscapeError       Error

let b:current_syntax = "cubescript"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: et sts=4 sw=4
