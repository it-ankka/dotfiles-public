vim.cmd([[
" Name:        a11y-dark
" Author:      original author Reuben L. Lillie <@reubenlillie>
" DerivedFrom: https://www.github.com/vim/colorschemes 

" Table 1. Theme colors with Xterm (X11) and ANSI approximations
" ------------------------------------------------------------------------
"  №  ANSI         HEX     Name              X11 №  X11 HEX   X11 Name
" ------------------------------------------------------------------------
"  0  Black        #2b2b2b Mine Shaft        235    #262626   Grey15
"  7  LightGray    #d4d0ab Chino             187    #d7d7af   LightYellow3
"  9  Red          #ffa07a Vivid Tangerine   209    #ff875f   Salmon1
" 10  Green        #abe338 Conifer           118    #87ff00   Chartreuse1
" 11  Yellow       #ffd700 Gold              220    #ffd700   Gold1
" 13  Magenta      #dcc6e0 Snuff             219    #ffafff   Plum1
" 14  Cyan         #00e0e0 Bright Turquoise   45    #00d7ff   Turquoise2 
" 15  White        #f8f8f2 Spring Wood       255    #eeeeee   Grey93
" ------------------------------------------------------------------------

" ========================
" §1. Prepare color scheme
" ========================

set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="a11y-dark"
let s:t_Co = exists('&t_Co') && !has('gui_running') ? (&t_Co ? &t_Co : 0) : -1

" =====================================================================
" §2. Override default syntax highlighting links for specific languages
" =====================================================================

" Link the following highlight groups to the basic groups defined in §3.

" ------------------------------
" §2.1. HTML, Markdown, and YAML
" ------------------------------

" White
hi! link htmlTag Normal
hi! link markdownYamlHead Normal
hi! link yamlDocumentStart Normal
hi! link yamlFlowIndicator Normal
hi! link yamlKeyValueDelimiter Normal
" Green
hi! link markdownCodeBlock Type
hi! link markdownCodeDelimiter Type
hi! link yamlFlowString Type
" Yellow
hi! link yamlBlockMappingKey Constant
" Cyan
hi! link markdownH1 Identifier
hi! link markdownH1Delimiter Identifier
hi! link markdownH2 Identifier
hi! link markdownH2Delimiter Identifier
hi! link markdownH3 Identifier
hi! link markdownH3Delimiter Identifier
hi! link markdownH4 Identifier
hi! link markdownH4Delimiter Identifier
hi! link markdownH5 Identifier
hi! link markdownH5Delimiter Identifier
hi! link markdownH6 Identifier
hi! link markdownH6Delimiter Identifier
" Magenta
hi! link htmlSpecialChar Special

" ---------
" §2.2. CSS
" ---------

" Gray
hi! link cssBraces Comment

" ----------------
" §2.3. JavaScript
" ----------------

" LightGray
hi! link javaScriptBraces Comment
hi! link javaScriptEmbed Comment
hi! link javaScriptParens Comment
" Red
hi! link javaScriptConstant Statement
" Green
hi! link javaScriptSpecial Type
hi! link javaScriptStringS Type
hi! link javaScriptStringT Type
" Yellow
hi! link javaScriptConditional Constant
hi! link javaScriptLabel Constant
hi! link javaScriptMember Constant
hi! link javaScriptStatement Constant
" Magenta
hi! link javaScriptNull PreProc
" Cyan
hi! link javaScriptNumber Identifier
hi! link javaScriptOperator Identifier
hi! link javaScriptReserved Identifier

" ------------------------------
" §2.4 Link Vim highlight groups
" ------------------------------

" LightGray
hi! link EndOfBuffer Comment
" Yellow
hi! link LineNr Constant
hi! link NonText Constant
" Magenta
hi! link PreProc Special
" Cyan
hi! link CursorLineNr Identifier
" Other highlight groups
hi! link ColorColumn Visual
hi! link CurSearch Search
hi! link Folded Ignore
hi! link MatchParen Visual
hi! link Pmenu Ignore
hi! link PmenuSel Search
hi! link SpellBad ErrorMsg
hi! link TabLine Ignore
hi! link WildMenu Search
hi! link vimHiKeyError ErrorMsg

" ========================================================
" §3. Set basic color scheme for different editions of Vim
" ========================================================

" --------------------------
" §3.1 gVim highlight groups
" --------------------------

" Define an array of hexadecimal codes to override the 16 basic ANSI colors.
if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#2b2b2b', '#ffa07a', '#abe338', '#d4d0ab', '#00e0e0', '#dcc6e0', '#00e0e0', '#d4d0ab', '#d4d0ab', '#ffa07a', '#abe338', '#ffd700', '#00e0e0', '#dcc6e0', '#00e0e0', '#f8f8f2']
endif

" LightGray
hi Comment guifg=#d4d0ab guibg=none gui=NONE
" Red
hi Statement guifg=#ffa07a guibg=none gui=NONE
" Green
hi Type guifg=#abe338 guibg=none gui=NONE
" Yellow
hi Constant guifg=#ffd700 guibg=none gui=NONE
" Magenta
hi Special guifg=#dcc6e0 guibg=none gui=NONE
" Cyan
hi Identifier guifg=#00e0e0 guibg=none gui=NONE
" White
hi Normal guifg=#f8f8f2 guibg=none gui=NONE
" Other highlight groups
hi ErrorMsg guifg=#2b2b2b guibg=#ffa07a gui=bold
hi Ignore guifg=#2b2b2b guibg=#d4d0ab gui=NONE
hi Search guifg=#2b2b2b guibg=#ffd700 gui=bold
hi Title guifg=NONE guibg=NONE gui=bold
hi Todo guifg=#2b2b2b guibg=#abe338 gui=bold
hi Underlined guifg=NONE guibg=NONE gui=underline
hi Visual guifg=NONE guibg=NONE gui=reverse

" -------------------------------------------------------
" §3.2. Vim highlight groups for 256-color Xterm consoles
" -------------------------------------------------------

" Xterm colors are available to most modern terminal emulators.
if s:t_Co >= 256
  " LightGray
  hi Comment ctermfg=187 ctermbg=235 cterm=NONE
  " Red
  hi Statement ctermfg=209 ctermbg=235 cterm=NONE
  " Green
  hi Type ctermfg=118 ctermbg=235 cterm=NONE
  " Yellow
  hi Constant ctermfg=220 ctermbg=235 cterm=NONE
  " Magenta
  hi Special ctermfg=219 ctermbg=235 cterm=NONE
  " Cyan
  hi Identifier ctermfg=45 ctermbg=235 cterm=NONE
  " White
  hi Normal ctermfg=255 ctermbg=235 cterm=NONE
  " Other highlight groups
  hi ErrorMsg ctermfg=235 ctermbg=209 cterm=bold
  hi Ignore ctermfg=235 ctermbg=187 cterm=NONE
  hi Search ctermfg=235 ctermbg=220 cterm=bold
  hi Title ctermfg=NONE ctermbg=NONE cterm=bold
  hi Todo ctermfg=235 ctermbg=118 cterm=bold
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi Visual ctermfg=NONE ctermbg=NONE cterm=reverse
  unlet s:t_Co
  finish
endif

" -----------------------------------------------------
" §3.3. Vim highlight groups for 16-color ANSI consoles
" -----------------------------------------------------

" ANSI colors are available to most legacy terminal emulators.
if s:t_Co >= 16
  " LightGray
  hi Comment ctermfg=LightGray ctermbg=Black cterm=NONE
  " Red
  hi Statement ctermfg=Red ctermbg=Black cterm=NONE
  " Green
  hi Type ctermfg=Green ctermbg=Black cterm=NONE
  " Yellow
  hi Constant ctermfg=Yellow ctermbg=Black cterm=NONE
  " Magenta
  hi Special ctermfg=Magenta ctermbg=Black cterm=NONE
  " Cyan
  hi Identifier ctermfg=Cyan ctermbg=Black cterm=NONE
  " White
  hi Normal ctermfg=White ctermbg=Black  cterm=NONE
  " Other highlight groups
  hi ErrorMsg ctermfg=Black ctermbg=Red cterm=bold
  hi Ignore cterm=NONE ctermfg=Black ctermbg=LightGray
  hi Search ctermfg=Black ctermbg=Yellow cterm=bold
  hi Title ctermfg=NONE ctermbg=NONE cterm=bold
  hi Todo ctermfg=Black ctermbg=Green cterm=bold
  hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
  hi Visual ctermfg=NONE ctermbg=NONE cterm=reverse
  unlet s:t_Co
  finish
endif
]])
