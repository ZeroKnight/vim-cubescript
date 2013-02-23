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

syn keyword CSbasicCommands     alias at case casef cases clearsleep complete concat concatword cond conout conskip do echo error escape exec exists filter format history if indexof inputcommand keymap listclients listcomplete listdel listfind listlen listsplice local loop loopconcat loopconcatword loopfiles looplist loopwhile nodebug onrelease precf prettylist push quit resetvar result saycommand searchbinds searcheditbinds searchspecbinds setcomplete setdesc setinfo setpersist setpriv shrinklist sleep strcasecmp strcmp strlen strncasecmp strncmp strreplace strstr sublist substr toggleconsole while worldalias writecfg writeobj writevars skipwhite
syn keyword CSbasicGetCommands  getalias getclienthost getclientname getclientnum getclientteam getcolour getfps getfvarmin getfvarmax getmillis getmodel getname getstate getteam getteamcolour getteamicon gettime getvar getvardef getvarflags getvariable getvarmin getvarmax getvartype getversion skipwhite
syn keyword CSbindCommands      bind editbind specbind waitbind getbind geteditbind getspecbind getwaitbind skipwhite
syn keyword CSmathCommands      acos asin atan cos div divf exp log2 log10 loge max maxf min minf mod modf pow rnd sin sqrt tan skipwhite
syn keyword CSkeynames          MOUSE1 MOUSE2 MOUSE3 MOUSE4 MOUSE5 MOUSE6 MOUSE7 MOUSE8 MOUSE9 MOUSE10 BACKSPACE TAB CLEAR RETURN PAUSE ESCAPE SPACE EXCLAIM QUOTEDBL HASH DOLLAR AMPERSAND QUOTE LEFTPAREN RIGHTPAREN ASTERISK PLUS COMMA MINUS PERIOD SLASH COLON SEMICOLON LESS EQUALS GREATER QUESTION AT LEFTBRACKET BACKSLASH RIGHTBRACKET CARET UNDERSCORE BACKQUOTE DELETE KP0 KP1 KP2 KP3 KP4 KP5 KP6 KP7 KP8 KP9 KP_PERIOD KP_DIVIDE KP_MULTIPLY KP_MINUS KP_PLUS KP_ENTER KP_EQUALS UP DOWN RIGHT LEFT INSERT HOME END PAGEUP PAGEDOWN F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12 F13 F14 F15 NUMLOCK CAPSLOCK SCROLLOCK RSHIFT LSHIFT RCTRL LCTRL RALT LALT RMETA LMETA LSUPER RSUPER MODE COMPOSE HELP PRINT SYSREQ BREAK MENU skipwhite
syn keyword CSotherGetCommands  getloadweap getmaplist getpointer getserver getvote getweap skipwhite
syn keyword CSguiCommands       guibackground skipwhite


" Operators
syn match CSoperators "[\>\<]=?[fs]?|[+\*\-=]f?|!?=[fs]]?|~|!|\?|[\^\&\|]~?|\|\||\&\&|\<\<|\>\>"

" Integer with possible '-' sign
syn match CSnumber "-?\d\+"

" Octal number with possible '-' sign
syn match CSnumber "-?0\d\+"

" Hexadecimal number with possible '-' sign
syn match CSnumber "-?0x\d\+"

" Floating point number with decimal and possible '-' sign
syn match CSnumber "-?\d\+\.\d*"

" Alias lookup ($items or @items)
syn match CSlookup "[$@]\+\S\+"

" Escape
syn match CSescape "\^[a-zA-Z0-9]"
