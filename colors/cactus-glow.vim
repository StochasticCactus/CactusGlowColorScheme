" =============================================================================
" Name:        Cactus Glow
" Description: A warm dark scheme blending Gruvbox Material's earthy warmth,
"              Monokai's vibrant syntax punch, and Firefly Pro's catchy neon
"              accents. Designed from scratch for C, C++, Fortran, Python,
"              and Bash — with comprehensive syntax coverage.
" Author:      CactusScheme
" License:     MIT
" Revision:    v1.1 — rebalanced palette: function-calls-via-paren now gold
"              (was wrongly green), namespaces/flags gained cyan,
"              booleans/null moved to pink, and a PascalCase heuristic
"              adds blue type names.
" Revision:    v1.2 — strings/characters moved back onto green (v1.1 had
"              pushed them to icy blue, leaving the scheme too blue-heavy).
" =============================================================================

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "cactus-glow"

" =============================================================================
"  THE PALETTE
" =============================================================================
" Backgrounds (warm dark — Gruvbox DNA, cozy shift)
let s:bg          = "#1c1b19"
let s:bg_alt      = "#151412"
let s:bg_dim      = "#242321"
let s:bg_hl       = "#2e2c29"
let s:bg_visual   = "#3b3735"
let s:bg_menu     = "#2a2826"

" Foregrounds (warm cream — Gruvbox DNA)
let s:fg          = "#ffe0cc"" "#fdbc91" "#faccbe" "#e2d9c8"
let s:fg_alt      = "#c4b9a7"
let s:fg_dim      = "#8a8070"

" Line numbers / gutter
let s:line_nr     = "#5a534a"
let s:line_nr_cur = "#a89c8c"

" Core syntax accent colors
let s:pink        = "#F92672"   " Keywords, control flow, booleans/null (Monokai DNA)
let s:green       = "#42f56f"   " Function definitions            (Monokai DNA)
let s:purple      = "#AE81FF"   " Numbers, constants              (Monokai DNA)
let s:yellow      = "#FABD2F"   " Types (int, integer, real...)   (Gruvbox DNA)
let s:amber       = "#E6B450"   " Built-in constants, decorators  (Firefly DNA)
let s:orange      = "#FD971F"   " Storage classes, identifiers    (Monokai DNA)
let s:frost       = "#6CB8E8"   " Icy blue accent (kept for a couple of UI bits)
let s:cyan        = "#56D4C8"   " Preprocessor, namespaces, flags (NEW — catchy!)
let s:sky_blue    = "#59C2FF"   " Class/struct/type names, +heuristic PascalCase (Firefly DNA)
let s:coral       = "#F07178"   " Member variables, errors        (Firefly DNA)
let s:magenta     = "#FF0077"   " Library/built-in functions      (NEW — vibrant!)
let s:teal        = "#95E6CB"   " Escape chars, regex, specials   (Firefly DNA)
let s:gold        = "#FFB454"   " Function calls                  (Firefly DNA)
let s:hot_orange  = "#FF8F40"   " Method calls, orange accent      (NEW — warm!)
let s:rose_pink   = "#FF6B9D"   " Std I/O objects (cout, cin...)    (NEW — rosy!)
let s:sand        = "#b8a888"   " Variables (warm tan, soft)        (NEW — cozy!)
let s:comment     = "#706856"   " Comments (warm grey, cozy)
let s:delimiter   = "#9a8a78"   " Delimiters, punctuation (warm)

" Diff / diagnostic
let s:diff_add    = "#2a3a1e"
let s:diff_change = "#3a3520"
let s:diff_delete = "#3c1f1e"
let s:error       = "#FF3333"
let s:warn        = "#E6B450"
let s:info        = "#59C2FF"

" =============================================================================
"  HELPER — apply highlight
" =============================================================================
function! s:hi(group, fg, bg, ...)
    let l:style = a:0 >= 1 ? a:1 : "NONE"
    let l:cmd = "hi " . a:group
    if a:fg != ""
        let l:cmd .= " guifg=" . a:fg
    endif
    if a:bg != ""
        let l:cmd .= " guibg=" . a:bg
    endif
    let l:cmd .= " gui=" . l:style
    execute l:cmd
endfunction

" =============================================================================
"  1. UI ELEMENTS
" =============================================================================
call s:hi("Normal",       s:fg,       s:bg)
call s:hi("NormalFloat",  s:fg,       s:bg_menu)
call s:hi("NormalNC",     s:fg_alt,   s:bg)
call s:hi("Cursor",       s:bg,       s:teal)
call s:hi("iCursor",      s:bg,       s:teal)
call s:hi("lCursor",      s:bg,       s:teal)
call s:hi("CursorLine",   "",         s:bg_dim,       "NONE")
call s:hi("CursorColumn", "",         s:bg_dim)
call s:hi("CursorLineNr", s:gold,     s:bg_dim,       "NONE")
call s:hi("LineNr",       s:line_nr,  "")
call s:hi("SignColumn",   s:fg,       s:bg)
call s:hi("FoldColumn",   s:line_nr,  s:bg)
call s:hi("Folded",       s:comment,  s:bg_dim)
call s:hi("VertSplit",    s:bg_hl,    s:bg)
call s:hi("WinSeparator", s:bg_hl,    s:bg)
call s:hi("ColorColumn",  "",         s:bg_dim)
call s:hi("Visual",       "",         s:bg_visual)
call s:hi("VisualNOS",    "",         s:bg_visual)
call s:hi("Search",       s:bg,       s:yellow,       "bold")
call s:hi("IncSearch",    s:bg,       s:coral,        "bold")
call s:hi("CurSearch",    s:bg,       s:gold,         "bold")
call s:hi("MatchParen",   s:bg,       s:gold,         "bold")

" Status / Tab lines
call s:hi("StatusLine",   s:fg_alt,   s:bg_hl)
call s:hi("StatusLineNC", s:fg_dim,   s:bg_dim)
call s:hi("TabLine",      s:fg_dim,   s:bg_dim)
call s:hi("TabLineSel",   s:frost,     s:bg_hl,        "bold")
call s:hi("TabLineFill",  "",         s:bg_alt)
call s:hi("WildMenu",     s:bg,       s:cyan)
call s:hi("Title",        s:gold,     "",             "bold")

" Popup menu
call s:hi("Pmenu",        s:fg_alt,   s:bg_menu)
call s:hi("PmenuSel",     s:bg,       s:cyan)
call s:hi("PmenuSbar",    "",         s:bg_dim)
call s:hi("PmenuThumb",   "",         s:fg_dim)

" Messages & diagnostics
call s:hi("ModeMsg",      s:frost,     "")
call s:hi("MoreMsg",      s:green,    "")
call s:hi("Question",     s:cyan,     "")
call s:hi("WarningMsg",   s:warn,     "",             "bold")
call s:hi("ErrorMsg",     s:error,    s:bg,           "bold")
call s:hi("Error",        s:error,    s:diff_delete)
call s:hi("NonText",      s:bg_hl,    "")
call s:hi("SpecialKey",   s:bg_hl,    "")
call s:hi("Conceal",      s:fg_dim,   "")
call s:hi("Directory",    s:sky_blue, "",             "bold")
call s:hi("EndOfBuffer",  s:bg_dim,   "")

" Diff highlighting
call s:hi("DiffAdd",      "",         s:diff_add)
call s:hi("DiffChange",   "",         s:diff_change)
call s:hi("DiffDelete",   s:coral,    s:diff_delete)
call s:hi("DiffText",     s:bg,       s:amber,        "bold")

" Spell
if has("spell")
    hi SpellBad   guisp=#FF3333 gui=undercurl
    hi SpellCap   guisp=#59C2FF gui=undercurl
    hi SpellLocal guisp=#95E6CB gui=undercurl
    hi SpellRare  guisp=#AE81FF gui=undercurl
endif

" =============================================================================
"  2. GENERAL SYNTAX GROUPS (the backbone)
" =============================================================================

" --- Comments ---
call s:hi("Comment",        s:comment,    "",  "italic")
call s:hi("SpecialComment", s:comment,    "",  "bold,italic")

" --- Constants & Literals ---
call s:hi("Constant",       s:purple,     "",  "bold")
call s:hi("Number",         s:purple,     "")
call s:hi("Float",          s:purple,     "")
call s:hi("Boolean",        s:pink,     "")
call s:hi("Character",      s:green,       "")
call s:hi("String",         s:green,       "")
call s:hi("SpecialChar",    s:teal,       "",  "bold")

" --- Identifiers ---
call s:hi("Identifier",     s:sand,       "")
call s:hi("Function",       s:green,      "")

" --- Method calls (class_cactus.count() — the .count part) ---
call s:hi("Method",         s:hot_orange, "")

" --- Statements / Keywords ---
call s:hi("Statement",      s:pink,       "",  "bold")
call s:hi("Conditional",    s:pink,       "",  "bold")
call s:hi("Repeat",         s:pink,       "",  "bold")
call s:hi("Label",          s:yellow,     "",  "NONE")
call s:hi("Operator",       s:pink,       "")
call s:hi("Keyword",        s:pink,       "",  "bold")
call s:hi("Exception",      s:pink,       "",  "bold")

" --- Namespace (std:: — the std part) ---
call s:hi("Namespace",      s:cyan,     "",  "bold")

" --- Preprocessor ---
call s:hi("PreProc",        s:cyan,       "")
call s:hi("Include",        s:cyan,       "",  "bold")
call s:hi("Define",         s:cyan,       "")
call s:hi("Macro",          s:teal,       "",  "italic")
call s:hi("PreCondit",      s:cyan,       "",  "bold")

" --- Types ---
call s:hi("Type",           s:yellow,     "",  "NONE")
call s:hi("StorageClass",   s:orange,     "",  "italic")
call s:hi("Structure",      s:yellow,     "",  "bold")
call s:hi("Typedef",        s:yellow,     "")

" --- Special ---
call s:hi("Special",        s:teal,       "",  "italic")
call s:hi("Tag",            s:pink,       "",  "italic")
call s:hi("Delimiter",      s:delimiter,  "")
call s:hi("Debug",          s:coral,      "",  "bold")

" --- Built-in / Intrinsic functions (printf, print, abs, etc.) ---
call s:hi("BuiltinFunc",    s:magenta,    "",  "bold")

" --- Misc built-in ---
call s:hi("Underlined",     s:sky_blue,   "",  "underline")
call s:hi("Ignore",         s:fg_dim,     "")
call s:hi("Todo",           s:bg,         s:gold,  "bold")

" =============================================================================
"  3. LANGUAGE-SPECIFIC ENHANCEMENTS
" =============================================================================

" ---------------------------------------------------------------------------
"  C / C++
" ---------------------------------------------------------------------------
" Preprocessor: #include gets the vibrant cyan — catchy and distinct
call s:hi("cInclude",       s:cyan,       "",  "bold")
call s:hi("cIncluded",      s:teal,       "",  "italic")
call s:hi("cPreProc",       s:cyan,       "")
call s:hi("cDefine",        s:cyan,       "")
call s:hi("cPreCondit",     s:cyan,       "",  "bold")

" C types
call s:hi("cType",          s:yellow,     "",  "NONE")
call s:hi("cStorageClass",  s:orange,     "",  "italic")
call s:hi("cStructure",     s:yellow,     "",  "bold")
call s:hi("cConstant",      s:purple,     "",  "bold")

" C statements
call s:hi("cStatement",     s:pink,       "",  "bold")
call s:hi("cConditional",   s:pink,       "",  "bold")
call s:hi("cRepeat",        s:pink,       "",  "bold")
call s:hi("cLabel",         s:yellow,     "")
call s:hi("cOperator",      s:pink,       "")

" C strings and numbers
call s:hi("cString",        s:green,       "")
call s:hi("cCppString",     s:green,       "")
call s:hi("cCharacter",     s:green,       "")
call s:hi("cNumber",        s:purple,     "")
call s:hi("cFloat",         s:purple,     "")
call s:hi("cOctal",         s:purple,     "")
call s:hi("cFormat",        s:teal,       "",  "bold")
call s:hi("cSpecialCharacter", s:teal,    "",  "bold")

" C++ extras
call s:hi("cppType",        s:yellow,     "",  "NONE")
call s:hi("cppStatement",   s:pink,       "",  "bold")
call s:hi("cppAccess",      s:pink,       "")
call s:hi("cppModifier",    s:orange,     "",  "italic")
call s:hi("cppStructure",   s:yellow,     "",  "bold")
call s:hi("cppBoolean",     s:pink,     "")
call s:hi("cppConstant",    s:amber,      "",  "bold")
call s:hi("cppCast",        s:cyan,       "")
call s:hi("cppOperator",    s:pink,       "")
call s:hi("cppExceptions",  s:pink,       "",  "bold")
call s:hi("cppRawString",   s:green,       "")
call s:hi("cppNumber",      s:purple,     "")

" C/C++ custom function match (highlight calls like my_func(...))
augroup CactusGlowCSyntax
    autocmd!
    " Heuristic: PascalCase identifiers (uppercase start, has a lowercase
    " letter somewhere so ALL_CAPS macros/constants are excluded) usually
    " name a user-defined type or class — blue. Defined FIRST so the call/
    " method matchers below still win where a pattern overlaps (e.g. a
    " PascalCase constructor call like Rocket() still counts as a call).
    autocmd FileType c,cpp syntax match cUserType /\<[A-Z]\w*\l\w*\>/
    autocmd FileType c,cpp execute "hi cUserType guifg=" . s:sky_blue
    " Generic word-before-paren match: this can't reliably tell a call
    " from a definition via regex alone, so it now uses gold (the
    " palette's dedicated "function calls" color) rather than green —
    " green stays reserved for the definition-only matches other
    " languages below (Function, pythonFunction, shFunction, etc.)
    autocmd FileType c,cpp syntax match cCustomFunc /\<\w\+\s*(/me=e-1
    autocmd FileType c,cpp execute "hi cCustomFunc guifg=" . s:gold
    " Namespace: match std:: boost:: etc. — the part before :: — now cyan,
    " grouped with preprocessor/include as a "structural" cyan family
    autocmd FileType cpp syntax match cppNamespace /\<\w\+\ze::/
    autocmd FileType cpp execute "hi cppNamespace guifg=" . s:cyan . " gui=bold"
    " Scope resolution :: itself — cyan
    autocmd FileType cpp syntax match cppScopeRes /::/
    autocmd FileType cpp execute "hi cppScopeRes guifg=" . s:cyan
    " Method calls: match .method_name( — the method part after dot
    autocmd FileType c,cpp syntax match cMethodCall /\.\<\w\+\s*(/me=e-1
    autocmd FileType c,cpp execute "hi cMethodCall guifg=" . s:hot_orange
    " Arrow method calls: match ->method_name(
    autocmd FileType c,cpp syntax match cArrowMethod /->\<\w\+\s*(/me=e-1
    autocmd FileType c,cpp execute "hi cArrowMethod guifg=" . s:hot_orange
    " Standard library I/O objects: cout, cin, cerr, clog, endl, etc.
    autocmd FileType cpp syntax keyword cppStdObject cout cin cerr clog endl flush
                \ setw setfill setprecision boolalpha noboolalpha hex dec oct
                \ left right fixed scientific showpoint noshowpoint
                \ ws noskipws skipws uppercase nouppercase
                \ unitbuf nounitbuf showbase noshowbase showpos noshowpos
                \ internal setbase
    autocmd FileType cpp execute "hi cppStdObject guifg=" . s:rose_pink . " gui=bold"
    " Common standard containers / objects used after std::
    autocmd FileType cpp syntax keyword cppStdType string vector map set list array
                \ unordered_map unordered_set pair tuple optional variant any
                \ shared_ptr unique_ptr weak_ptr make_shared make_unique
                \ function bind thread mutex atomic future promise
                \ ifstream ofstream fstream stringstream istringstream ostringstream
                \ regex smatch
    autocmd FileType cpp execute "hi cppStdType guifg=" . s:sky_blue
augroup END

" C member access
hi link cMember Identifier

" ---------------------------------------------------------------------------
"  FORTRAN
" ---------------------------------------------------------------------------
" Type keywords: integer, real, double precision, character, logical, complex
call s:hi("fortranType",          s:yellow,     "",  "NONE")
call s:hi("fortranTypeOb",        s:yellow,     "")
call s:hi("fortranTypeSS",        s:yellow,     "")
call s:hi("fortranTypeR",         s:yellow,     "")
call s:hi("fortranTypeEx",        s:yellow,     "")
call s:hi("fortranExtraIntrinsic",s:yellow,     "")

" Structure keywords: program, module, subroutine, function, end, contains
call s:hi("fortranStructure",     s:pink,       "",  "bold")
call s:hi("fortranCall",          s:pink,       "",  "bold")

" Control flow: do, if, then, else, end if, select case, where
call s:hi("fortranConditional",   s:pink,       "",  "bold")
call s:hi("fortranRepeat",        s:pink,       "",  "bold")
call s:hi("fortranStatement",     s:pink,       "",  "bold")
call s:hi("fortranKeyword",       s:pink,       "",  "bold")

" I/O: read, write, print, open, close, format
call s:hi("fortranReadWrite",     s:magenta,    "",  "bold")
call s:hi("fortranIO",            s:magenta,    "")
call s:hi("fortranUnitHeader",    s:magenta,    "")

" Intrinsic functions: sin, cos, abs, sqrt, mod, etc.
call s:hi("fortranIntrinsic",     s:gold,       "",  "bold")
call s:hi("fortranIntrinsicR",    s:gold,       "",  "bold")

" Use / include
call s:hi("fortranInclude",       s:cyan,       "",  "bold")
call s:hi("fortranUseStatement",  s:cyan,       "",  "bold")

" Strings, numbers, booleans
call s:hi("fortranString",        s:green,       "")
call s:hi("fortranStringDelimit", s:green,       "")
call s:hi("fortranNumber",        s:purple,     "")
call s:hi("fortranFloat",         s:purple,     "")
call s:hi("fortranFloatIll",      s:purple,     "")
call s:hi("fortranBinary",        s:purple,     "")
call s:hi("fortranOctal",         s:purple,     "")
call s:hi("fortranHex",           s:purple,     "")
call s:hi("fortranBoolean",       s:pink,     "")

" implicit, save, intent, parameter, allocatable
call s:hi("fortranStorageClass",        s:orange,  "",  "italic")
call s:hi("fortranStorageClassR",       s:orange,  "",  "italic")
call s:hi("fortranOperator",            s:pink,    "")
call s:hi("fortranTarget",              s:orange,  "")

" Comments
call s:hi("fortranComment",       s:comment,    "",  "italic")
call s:hi("fortranSerialNumber",  s:comment,    "",  "italic")
call s:hi("fortranContinueMark",  s:cyan,       "")
call s:hi("fortranTodo",          s:bg,         s:gold,  "bold")
call s:hi("fortranParenError",    s:error,      "")

" Identifiers / variables / module names
call s:hi("fortranIdentifier",    s:sand,       "")
call s:hi("fortranName",          s:sand,       "")
call s:hi("fortranModule",        s:sky_blue,   "",  "bold")
call s:hi("fortranModuleName",    s:sky_blue,   "")
call s:hi("fortranSubroutineName", s:green,     "")
call s:hi("fortranFunctionName", s:green,       "")
call s:hi("fortranProgramName",  s:sky_blue,    "",  "bold")

" Preprocessor
call s:hi("fortranPreCondit",     s:cyan,       "",  "bold")
call s:hi("fortranCPP",           s:cyan,       "")

" ---------------------------------------------------------------------------
"  PYTHON
" ---------------------------------------------------------------------------
" Keywords: def, class, if, elif, else, for, while, with, as, try, except,
"           finally, raise, return, yield, pass, break, continue, lambda,
"           import, from, global, nonlocal, assert, del, async, await
call s:hi("pythonStatement",    s:pink,       "",  "bold")
call s:hi("pythonConditional",  s:pink,       "",  "bold")
call s:hi("pythonRepeat",       s:pink,       "",  "bold")
call s:hi("pythonException",    s:pink,       "",  "bold")
call s:hi("pythonOperator",     s:pink,       "")
call s:hi("pythonAsync",        s:pink,       "",  "bold,italic")

" Import
call s:hi("pythonImport",       s:cyan,       "",  "bold")
call s:hi("pythonInclude",      s:cyan,       "",  "bold")
call s:hi("pythonFrom",         s:cyan,       "")

" Functions & decorators
call s:hi("pythonFunction",     s:green,      "")
call s:hi("pythonDecorator",    s:amber,      "",  "italic")
call s:hi("pythonDecoratorName",s:amber,      "",  "italic")
call s:hi("pythonDottedName",   s:amber,      "")

" Built-in functions: print, len, range, enumerate, zip, map, filter, etc.
call s:hi("pythonBuiltin",      s:magenta,    "",  "bold")
call s:hi("pythonBuiltinFunc",  s:magenta,    "",  "bold")
call s:hi("pythonBuiltinObj",   s:sky_blue,   "")
call s:hi("pythonBuiltinType",  s:yellow,     "")

" self / cls
call s:hi("pythonSelf",         s:sky_blue,   "",  "italic")
call s:hi("pythonClassVar",     s:sky_blue,   "",  "italic")

" Constants
call s:hi("pythonNone",         s:pink,     "")
call s:hi("pythonBoolean",      s:pink,     "")
call s:hi("pythonConstant",     s:purple,     "",  "bold")

" Strings
call s:hi("pythonString",       s:green,       "")
call s:hi("pythonRawString",    s:green,       "")
call s:hi("pythonQuotes",       s:green,       "")
call s:hi("pythonTripleQuotes", s:green,       "")
call s:hi("pythonEscape",       s:teal,       "",  "bold")
call s:hi("pythonFString",      s:green,       "")
call s:hi("pythonStrFormat",    s:teal,       "")
call s:hi("pythonStrFormatting",s:teal,       "")
call s:hi("pythonStrTemplate",  s:teal,       "")
call s:hi("pythonBytesEscape",  s:teal,       "",  "bold")
call s:hi("pythonDocstring",    s:comment,    "",  "italic")

" Numbers
call s:hi("pythonNumber",       s:purple,     "")
call s:hi("pythonFloat",        s:purple,     "")
call s:hi("pythonHexNumber",    s:purple,     "")
call s:hi("pythonOctNumber",    s:purple,     "")
call s:hi("pythonBinNumber",    s:purple,     "")

" Type hints
call s:hi("pythonTypeHint",     s:yellow,     "",  "italic")

" Class names and variable identifiers
call s:hi("pythonClass",        s:sky_blue,   "")
call s:hi("pythonClassName",    s:sky_blue,   "")
call s:hi("pythonDot",          s:orange,     "")
call s:hi("pythonAttribute",    s:sand,       "")
call s:hi("pythonParam",        s:coral,      "",  "italic")

" Comments
call s:hi("pythonComment",      s:comment,    "",  "italic")
call s:hi("pythonTodo",         s:bg,         s:gold,  "bold")

" Error
call s:hi("pythonError",        s:error,      "")
call s:hi("pythonIndentError",  s:error,      "")
call s:hi("pythonSpaceError",   "",           s:diff_delete)

" Python method calls (obj.method())
augroup CactusGlowPySyntax
    autocmd!
    " Heuristic: PascalCase identifiers are usually classes/types — blue.
    " Defined first so the method-call match below still wins on overlap.
    autocmd FileType python syntax match pythonUserType /\<[A-Z]\w*\l\w*\>/
    autocmd FileType python execute "hi pythonUserType guifg=" . s:sky_blue
    autocmd FileType python syntax match pythonMethodCall /\.\<\w\+\s*(/me=e-1
    autocmd FileType python execute "hi pythonMethodCall guifg=" . s:hot_orange
augroup END

" ---------------------------------------------------------------------------
"  BASH / SHELL
" ---------------------------------------------------------------------------
" Keywords: if, then, else, elif, fi, for, while, until, do, done, case, esac,
"           function, in, select
call s:hi("shStatement",      s:pink,       "",  "bold")
call s:hi("shConditional",    s:pink,       "",  "bold")
call s:hi("shLoop",           s:pink,       "",  "bold")
call s:hi("shFor",            s:pink,       "",  "bold")
call s:hi("shRepeat",         s:pink,       "",  "bold")
call s:hi("shCaseBar",        s:pink,       "")
call s:hi("shCaseIn",         s:pink,       "")
call s:hi("shCaseCommandSub", s:pink,       "")
call s:hi("shCaseExSingleQuote", s:green,    "")
call s:hi("shCaseRange",      s:pink,       "")
call s:hi("shKeyword",        s:pink,       "",  "bold")
call s:hi("shIf",             s:pink,       "",  "bold")
call s:hi("shDo",             s:pink,       "",  "bold")

" Variables
call s:hi("shVariable",       s:orange,     "")
call s:hi("shDeref",          s:orange,     "",  "bold")
call s:hi("shDerefSimple",    s:orange,     "")
call s:hi("shDerefSpecial",   s:coral,      "")
call s:hi("shDerefVar",       s:orange,     "",  "bold")
call s:hi("shSetList",        s:orange,     "")
call s:hi("shSet",            s:pink,       "")

" Functions & commands
call s:hi("shFunction",       s:green,      "")
call s:hi("shFunctionKey",    s:pink,       "",  "bold")
call s:hi("shFunctionOne",    s:green,      "")
call s:hi("shFunctionTwo",    s:green,      "")
call s:hi("shCommandSub",     s:gold,       "")
call s:hi("shCmdSubRegion",   s:fg,         "")

" External commands (make, cmake, grep, awk, sed, etc.)
call s:hi("shCmd",            s:gold,       "")
call s:hi("shCmdParenRegion", s:gold,       "")
call s:hi("shExpr",           s:gold,       "")

" Built-in commands: echo, cd, export, source, test, eval, exec
call s:hi("shBuiltinCmd",     s:magenta,    "",  "bold")

" Shebang
call s:hi("shComment",        s:comment,    "",  "italic")
call s:hi("shSheBang",        s:cyan,       "",  "bold,italic")
call s:hi("shTodo",           s:bg,         s:gold,  "bold")

" Strings
call s:hi("shSingleQuote",    s:green,       "")
call s:hi("shDoubleQuote",    s:green,       "")
call s:hi("shQuote",          s:green,       "")
call s:hi("shString",         s:green,       "")
call s:hi("shEcho",           s:green,       "")
call s:hi("shEscape",         s:teal,       "",  "bold")

" Operators / pipes / redirection
call s:hi("shOperator",       s:pink,       "")
call s:hi("shArithmetic",     s:purple,     "")
call s:hi("shNumber",         s:purple,     "")
call s:hi("shTestOpr",        s:cyan,       "")
call s:hi("shOption",         s:cyan,     "")
call s:hi("shParen",          s:fg,         "")
call s:hi("shRedir",          s:coral,      "",  "bold")
call s:hi("shHereDoc",        s:green,       "",  "italic")
call s:hi("shHereString",     s:green,       "")

" Glob / pattern
call s:hi("shGlob",           s:teal,       "")
call s:hi("shPattern",        s:teal,       "")

" ---------------------------------------------------------------------------
"  ADDITIONAL LANGUAGE SUPPORT
" ---------------------------------------------------------------------------

" --- Lua ---
call s:hi("luaStatement",     s:pink,       "",  "bold")
call s:hi("luaRepeat",        s:pink,       "",  "bold")
call s:hi("luaCond",          s:pink,       "",  "bold")
call s:hi("luaFunction",      s:green,      "")
call s:hi("luaString",        s:green,       "")
call s:hi("luaNumber",        s:purple,     "")
call s:hi("luaConstant",      s:pink,     "")
call s:hi("luaBuiltin",       s:magenta,    "")
call s:hi("luaComment",       s:comment,    "",  "italic")
call s:hi("luaTable",         s:sky_blue,   "")

" --- Makefile ---
call s:hi("makeIdent",        s:yellow,     "")
call s:hi("makeCommands",     s:fg,         "")
call s:hi("makeTarget",       s:green,      "",  "bold")
call s:hi("makeSpecTarget",   s:cyan,       "",  "bold")
call s:hi("makeComment",      s:comment,    "",  "italic")

" --- CMake ---
call s:hi("cmakeCommand",       s:green,    "")
call s:hi("cmakeKWproject",     s:pink,     "",  "bold")
call s:hi("cmakeKWadd_executable", s:cyan,  "",  "bold")
call s:hi("cmakeKWadd_library", s:cyan,     "",  "bold")
call s:hi("cmakeArguments",     s:fg,       "")
call s:hi("cmakeVariable",     s:orange,    "")
call s:hi("cmakeString",       s:green,      "")
call s:hi("cmakeComment",      s:comment,   "",  "italic")

" --- Markdown ---
call s:hi("markdownH1",            s:gold,      "",  "bold")
call s:hi("markdownH2",            s:green,     "",  "bold")
call s:hi("markdownH3",            s:cyan,      "",  "bold")
call s:hi("markdownH4",            s:yellow,    "",  "bold")
call s:hi("markdownH5",            s:sky_blue,  "",  "bold")
call s:hi("markdownH6",            s:purple,    "",  "bold")
call s:hi("markdownHeadingDelimiter", s:coral,  "",  "bold")
call s:hi("markdownCode",          s:teal,      "")
call s:hi("markdownCodeBlock",     s:teal,      "")
call s:hi("markdownCodeDelimiter", s:fg_dim,    "")
call s:hi("markdownBold",          s:fg,        "",  "bold")
call s:hi("markdownItalic",        s:fg,        "",  "italic")
call s:hi("markdownUrl",           s:sky_blue,  "",  "underline")
call s:hi("markdownLinkText",      s:cyan,      "")
call s:hi("markdownListMarker",    s:coral,     "",  "bold")
call s:hi("markdownBlockquote",    s:comment,   "",  "italic")

" --- JSON ---
call s:hi("jsonKeyword",       s:sky_blue,  "")
call s:hi("jsonString",        s:green,      "")
call s:hi("jsonNumber",        s:purple,    "")
call s:hi("jsonBoolean",       s:pink,    "")
call s:hi("jsonNull",          s:pink,    "")
call s:hi("jsonBraces",        s:fg_alt,    "")

" --- YAML ---
call s:hi("yamlKey",           s:sky_blue,  "")
call s:hi("yamlAnchor",        s:orange,    "")
call s:hi("yamlAlias",         s:orange,    "")
call s:hi("yamlBlockMappingKey", s:sky_blue, "")

" --- TOML ---
call s:hi("tomlTable",         s:sky_blue,  "",  "bold")
call s:hi("tomlKey",           s:sky_blue,  "")
call s:hi("tomlString",        s:green,      "")
call s:hi("tomlInteger",       s:purple,    "")
call s:hi("tomlFloat",         s:purple,    "")
call s:hi("tomlBoolean",       s:pink,    "")
call s:hi("tomlDate",          s:teal,      "")

" --- Git ---
call s:hi("gitcommitSummary",  s:fg,        "")
call s:hi("gitcommitComment",  s:comment,   "",  "italic")
call s:hi("gitcommitBranch",   s:cyan,      "",  "bold")
call s:hi("gitcommitDiff",     s:fg_dim,    "")

" --- Vim script ---
call s:hi("vimCommand",       s:pink,       "",  "bold")
call s:hi("vimVar",           s:orange,     "")
call s:hi("vimFuncName",      s:green,      "")
call s:hi("vimUserFunc",      s:green,      "")
call s:hi("vimString",        s:green,       "")
call s:hi("vimNumber",        s:purple,     "")
call s:hi("vimComment",       s:comment,    "",  "italic")
call s:hi("vimOption",        s:yellow,     "")
call s:hi("vimAutoEvent",     s:cyan,       "")

" =============================================================================
"  4. TREESITTER HIGHLIGHT GROUPS (Neovim)
" =============================================================================
if has('nvim')
    " Misc
    hi link @comment         Comment
    hi link @error           Error
    hi link @none            Normal
    hi link @preproc         PreProc
    hi link @define          Define

    " Punctuation
    call s:hi("@punctuation.bracket",    s:fg_alt,      "")
    call s:hi("@punctuation.delimiter",  s:delimiter,   "")
    call s:hi("@punctuation.special",    s:teal,        "")

    " Literals
    hi link @string          String
    hi link @string.regex    SpecialChar
    hi link @string.escape   SpecialChar
    hi link @string.special  SpecialChar
    hi link @character       Character
    hi link @number          Number
    hi link @float           Float
    hi link @boolean         Boolean

    " Functions
    call s:hi("@function",               s:green,       "")
    call s:hi("@function.call",          s:gold,        "")
    call s:hi("@function.builtin",       s:magenta,     "",  "bold")
    call s:hi("@function.macro",         s:teal,        "",  "italic")
    call s:hi("@method",                 s:green,       "")
    call s:hi("@method.call",            s:hot_orange,  "")
    call s:hi("@constructor",            s:sky_blue,    "")

    " Keywords
    call s:hi("@keyword",               s:pink,        "",  "bold")
    call s:hi("@keyword.function",       s:pink,        "",  "bold")
    call s:hi("@keyword.operator",       s:pink,        "")
    call s:hi("@keyword.return",         s:pink,        "",  "bold")
    hi link @conditional     Conditional
    hi link @repeat          Repeat
    hi link @label           Label
    hi link @exception       Exception

    " Operators
    call s:hi("@operator",              s:pink,         "")

    " Types
    call s:hi("@type",                  s:yellow,       "")
    call s:hi("@type.builtin",          s:yellow,       "",  "italic")
    call s:hi("@type.definition",       s:yellow,       "",  "bold")
    call s:hi("@type.qualifier",        s:orange,       "",  "italic")
    call s:hi("@storageclass",          s:orange,       "",  "italic")
    hi link @structure       Structure

    " Variables
    call s:hi("@variable",              s:sand,         "")
    call s:hi("@variable.builtin",      s:sky_blue,     "",  "italic")
    call s:hi("@variable.parameter",    s:coral,        "",  "italic")
    call s:hi("@variable.member",       s:orange,       "")

    " Constants
    call s:hi("@constant",              s:purple,       "",  "bold")
    call s:hi("@constant.builtin",      s:amber,        "")
    call s:hi("@constant.macro",        s:purple,       "",  "italic")

    " Includes / Imports
    call s:hi("@include",               s:cyan,         "",  "bold")

    " Namespaces
    call s:hi("@namespace",             s:cyan,       "",  "bold")
    call s:hi("@module",                s:cyan,       "",  "bold")

    " Properties / Fields
    call s:hi("@property",              s:orange,       "")
    call s:hi("@field",                 s:orange,       "")

    " Tags (HTML/XML)
    call s:hi("@tag",                   s:sky_blue,     "")
    call s:hi("@tag.attribute",         s:gold,         "")
    call s:hi("@tag.delimiter",         s:fg_dim,       "")

    " Semantic tokens
    call s:hi("@lsp.type.type",         s:yellow,       "")
    call s:hi("@lsp.type.class",        s:sky_blue,     "")
    call s:hi("@lsp.type.struct",       s:sky_blue,     "")
    call s:hi("@lsp.type.enum",         s:yellow,       "")
    call s:hi("@lsp.type.interface",    s:sky_blue,     "",  "italic")
    call s:hi("@lsp.type.parameter",    s:coral,        "",  "italic")
    call s:hi("@lsp.type.variable",     s:sand,         "")
    call s:hi("@lsp.type.property",     s:orange,       "")
    call s:hi("@lsp.type.function",     s:green,        "")
    call s:hi("@lsp.type.method",       s:hot_orange,   "")
    call s:hi("@lsp.type.macro",        s:teal,         "",  "italic")
    call s:hi("@lsp.type.decorator",    s:amber,        "",  "italic")
    call s:hi("@lsp.type.namespace",    s:cyan,       "",  "bold")
    call s:hi("@lsp.type.enumMember",   s:purple,       "")
    call s:hi("@lsp.type.typeParameter",s:yellow,       "",  "italic")
    call s:hi("@lsp.mod.deprecated",    s:fg_dim,       "",  "strikethrough")
endif

" =============================================================================
"  5. PLUGIN SUPPORT
" =============================================================================

" --- GitSigns ---
call s:hi("GitSignsAdd",          s:green,   "")
call s:hi("GitSignsChange",       s:amber,   "")
call s:hi("GitSignsDelete",       s:coral,   "")

" --- nvim-cmp ---
call s:hi("CmpItemAbbr",          s:fg_alt,  "")
call s:hi("CmpItemAbbrMatch",     s:cyan,    "",  "bold")
call s:hi("CmpItemAbbrMatchFuzzy",s:cyan,    "")
call s:hi("CmpItemKindFunction",  s:green,   "")
call s:hi("CmpItemKindMethod",    s:hot_orange,   "")
call s:hi("CmpItemKindVariable",  s:orange,  "")
call s:hi("CmpItemKindKeyword",   s:pink,    "")
call s:hi("CmpItemKindText",      s:fg_dim,  "")
call s:hi("CmpItemKindProperty",  s:orange,  "")
call s:hi("CmpItemKindUnit",      s:purple,  "")

" --- Telescope (Neovim) ---
call s:hi("TelescopeBorder",       s:bg_hl,   "")
call s:hi("TelescopePromptBorder", s:cyan,    "")
call s:hi("TelescopeMatching",     s:gold,    "",  "bold")
call s:hi("TelescopeSelection",    s:fg,      s:bg_visual)

" --- NERDTree ---
call s:hi("NERDTreeDir",          s:sky_blue, "",  "bold")
call s:hi("NERDTreeDirSlash",     s:sky_blue, "")
call s:hi("NERDTreeFile",         s:fg_alt,   "")
call s:hi("NERDTreeExecFile",     s:green,    "")
call s:hi("NERDTreeOpenable",     s:cyan,     "")
call s:hi("NERDTreeClosable",     s:coral,    "")

" --- ALE ---
call s:hi("ALEError",             s:error,    "",  "undercurl")
call s:hi("ALEWarning",           s:warn,     "",  "undercurl")
call s:hi("ALEInfo",              s:info,     "",  "undercurl")
call s:hi("ALEErrorSign",         s:error,    s:bg)
call s:hi("ALEWarningSign",       s:warn,     s:bg)

" --- nvim diagnostics ---
call s:hi("DiagnosticError",      s:error,    "")
call s:hi("DiagnosticWarn",       s:warn,     "")
call s:hi("DiagnosticInfo",       s:info,     "")
call s:hi("DiagnosticHint",       s:teal,     "")
call s:hi("DiagnosticUnderlineError", "",     "",  "undercurl")
call s:hi("DiagnosticUnderlineWarn",  "",     "",  "undercurl")
call s:hi("DiagnosticUnderlineInfo",  "",     "",  "undercurl")
call s:hi("DiagnosticUnderlineHint",  "",     "",  "undercurl")

" --- Indent guides ---
call s:hi("IndentBlanklineChar",        s:bg_hl,   "")
call s:hi("IndentBlanklineContextChar", s:fg_dim,  "")

" =============================================================================
"  6. 256-COLOR TERMINAL FALLBACK
" =============================================================================
if &t_Co > 255
    " Background
    hi Normal           ctermfg=226  ctermbg=234
    hi CursorLine                    ctermbg=235  cterm=none
    hi CursorLineNr     ctermfg=214               cterm=none
    hi LineNr           ctermfg=241  ctermbg=234
    hi Visual                        ctermbg=237
    hi Search           ctermfg=0    ctermbg=214  cterm=bold
    hi IncSearch        ctermfg=0    ctermbg=204  cterm=bold

    " Syntax core
    hi Comment          ctermfg=242               cterm=italic
    hi Constant         ctermfg=141               cterm=bold
    hi Number           ctermfg=141
    hi Float            ctermfg=141
    hi Boolean          ctermfg=197
    hi String           ctermfg=118
    hi Character        ctermfg=118
    hi SpecialChar      ctermfg=115               cterm=bold
    hi Identifier       ctermfg=180
    hi Function         ctermfg=118
    hi Statement        ctermfg=197               cterm=bold
    hi Conditional      ctermfg=197               cterm=bold
    hi Repeat           ctermfg=197               cterm=bold
    hi Label            ctermfg=214
    hi Operator         ctermfg=197
    hi Keyword          ctermfg=197               cterm=bold
    hi Exception        ctermfg=197               cterm=bold
    hi PreProc          ctermfg=80
    hi Include          ctermfg=80                cterm=bold
    hi Define           ctermfg=80
    hi Macro            ctermfg=115               cterm=italic
    hi PreCondit        ctermfg=80                cterm=bold
    hi Type             ctermfg=214
    hi StorageClass     ctermfg=208               cterm=italic
    hi Structure        ctermfg=214               cterm=bold
    hi Typedef          ctermfg=214
    hi Special          ctermfg=115               cterm=italic
    hi Tag              ctermfg=197               cterm=italic
    hi Delimiter        ctermfg=245
    hi Debug            ctermfg=204               cterm=bold
    hi Underlined       ctermfg=75                cterm=underline
    hi Todo             ctermfg=0    ctermbg=214  cterm=bold
    hi Error            ctermfg=196  ctermbg=52

    " UI
    hi StatusLine       ctermfg=250  ctermbg=237
    hi StatusLineNC     ctermfg=243  ctermbg=235
    hi Pmenu            ctermfg=250  ctermbg=236
    hi PmenuSel         ctermfg=0    ctermbg=80
    hi PmenuSbar                     ctermbg=235
    hi PmenuThumb                    ctermbg=243
    hi TabLine          ctermfg=243  ctermbg=235
    hi TabLineSel       ctermfg=149  ctermbg=237  cterm=bold
    hi TabLineFill                   ctermbg=233
    hi WildMenu         ctermfg=0    ctermbg=80
    hi Title            ctermfg=214               cterm=bold
    hi VertSplit        ctermfg=237  ctermbg=234
    hi Folded           ctermfg=242  ctermbg=235
    hi FoldColumn       ctermfg=241  ctermbg=234
    hi SignColumn       ctermfg=223  ctermbg=234
    hi NonText          ctermfg=237
    hi SpecialKey       ctermfg=237
    hi MatchParen       ctermfg=0    ctermbg=214  cterm=bold

    " Diff
    hi DiffAdd                       ctermbg=22
    hi DiffChange                    ctermbg=58
    hi DiffDelete       ctermfg=204  ctermbg=52
    hi DiffText         ctermfg=0    ctermbg=178  cterm=bold

    " Diagnostics
    hi ErrorMsg         ctermfg=196  ctermbg=234  cterm=bold
    hi WarningMsg       ctermfg=214               cterm=bold
    hi MoreMsg          ctermfg=118
    hi ModeMsg          ctermfg=149
    hi Question         ctermfg=80
    hi Directory        ctermfg=75                cterm=bold

    " Spell
    if has("spell")
        hi SpellBad                  ctermbg=52
        hi SpellCap                  ctermbg=17
        hi SpellLocal                ctermbg=23
        hi SpellRare                 ctermbg=53
    endif

    " Language-specific 256 fallbacks
    hi cCustomFunc      ctermfg=214
    hi cMethodCall      ctermfg=208
    hi cArrowMethod     ctermfg=208
    hi cppNamespace     ctermfg=80               cterm=bold
    hi cppScopeRes      ctermfg=80
    hi cppStdObject     ctermfg=211               cterm=bold
    hi cppStdType       ctermfg=75
    hi shDeref          ctermfg=208               cterm=bold
    hi shVariable       ctermfg=208
    hi shSheBang        ctermfg=80                cterm=bold,italic
    hi shBuiltinCmd     ctermfg=198
    hi shCmd            ctermfg=214
    hi shCmdParenRegion ctermfg=214
    hi shExpr           ctermfg=214

    hi pythonBuiltin    ctermfg=198               cterm=bold
    hi pythonDecorator  ctermfg=178               cterm=italic
    hi pythonMethodCall ctermfg=208

    hi fortranType      ctermfg=214
    hi fortranStructure ctermfg=197               cterm=bold
    hi fortranReadWrite ctermfg=198               cterm=bold
    hi fortranIntrinsic ctermfg=214
    hi fortranInclude   ctermfg=80                cterm=bold
    hi fortranIdentifier ctermfg=180
    hi fortranModule    ctermfg=75                cterm=bold
    hi fortranSubroutineName ctermfg=118
    hi fortranFunctionName ctermfg=118
    hi fortranProgramName ctermfg=75              cterm=bold

    hi pythonClass      ctermfg=75
    hi pythonClassName  ctermfg=75
    hi pythonAttribute  ctermfg=180
endif

" =============================================================================
"  FINAL
" =============================================================================
set background=dark
