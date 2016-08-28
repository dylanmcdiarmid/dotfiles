" -----------------------------------------------------------------------------
" File: pufflehuff.vim
" Description: The Pufflehuff Colorscheme for Vim
" Author: Dylan McDiarmid <dylan@littleloops.io>
" Source: https://github.com/dylanmcdiarmid/pufflehuff
" Acknowledgements: Based on https://github.com/morhetz/gruvbox
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='pufflehuff'

if !has('nvim') && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:pufflehuff_bold')
  let g:pufflehuff_bold=1
endif
if !exists('g:pufflehuff_italic')
  if has('nvim') || has('gui_running') || $TERM_ITALICS == 'true'
    let g:pufflehuff_italic=1
  else
    let g:pufflehuff_italic=0
  endif
endif
if !exists('g:pufflehuff_undercurl')
  let g:pufflehuff_undercurl=1
endif
if !exists('g:pufflehuff_underline')
  let g:pufflehuff_underline=1
endif
if !exists('g:pufflehuff_inverse')
  let g:pufflehuff_inverse=1
endif

if !exists('g:pufflehuff_guisp_fallback') || index(['fg', 'bg'], g:pufflehuff_guisp_fallback) == -1
  let g:pufflehuff_guisp_fallback='NONE'
endif

if !exists('g:pufflehuff_improved_strings')
  let g:pufflehuff_improved_strings=0
endif

if !exists('g:pufflehuff_improved_warnings')
  let g:pufflehuff_improved_warnings=0
endif

if !exists('g:pufflehuff_termcolors')
  let g:pufflehuff_termcolors=256
endif

if !exists('g:pufflehuff_invert_indent_guides')
  let g:pufflehuff_invert_indent_guides=0
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0       = ['#231f25', 232]
let s:gb.dark1       = ['#2e2632', 237]  " cursor line and column
let s:gb.dark2       = ['#352c3a', 239]  " Status Line, FG for selected text
let s:gb.dark3       = ['#47344d', 53]   " highlight color
let s:gb.dark4       = ['#9671aa', 140]  " Tab fg when not active, bg when active

let s:gb.gray_neutral = ['#8f8f90', 102]
let s:gb.gray_bright = ['#aaacad', 145]
let s:gb.gray_faded  = ['#6d6e6f', 59]

let s:gb.light0      = ['#f3f4e9', 230] 
let s:gb.light1      = ['#ebdbb2', 223]
let s:gb.light2      = ['#d5c4a1', 250]
let s:gb.light3      = ['#bdae93', 248]
let s:gb.light4      = ['#a89984', 246]

let s:gb.bright_red     = ['#ff3661', 203]
let s:gb.bright_pink    = ['#ef0ba1', 199]
let s:gb.bright_green   = ['#24f75f', 47]
let s:gb.bright_yg      = ['#8ff31s', 118]
let s:gb.bright_yellow  = ['#fafc29', 11]
let s:gb.bright_blue    = ['#4dacfc', 75]
let s:gb.bright_purple  = ['#e90afd', 165]
let s:gb.bright_cyan    = ['#23ecee', 14]
let s:gb.bright_orange  = ['#fe812e', 208]

let s:gb.neutral_red    = ['#db566c', 167]
let s:gb.neutral_pink   = ['#ff7be2', 212]
let s:gb.neutral_green  = ['#8ddf91', 114]
let s:gb.neutral_yg     = ['#b1f16d', 155]
let s:gb.neutral_yellow = ['#ecf583', 228]
let s:gb.neutral_blue   = ['#80b8ed', 111]
let s:gb.neutral_purple = ['#db8efe', 177]
let s:gb.neutral_cyan   = ['#70e8e7', 80]
let s:gb.neutral_orange = ['#f5ab53', 215]

let s:gb.faded_red      = ['#c37a7a', 174]
let s:gb.faded_pink     = ['#ff94dd', 212]
let s:gb.faded_green    = ['#7eb18d', 108]
let s:gb.faded_yellow   = ['#e3dcac', 187]
let s:gb.faded_yg       = ['#adcb8e', 150]
let s:gb.faded_blue     = ['#859eb3', 109]
let s:gb.faded_purple   = ['#b994d0', 140]
let s:gb.faded_cyan     = ['#88bfbd', 109]
let s:gb.faded_orange   = ['#d2ab6d', 179]

let s:gb.dark_orange = ['#aa5901', 130]
let s:gb.dark_yellow = ['#9b9d04', 142]

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:pufflehuff_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:pufflehuff_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:pufflehuff_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:pufflehuff_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:pufflehuff_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']
let s:gray_faded = s:gb.gray_faded

if s:is_dark
  let s:bg0  = s:gb.dark0
  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_bright

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:red    = s:gb.bright_red
  let s:pink   = s:gb.neutral_pink
  let s:bright_pink   = s:gb.bright_pink
  let s:green  = s:gb.neutral_green
  let s:bright_green  = s:gb.bright_green
  let s:yellow = s:gb.neutral_yellow
  let s:yg     = s:gb.bright_yg
  let s:blue   = s:gb.neutral_blue
  let s:purple = s:gb.neutral_purple
  let s:bright_purple = s:gb.bright_purple
  let s:cyan   = s:gb.neutral_cyan
  let s:orange = s:gb.neutral_orange
  let s:bright_orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_neutral

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:red    = s:gb.bright_red
  let s:pink   = s:gb.bright_pink
  let s:bright_pink   = s:gb.bright_pink
  let s:green  = s:gb.faded_green
  let s:bright_green  = s:gb.bright_green
  let s:yellow = s:gb.dark_yellow
  let s:yg     = s:gb.faded_yg
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:bright_purple = s:gb.bright_purple
  let s:cyan   = s:gb.faded_cyan
  let s:orange = s:gb.dark_orange
  let s:bright_orange = s:gb.bright_orange
endif

" reset to 16 colors fallback
if g:pufflehuff_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:cyan[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.cyan   = s:cyan
let s:gb.orange = s:orange

" }}}

" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:pufflehuff_hls_cursor')
  let s:hls_cursor = get(s:gb, g:pufflehuff_hls_cursor)
endif

let s:number_column = s:gray_faded
let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:pufflehuff_sign_column')
    let s:sign_column = get(s:gb, g:pufflehuff_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:pufflehuff_color_column')
  let s:color_column = get(s:gb, g:pufflehuff_color_column)
endif

let s:vert_split = s:bg2
if exists('g:pufflehuff_vert_split')
  let s:vert_split = get(s:gb, g:pufflehuff_vert_split)
endif

let s:invert_signs = ''
if exists('g:pufflehuff_invert_signs')
  if g:pufflehuff_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = ''
if exists('g:pufflehuff_invert_selection')
  if g:pufflehuff_invert_selection == 1
    let s:invert_selection = s:inverse
  endif
endif

let s:invert_tabline = ''
if exists('g:pufflehuff_invert_tabline')
  if g:pufflehuff_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = ''
if exists('g:pufflehuff_italicize_comments')
  if g:pufflehuff_italicize_comments == 1
    let s:italicize_comments = s:italic
  endif
endif

let s:italicize_strings = ''
if exists('g:pufflehuff_italicize_strings')
  if g:pufflehuff_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:pufflehuff_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:pufflehuff_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Pufflehuff Hi Groups: {{{

" memoize common hi groups
call s:HL('PufflehuffFg0', s:fg0)
call s:HL('PufflehuffFg1', s:fg1)
call s:HL('PufflehuffFg2', s:fg2)
call s:HL('PufflehuffFg3', s:fg3)
call s:HL('PufflehuffFg4', s:fg4)
call s:HL('PufflehuffGray', s:gray)
call s:HL('PufflehuffBg0', s:bg0)
call s:HL('PufflehuffBg1', s:bg1)
call s:HL('PufflehuffBg2', s:bg2)
call s:HL('PufflehuffBg3', s:bg3)
call s:HL('PufflehuffBg4', s:bg4)

call s:HL('PufflehuffRed', s:red)
call s:HL('PufflehuffRedBold', s:red, s:none, s:bold)
call s:HL('PufflehuffGreen', s:green)
call s:HL('PufflehuffGreenBold', s:green, s:none, s:bold)
call s:HL('PufflehuffBrightGreen', s:bright_green)
call s:HL('PufflehuffBrightGreenBold', s:bright_green, s:none, s:bold)
call s:HL('PufflehuffYellow', s:yellow)
call s:HL('PufflehuffYellowBold', s:yellow, s:none, s:bold)
call s:HL('PufflehuffYg', s:yg)
call s:HL('PufflehuffYgBold', s:yg, s:none, s:bold)
call s:HL('PufflehuffBlue', s:blue)
call s:HL('PufflehuffBlueBold', s:blue, s:none, s:bold)
call s:HL('PufflehuffPink', s:pink)
call s:HL('PufflehuffPinkBold', s:pink, s:none, s:bold)
call s:HL('PufflehuffBrightPink', s:bright_pink)
call s:HL('PufflehuffBrightPinkBold', s:bright_pink, s:none, s:bold)
call s:HL('PufflehuffPurple', s:purple)
call s:HL('PufflehuffPurpleBold', s:purple, s:none, s:bold)
call s:HL('PufflehuffBrightPurple', s:bright_purple)
call s:HL('PufflehuffBrightPurpleBold', s:bright_purple, s:none, s:bold)
call s:HL('PufflehuffCyan', s:cyan)
call s:HL('PufflehuffCyanBold', s:cyan, s:none, s:bold)
call s:HL('PufflehuffOrange', s:orange)
call s:HL('PufflehuffOrangeBold', s:orange, s:none, s:bold)
call s:HL('PufflehuffBrightOrange', s:bright_orange)
call s:HL('PufflehuffBrightOrangeBold', s:bright_orange, s:none, s:bold)

call s:HL('PufflehuffRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('PufflehuffGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('PufflehuffYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('PufflehuffBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('PufflehuffPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('PufflehuffCyanSign', s:cyan, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg0, s:bg0)

" Correct background
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:vim_bg, s:italic . s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:vim_bg, s:bg4, s:bold . s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:bg0, s:fg1, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg1)
endif

hi! link NonText PufflehuffBg2
hi! link SpecialKey PufflehuffBg2

call s:HL('Visual',    s:none,  s:bg3)
hi! link VisualNOS Visual

call s:HL('Search',    s:bg0, s:yellow)
call s:HL('IncSearch', s:bg0, s:hls_cursor)

call s:HL('Underlined', s:blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg4, s:bg0, s:bold . s:inverse)
call s:HL('StatusLineNC', s:bg2, s:fg4, s:bold . s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:fg4, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory PufflehuffGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title PufflehuffGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:vim_bg, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg PufflehuffYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg PufflehuffYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question PufflehuffOrangeBold
" Warning messages
hi! link WarningMsg PufflehuffRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:pufflehuff_improved_strings == 0
  hi! link Special PufflehuffOrange
else
  call s:HL('Special', s:bg1, s:orange, s:italic)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:blue, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement PufflehuffPink
" if, then, else, endif, swicth, etc.
hi! link Conditional PufflehuffPink
" for, do, while, etc.
hi! link Repeat PufflehuffPinkBold
" case, default, etc.
hi! link Label PufflehuffBrightOrange
" try, catch, throw
hi! link Exception PufflehuffOrangeBold
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword PufflehuffCyan

" Variable name
hi! link Identifier PufflehuffBlue
" Function name
hi! link Function PufflehuffBlueBold

" Generic preprocessor
hi! link PreProc PufflehuffCyan
" Preprocessor #include
hi! link Include PufflehuffCyan
" Preprocessor #define
hi! link Define PufflehuffCyan
" Same as Define
hi! link Macro PufflehuffCyan
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit PufflehuffCyan

" Generic constant
hi! link Constant PufflehuffYellow
" Character constant: 'c', '/n'
hi! link Character PufflehuffYellow
" String constant: "this is a string"
if g:pufflehuff_improved_strings == 0
  call s:HL('String',  s:green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:bg1, s:fg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean PufflehuffOrangeBold
" Number constant: 234, 0xff
hi! link Number PufflehuffRed
" Floating point constant: 2.3e10
hi! link Float PufflehuffRed

" Generic type
hi! link Type PufflehuffYellow
" static, register, volatile, etc
hi! link StorageClass PufflehuffYellow
" struct, union, enum, etc.
hi! link Structure PufflehuffYellowBold
" typedef
hi! link Typedef PufflehuffYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:cyan, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:pufflehuff_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:cyan)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link SneakPluginTarget Search
hi! link SneakStreakTarget Search
call s:HL('SneakStreakMask', s:yellow, s:yellow)
hi! link SneakStreakStatusLine Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:pufflehuff_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd PufflehuffGreenSign
hi! link GitGutterChange PufflehuffOrangeSign
hi! link GitGutterDelete PufflehuffRedSign
hi! link GitGutterChangeDelete PufflehuffOrangeSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile PufflehuffGreen
hi! link gitcommitDiscardedFile PufflehuffRed

" }}}
" Signify: {{{

hi! link SignifySignAdd PufflehuffGreenSign
hi! link SignifySignChange PufflehuffCyanSign
hi! link SignifySignDelete PufflehuffRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign PufflehuffRedSign
hi! link SyntasticWarningSign PufflehuffYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   PufflehuffBlueSign
hi! link SignatureMarkerText PufflehuffPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl PufflehuffBlueSign
hi! link ShowMarksHLu PufflehuffBlueSign
hi! link ShowMarksHLo PufflehuffBlueSign
hi! link ShowMarksHLm PufflehuffBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch PufflehuffYellow
hi! link CtrlPNoEntries PufflehuffRed
hi! link CtrlPPrtBase PufflehuffBg2
hi! link CtrlPPrtCursor PufflehuffBlue
hi! link CtrlPLinePre PufflehuffBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket PufflehuffFg3
hi! link StartifyFile PufflehuffFg0
hi! link StartifyNumber PufflehuffBlue
hi! link StartifyPath PufflehuffGray
hi! link StartifySlash PufflehuffGray
hi! link StartifySection PufflehuffYellow
hi! link StartifySpecial PufflehuffBg2
hi! link StartifyHeader PufflehuffOrange
hi! link StartifyFooter PufflehuffBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:cyan[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:cyan[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded PufflehuffGreen
hi! link diffRemoved PufflehuffRed
hi! link diffChanged PufflehuffCyan

hi! link diffFile PufflehuffOrange
hi! link diffNewFile PufflehuffYellow

hi! link diffLine PufflehuffBlue

" }}}
" Html: {{{

hi! link htmlTag PufflehuffBlue
hi! link htmlEndTag PufflehuffBlue

hi! link htmlTagName PufflehuffCyanBold
hi! link htmlArg PufflehuffCyan

hi! link htmlScriptTag PufflehuffPurple
hi! link htmlTagN PufflehuffFg1
hi! link htmlSpecialTagName PufflehuffCyanBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar PufflehuffOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag PufflehuffBlue
hi! link xmlEndTag PufflehuffBlue
hi! link xmlTagName PufflehuffBlue
hi! link xmlEqual PufflehuffBlue
hi! link docbkKeyword PufflehuffCyanBold

hi! link xmlDocTypeDecl PufflehuffGray
hi! link xmlDocTypeKeyword PufflehuffPurple
hi! link xmlCdataStart PufflehuffGray
hi! link xmlCdataCdata PufflehuffPurple
hi! link dtdFunction PufflehuffGray
hi! link dtdTagName PufflehuffPurple

hi! link xmlAttrib PufflehuffCyan
hi! link xmlProcessingDelim PufflehuffGray
hi! link dtdParamEntityPunct PufflehuffGray
hi! link dtdParamEntityDPunct PufflehuffGray
hi! link xmlAttribPunct PufflehuffGray

hi! link xmlEntity PufflehuffOrange
hi! link xmlEntityPunct PufflehuffOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4, s:none, s:bold . s:italicize_comments)

hi! link vimNotation PufflehuffOrange
hi! link vimBracket PufflehuffOrange
hi! link vimMapModKey PufflehuffOrange
hi! link vimFuncSID PufflehuffFg3
hi! link vimSetSep PufflehuffFg3
hi! link vimSep PufflehuffFg3
hi! link vimContinue PufflehuffFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword PufflehuffBlue
hi! link clojureCond PufflehuffOrange
hi! link clojureSpecial PufflehuffOrange
hi! link clojureDefine PufflehuffOrange

hi! link clojureFunc PufflehuffYellow
hi! link clojureRepeat PufflehuffYellow
hi! link clojureCharacter PufflehuffCyan
hi! link clojureStringEscape PufflehuffCyan
hi! link clojureException PufflehuffRed

hi! link clojureRegexp PufflehuffCyan
hi! link clojureRegexpEscape PufflehuffCyan
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen PufflehuffFg3
hi! link clojureAnonArg PufflehuffYellow
hi! link clojureVariable PufflehuffBlue
hi! link clojureMacro PufflehuffOrange

hi! link clojureMeta PufflehuffYellow
hi! link clojureDeref PufflehuffYellow
hi! link clojureQuote PufflehuffYellow
hi! link clojureUnquote PufflehuffYellow

" }}}
" C: {{{

hi! link cOperator PufflehuffPurple
hi! link cStructure PufflehuffOrange

" }}}
" Python: {{{

hi! link pythonBuiltin PufflehuffOrange
hi! link pythonBuiltinObj PufflehuffOrange
hi! link pythonBuiltinFunc PufflehuffOrange
hi! link pythonFunction PufflehuffCyan
hi! link pythonDecorator PufflehuffRed
hi! link pythonInclude PufflehuffBlue
hi! link pythonImport PufflehuffBlue
hi! link pythonRun PufflehuffBlue
hi! link pythonCoding PufflehuffBlue
hi! link pythonOperator PufflehuffRed
hi! link pythonExceptions PufflehuffPurple
hi! link pythonBoolean PufflehuffPurple
hi! link pythonDot PufflehuffFg3

" }}}
" CSS: {{{

hi! link cssBraces PufflehuffBlue
hi! link cssFunctionName PufflehuffYellow
hi! link cssIdentifier PufflehuffOrange
hi! link cssClassName PufflehuffGreen
hi! link cssColor PufflehuffBlue
hi! link cssSelectorOp PufflehuffBlue
hi! link cssSelectorOp2 PufflehuffBlue
hi! link cssImportant PufflehuffGreen
hi! link cssVendor PufflehuffFg1

hi! link cssTextProp PufflehuffCyan
hi! link cssAnimationProp PufflehuffCyan
hi! link cssUIProp PufflehuffYellow
hi! link cssTransformProp PufflehuffCyan
hi! link cssTransitionProp PufflehuffCyan
hi! link cssPrintProp PufflehuffCyan
hi! link cssPositioningProp PufflehuffYellow
hi! link cssBoxProp PufflehuffCyan
hi! link cssFontDescriptorProp PufflehuffCyan
hi! link cssFlexibleBoxProp PufflehuffCyan
hi! link cssBorderOutlineProp PufflehuffCyan
hi! link cssBackgroundProp PufflehuffCyan
hi! link cssMarginProp PufflehuffCyan
hi! link cssListProp PufflehuffCyan
hi! link cssTableProp PufflehuffCyan
hi! link cssFontProp PufflehuffCyan
hi! link cssPaddingProp PufflehuffCyan
hi! link cssDimensionProp PufflehuffCyan
hi! link cssRenderProp PufflehuffCyan
hi! link cssColorProp PufflehuffCyan
hi! link cssGeneratedContentProp PufflehuffCyan

" }}}
" JavaScript: {{{

hi! link javaScriptBraces PufflehuffFg1
hi! link javaScriptFunction PufflehuffPink
hi! link javaScriptIdentifier PufflehuffPurple
hi! link javaScriptMember PufflehuffBlue
hi! link javaScriptNumber PufflehuffRed
hi! link javaScriptNull PufflehuffRedBold
hi! link javaScriptParens PufflehuffFg3
hi! link javascriptBrackets PufflehuffFg3
hi! link javascriptReturn PufflehuffBrightOrangeBold

" }}}
" YAJS: {{{

hi! link javascriptImport PufflehuffPurple
hi! link javascriptExport PufflehuffPurple
hi! link javascriptClassKeyword PufflehuffCyan
hi! link javascriptClassExtends PufflehuffCyan
hi! link javascriptDefault PufflehuffCyan

hi! link javascriptClassName PufflehuffYellow
hi! link javascriptClassSuperName PufflehuffYellow
hi! link javascriptGlobal PufflehuffYellow

hi! link javascriptEndColons PufflehuffFg1
hi! link javascriptFuncArg PufflehuffFg1
hi! link javascriptGlobalMethod PufflehuffFg1
hi! link javascriptNodeGlobal PufflehuffFg1

" hi! link javascriptVariable PufflehuffOrange
hi! link javascriptVariable PufflehuffPurple
" hi! link javascriptIdentifier PufflehuffOrange
" hi! link javascriptClassSuper PufflehuffOrange
hi! link javascriptIdentifier PufflehuffOrange
hi! link javascriptClassSuper PufflehuffOrange

" hi! link javascriptFuncKeyword PufflehuffOrange
" hi! link javascriptAsyncFunc PufflehuffOrange
hi! link javascriptFuncKeyword PufflehuffCyan
hi! link javascriptAsyncFunc PufflehuffCyan
hi! link javascriptClassStatic PufflehuffOrange

hi! link javascriptOperator PufflehuffRed
hi! link javascriptForOperator PufflehuffOrange
hi! link javascriptYield PufflehuffBrightOrangeBold
hi! link javascriptExceptions PufflehuffRed
hi! link javascriptMessage PufflehuffRed

hi! link javascriptTemplateSB PufflehuffBrightYg
hi! link javascriptTemplateSubstitution PufflehuffFg1

" hi! link javascriptLabel PufflehuffBlue
" hi! link javascriptObjectLabel PufflehuffBlue
" hi! link javascriptPropertyName PufflehuffBlue
hi! link javascriptLabel PufflehuffFg1
hi! link javascriptObjectLabel PufflehuffFg1
hi! link javascriptPropertyName PufflehuffFg1

hi! link javascriptLogicSymbols PufflehuffFg1
hi! link javascriptArrowFunc PufflehuffFg1

hi! link javascriptDocParamName PufflehuffFg4
hi! link javascriptDocTags PufflehuffFg4
hi! link javascriptDocNotation PufflehuffFg4
hi! link javascriptDocParamType PufflehuffFg4
hi! link javascriptDocNamedParamType PufflehuffFg4

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp PufflehuffFg3
hi! link coffeeSpecialOp PufflehuffFg3
hi! link coffeeCurly PufflehuffOrange
hi! link coffeeParen PufflehuffFg3
hi! link coffeeBracket PufflehuffOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter PufflehuffGreen
hi! link rubyInterpolationDelimiter PufflehuffCyan

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier PufflehuffRed
hi! link objcDirective PufflehuffBlue

" }}}
" Go: {{{

hi! link goDirective PufflehuffCyan
hi! link goConstants PufflehuffPurple
hi! link goDeclaration PufflehuffRed
hi! link goDeclType PufflehuffBlue
hi! link goBuiltins PufflehuffOrange

" }}}
" Lua: {{{

hi! link luaIn PufflehuffRed
hi! link luaFunction PufflehuffCyan
hi! link luaTable PufflehuffOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp PufflehuffFg3
hi! link moonExtendedOp PufflehuffFg3
hi! link moonFunction PufflehuffFg3
hi! link moonObject PufflehuffYellow

" }}}
" Java: {{{

hi! link javaAnnotation PufflehuffBlue
hi! link javaDocTags PufflehuffCyan
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen PufflehuffFg3
hi! link javaParen1 PufflehuffFg3
hi! link javaParen2 PufflehuffFg3
hi! link javaParen3 PufflehuffFg3
hi! link javaParen4 PufflehuffFg3
hi! link javaParen5 PufflehuffFg3
hi! link javaOperator PufflehuffOrange

hi! link javaVarArg PufflehuffGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter PufflehuffGreen
hi! link elixirInterpolationDelimiter PufflehuffCyan

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition PufflehuffFg1
hi! link scalaCaseFollowing PufflehuffFg1
hi! link scalaCapitalWord PufflehuffFg1
hi! link scalaTypeExtension PufflehuffFg1

hi! link scalaKeyword PufflehuffRed
hi! link scalaKeywordModifier PufflehuffRed

hi! link scalaSpecial PufflehuffCyan
hi! link scalaOperator PufflehuffFg1

hi! link scalaTypeDeclaration PufflehuffYellow
hi! link scalaTypeTypePostDeclaration PufflehuffYellow

hi! link scalaInstanceDeclaration PufflehuffFg1
hi! link scalaInterpolation PufflehuffCyan

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 PufflehuffGreenBold
hi! link markdownH2 PufflehuffGreenBold
hi! link markdownH3 PufflehuffYellowBold
hi! link markdownH4 PufflehuffYellowBold
hi! link markdownH5 PufflehuffYellow
hi! link markdownH6 PufflehuffYellow

hi! link markdownCode PufflehuffCyan
hi! link markdownCodeBlock PufflehuffCyan
hi! link markdownCodeDelimiter PufflehuffCyan

hi! link markdownBlockquote PufflehuffGray
hi! link markdownListMarker PufflehuffGray
hi! link markdownOrderedListMarker PufflehuffGray
hi! link markdownRule PufflehuffGray
hi! link markdownHeadingRule PufflehuffGray

hi! link markdownUrlDelimiter PufflehuffFg3
hi! link markdownLinkDelimiter PufflehuffFg3
hi! link markdownLinkTextDelimiter PufflehuffFg3

hi! link markdownHeadingDelimiter PufflehuffOrange
hi! link markdownUrl PufflehuffPurple
hi! link markdownUrlTitleDelimiter PufflehuffGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType PufflehuffYellow
" hi! link haskellOperators PufflehuffOrange
" hi! link haskellConditional PufflehuffCyan
" hi! link haskellLet PufflehuffOrange
"
hi! link haskellType PufflehuffFg1
hi! link haskellIdentifier PufflehuffFg1
hi! link haskellSeparator PufflehuffFg1
hi! link haskellDelimiter PufflehuffFg4
hi! link haskellOperators PufflehuffBlue
"
hi! link haskellBacktick PufflehuffOrange
hi! link haskellStatement PufflehuffOrange
hi! link haskellConditional PufflehuffOrange

hi! link haskellLet PufflehuffCyan
hi! link haskellDefault PufflehuffCyan
hi! link haskellWhere PufflehuffCyan
hi! link haskellBottom PufflehuffCyan
hi! link haskellBlockKeywords PufflehuffCyan
hi! link haskellImportKeywords PufflehuffCyan
hi! link haskellDeclKeyword PufflehuffCyan
hi! link haskellDeriving PufflehuffCyan
hi! link haskellAssocType PufflehuffCyan

hi! link haskellNumber PufflehuffPurple
hi! link haskellPragma PufflehuffPurple

hi! link haskellString PufflehuffGreen
hi! link haskellChar PufflehuffGreen

" }}}
" Json: {{{

hi! link jsonKeyword PufflehuffGreen
hi! link jsonQuote PufflehuffGreen
hi! link jsonBraces PufflehuffFg1
hi! link jsonString PufflehuffFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! PufflehuffHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! PufflehuffHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
