" .-./`) ,---.   .--..-./`) ,---------.   ,---.  ,---..-./`) ,---.    ,---. 
" \ .-.')|    \  |  |\ .-.')\          \  |   /  |   |\ .-.')|    \  /    | 
" / `-' \|  ,  \ |  |/ `-' \ `--.  ,---'  |  |   |  .'/ `-' \|  ,  \/  ,  | 
"  `-'`"`|  |\_ \|  | `-'`"`    |   \     |  | _ |  |  `-'`"`|  |\_   /|  | 
"  .---. |  _( )_\  | .---.     :_ _:     |  _( )_  |  .---. |  _( )_/ |  | 
"  |   | | (_ o _)  | |   |     (_I_)  _ _\ (_ o._) /  |   | | (_ o _) |  | 
"  |   | |  (_,_)\  | |   |    (_(=)_)( ` )\ (_,_) /   |   | |  (_,_)  |  | 
"  |   | |  |    |  | |   |     (_I_)(_{;}_)\     /    |   | |  |      |  | 
"  '---' '--'    '--' '---'     '---' (_,_)  `---`     '---' '--'      '--'

"===== PLUGINS =====
" Make sure to install vim-plug first.
call plug#begin('~/.config/nvim/plugged')
" ctrl-p fuzzy file finding
Plug 'kien/ctrlp.vim'
" javascript syntax highlighting
Plug 'othree/yajs.vim', { 'for': 'javascript' }
" javascript indentation
Plug 'jason0x43/vim-js-indent', { 'for': 'javascript' }
" json highlighting
Plug 'elzr/vim-json'
" color schemes
Plug 'morhetz/gruvbox'
Plug '~/.config/nvim/pufflehuff'
" gcc to comment out a line, gc to comment out a motion, gc in visual to
" comment a selection
Plug 'tpope/vim-commentary'
" Visually mark indentation levels with <Leader>ig
Plug 'nathanaelkane/vim-indent-guides'
" Align text
Plug 'junegunn/vim-easy-align'
" Edit remote files in a project based manner
Plug 'zenbro/mirror.vim'
" OCaml indentation
Plug 'def-lkb/ocp-indent-vim'
" Syntax checking
Plug 'scrooloose/syntastic'
" Surround text with things like quotes or html tags
Plug 'tpope/vim-surround'
" Various golang utilities
Plug 'fatih/vim-go'
" Stylus highlighting
Plug 'wavded/vim-stylus'
" Pug highlighting
Plug 'digitaltoad/vim-pug'
" Neovim autocomplete package
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" Deoplete for golang
Plug 'zchee/deoplete-go', { 'do': 'make'}
" Rust code completion
Plug 'racer-rust/vim-racer'
" Rust syntax highlighting
Plug 'rust-lang/rust.vim'

call plug#end()
"===== SETTINGS =====
"--- COLORS ---
" Turn on syntax highlighting
syntax on
" Let the editor know we prefer using a dark background
set background=dark
" Choose the colorscheme
colorscheme pufflehuff
" Allow 256 colors in terminal. Ignored by neovim.
set t_Co=256

"--- TABS AND SPACES ---
" Tabs to spaces
set expandtab
" Indent amount for < and > commands
set shiftwidth=2
" Tabs are this many spaces wide
set tabstop=2

" Copies the indentation from the previous line, without interfering with file specific settings.
set autoindent

" Allow autocommands based on filetype
filetype plugin indent on

"--- SEARCH ---
" Case insensitive
set ignorecase
" Highlight matches
set hlsearch
" Search and replace globally by default with :s/foo/bar
set gdefault
" 'Nicer' regular expressions when searching.
" I need to explore the differences more carefully, see :help magic
set magic

"--- LOOK AND FEEL ---
" Wrap text
set lbr

" Show commands as they are intiiated
set showcmd

"--- BEHAVIOR ---
" Deletes extra spaces when using J to join
set nojoinspaces
" Don't beep
set noerrorbells visualbell t_vb=

" Switch off compatability with old bugs
" This is no longer necessary with nvim, but I'll keep it here for posterity
if !has('nvim')
  set nocompatible
endif

" I don't like folding (when vim collapses lines). This prevents it, and
" includes an extra workaround to prevent diffs from doing it as well.
set nofoldenable
set diffopt+=context:99999

" Modeline allow files to give hints about how they should be processed
" We'll leave it in as optional, as in theory it would slow things down a bit.
" set modeline

" Split horizontal opens a window below, instead of the default which is to open above.
set splitbelow

" Don't go to the start of the line when paging up or down.
set nostartofline

" Set backspace to work with everything
set backspace=indent,eol,start

" Set a smaller wait time for executing commands with more than one keystroke
set ttimeout
set ttimeoutlen=100

" Delete comment character when joining commented lines
set formatoptions+=j

" Buffers are hidden instead of abandoned. Turned this on for vim-racer.
set hidden

" Point to python
let g:python_host_prog = '/usr/local/bin/python'

" Stop sql filetype from binding ctrl-c to omnicomplete
let g:ftplugin_sql_omni_key = '<C-|>'

"====== FUNCTIONS ======
" <Leader>si - tells you what syntax rule the cursor is on
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <Leader>si :call <SID>SynStack()<CR>

"===== SHORTCUTS =====
" Map leader to space and local leader to comma
let maplocalleader=","
let mapleader="\<Space>"

" Semi-colon acts as colon for commands in normal mode
nnoremap ; :
vnoremap ; :
" Shift-q executes the default register (for recorded macros)
nnoremap Q @q

" These are to cancel the default behavior of d, D, c, C
" to put the text they delete in the default register.
" Note that this means e.g. "ad won't copy the text into
" register a anymore. You have to explicitly yank it.
nnoremap d "_d
vnoremap d "_d
nnoremap D "_d
vnoremap D "_d
" Including the clipboard setting here, because if you remove unnamed,
" you need to set the bindings to M \"0d and MM \"0dd (without the
" backslashes)
set clipboard=unnamed
nnoremap M "*d
vnoremap M "*d
nnoremap MM "*dd
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C
nnoremap x "_x
vnoremap x "_x

" Avoid command-line redraw on every entered character 
" by turning off Arabic 
" shaping (which is implemented poorly). 
if has('arabic') 
  set noarabicshape 
endif 

" easier tab navigation
nnoremap <C-h> gT
nnoremap <C-l> gt
inoremap <C-h> <Esc>gT
inoremap <C-l> <Esc>gt
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>
" For some reason in iterm2, <C-h> sends a <BS> instead of \177
" The alternate fix to this is to make a new terminfo entry
" infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
" tic $TERM.ti
" - from https://github.com/neovim/neovim/issues/2048
if has('nvim')
  nmap <BS> gT
endif

" Moves tab position right and left
nnoremap <silent> <C-k> :+tabmove<CR>
nnoremap <silent> <C-j> :-tabmove<CR>

" Turn off highlighting after a search
nnoremap <silent> <C-n> :noh<CR>

" More accessible way to go to the start or end of the line
nmap H ^
nmap L $

" Link merlin (for ocaml syntax checking) to vim in the runtime path.
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"


"===== CTRLP =====
" Open files
nnoremap <silent> <Leader>o :CtrlP<CR>
" Open buffers
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
" Open most recently used files
nnoremap <silent> <Leader>f :CtrlPMRUFiles<CR>
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|hg|svn'

"===== EasyAlign =====
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"===== Syntastic ====
" Beginner statusline defaults
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_html_tidy_quiet_messages = { "!level": "warnings" }
" Play nice with go
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
nnoremap <C-s>e :SyntasticCheck<CR>
nnoremap <C-s>t :SyntasticToggle<CR>
" Close the error list
nnoremap <C-s>c :lclose<CR>
" Open the error list
nnoremap <C-s>o :Errors<CR>
" OCaml
let g:syntastic_ocaml_checkers = ['merlin']

"===== JSON =====
" turn off hiding quotes
let g:vim_json_syntax_conceal=0

"===== vim-go =====
" Specify the window to output commands in.
let g:go_list_type = "quickfix"

"===== Deoplete =====
" Use deoplete.
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni_patterns')
  let g:deoplete#omni_patterns = {}
endif
let g:deoplete#omni_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'
" Bind tab to omnicomplete
inoremap <S-TAB> <C-x><C-o>

"===== vim-racer =====
let g:racer_cmd = "racer"
let $RUST_SRC_PATH="~/rust/source/src/"
