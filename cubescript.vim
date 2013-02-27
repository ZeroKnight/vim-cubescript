" Vim syntax file
" Language: Cube Engine, CubeScript (See http://cubeengine.com)
" Tailored mostly to Red Eclipse (See http://redeclipse.net)
"
" Maintainer: Alex "ZeroKnight" George (xzeroknightx@gmail.com)
" Last change:

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

" need something that will check if [cfg] is being used, and clear it, and use
" this instead

" ===== Statements ============================================
syn keyword cubescriptConditional       if cond
syn keyword cubescriptRepeat            loop loopconcat loopconcatword loopfiles looplist loopwhile while
syn keyword cubescriptLabel             case casef cases

syn keyword cubescriptStatement         alias clearsleep do exec exists history local push result

syn keyword cubescriptStatementString   concat concatword conout echo error escape filter format strcasecmp strcmp strlen strncasecmp strncmp strreplace strstr substr
syn keyword cubescriptStatementList     at indexof listdel listfind listlen listsplice prettylist shrinklist sublist

syn keyword cubescriptStatementGet      getalias getclientcolour getclienthandle getclienthost getclientmodel getclientname getclientnum getclientpriv getclientteam getclientvanity getclientvitem getdemo getfps getfvarmin getfvarmax getintermission getloadweap getload getmap getmaplist getmillis getmodelname getname getplayercolour getplayermodel getplayername getplayerstate getplayerteam getplayerteamcolour getplayerteamicon getplayervanity getplayervitem getpointer getreptex getseltex getserver gettex gettexname gettime getvanity getvar getvardef getvarflags getvariable getvarmin getvarmax getvartype getversion getvote getweap

syn keyword cubescriptStatementBind     bind editbind specbind waitbind getbind geteditbind getspecbind getwaitbind searchbinds searcheditbinds searchspecbinds searchwaitbinds keymap onrelease

syn keyword cubescriptStatementGui      guibackground guibar guibitfield guibgcolour guiblend guibody guibordercolour guibutton guicheckbox guiclicktab guicount guicursortex guieditor guifield guifont guiheader guiimage guikeyfield guilinesize guilist guilistslider guimodify guinameslider guinoautotab guinohitfx guimodelpreview guioverlaytex guipasses guiplayerpreview guiprogress guiradio guirolloveraction guirolloverimgaction guirolloverimgpath guirollovername guiscaletime guisepsize guishadow guishowtitle guislice guislider guislidertex guispring guistayopen guistrut guitab guitext guititle

syn keyword cubescriptTodo              contained TODO FIXME NOTE


" ===== Operators =============================================
syn keyword cubescriptOperators         acos asin atan cos div divf exp log2 log10 loge max maxf min minf mod modf pow precf rnd sin sqrt tan
" Bitwise
syn match   cubescriptOperators         /[|&\^]~?\|>>\|<</
" Boolean/Ternary
syn match   cubescriptOperators         /||\|&&\|\?/
" Equality
syn match   cubescriptOperators         /[!><\*+\-=]\+[fs]?/

" ===== Numbers ===============================================
" Integer with possible '-' sign
syn match   cubescriptNumber            /-?\d\+/
" C-Style Octal number with possible '-' sign
syn match   cubescriptNumber            /-?0\d\+/
" Hexadecimal number with possible '-' sign
syn match   cubescriptNumber            /-?0x\d\+/
" Floating point number with decimal and possible '-' sign
syn match   cubescriptNumber            /-?\d\+\.\d*/

" ===== Expandable Variables ==================================
" Alias lookup (eg. $items, @items, @@@stuff)
" NOTE: May need to get creative for things like @[...], @[$foo@bar], etc
syn match   cubescriptIdentifier        /(\$\+\|@\+)[^\$@\s]\+/
" Format Argument (used with `format` commmand)
syn match   cubescriptFormatArg         /%\d/ contained

" ===== Escape Sequences ======================================
" Escapes
syn match   cubescriptEscape            /\^[ntf\^\"]/
" Basic color escape (ie. ^fy, ^f2, etc) 
syn match   cubescriptEscapeCol         /\^f[a-zA-Z0-9]/
" Blinking color escape (ie. ^fzgp)
syn match   cubescriptEscapeColBlink    /\^fz[a-zA-Z0-9]{1}/
" Advanced color escape (RGB/Hex Sequence)
syn match   cubescriptEscapeColAdv      /\^f\[(0x)?[a-fA-F0-9]\+\]/
" Image insertion escape (ie. ^f(textures/bomb))
syn match   cubescriptEscapeImg         /\^f\(\S\+\)/


" Comment
syn match   cubescriptComment           ///.*$/ contains=cubescriptTodo


" Strings
syn region  cubescriptString            start=/"/ skip=/\^"/ end=/"/ transparent contains=cubescriptEscape,cubescriptFArg
" Blocks
syn region  cubescriptBlock             start=/\[/ end=/\]/ transparent


syn sync    ccomment                    cubescriptComment

" NOTE: Link this to 'Constant'
syn keyword cubescriptKeyNames          MOUSE1 MOUSE2 MOUSE3 MOUSE4 MOUSE5 MOUSE6 MOUSE7 MOUSE8 MOUSE9 MOUSE10 BACKSPACE TAB CLEAR RETURN PAUSE ESCAPE SPACE EXCLAIM QUOTEDBL HASH DOLLAR AMPERSAND QUOTE LEFTPAREN RIGHTPAREN ASTERISK PLUS COMMA MINUS PERIOD SLASH COLON SEMICOLON LESS EQUALS GREATER QUESTION AT LEFTBRACKET BACKSLASH RIGHTBRACKET CARET UNDERSCORE BACKQUOTE DELETE KP0 KP1 KP2 KP3 KP4 KP5 KP6 KP7 KP8 KP9 KP_PERIOD KP_DIVIDE KP_MULTIPLY KP_MINUS KP_PLUS KP_ENTER KP_EQUALS UP DOWN RIGHT LEFT INSERT HOME END PAGEUP PAGEDOWN F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12 F13 F14 F15 NUMLOCK CAPSLOCK SCROLLOCK RSHIFT LSHIFT RCTRL LCTRL RALT LALT RMETA LMETA LSUPER RSUPER MODE COMPOSE HELP PRINT SYSREQ BREAK MENU
