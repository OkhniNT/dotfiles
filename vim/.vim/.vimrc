call plug#begin('~/.vim/plugged')

" Track the engine.
Plug 'SirVer/ultisnips'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Vim surround
Plug 'tpope/vim-surround'

" Goyo
" Plug 'junegunn/goyo.vim'
" let g:goyo_width = 150
" let g:goyo_height = "100%"
" let g:goyo_linenr = 0
" nnoremap <leader>g :Goyo<CR>

" Yuck
Plug 'elkowar/yuck.vim'

call plug#end()

" General
filetype plugin on
syntax on
colorscheme koehler
set t_Co=8
set nocompatible
set ttimeoutlen=100
set number
set relativenumber
set linebreak
set showmatch
set visualbell
set showcmd
set viminfo+=n~/.vim/viminfo
let mapleader = "\\"

" Searching
set hlsearch
set smartcase
set ignorecase
set incsearch

" Indenting
set expandtab
set autoindent
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Listchars
set lcs=eol:$,trail:~,extends:>,precedes:<,space:·
nnoremap <F8> :set list! <CR>

" Set tex_fast
let g:tex_fast = "bmMpr"
" let g:tex_conceal = ""

" Keybinds
" line numbers
nnoremap <F5> :set nu! rnu! <CR>
" spell check
inoremap <F7> <Esc>:setlocal spell! spelllang=en_au <CR>a
nnoremap <F7> :setlocal spell! spelllang=en_au <CR>
" autocorrect words
nnoremap <C-s> [sz=1<CR><CR>
" redraw screen
nnoremap <F9> :silent redraw! <CR>
" save
nnoremap == :w<CR>
" vim shell
nnoremap zS :shell<CR>
" latex figures
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "figures"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "figures" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
" latex pictures
nnoremap <leader>f : silent exec '.!latex_diagrams'<CR><CR>:w<CR><CR>f[

" Commands
" reload syntax highlighting
command WE :w | e %
" create vimwiki table
command T :VimwikiTable
" convert vimwiki to html
command VHALL :VimwikiAll2HTML
command VH :Vimwiki2HTML
" open tex in zathura
command Z :silent !zth '%:r'.pdf

" Autocommands
" auto change directory
au BufEnter * silent! lcd %:p:h
" :so after .vimrc write
au BufWritePost *.vimrc :so ~/.vim/.vimrc
" restart sxhkd after write
au BufWritePost *sxhkdrc silent !pkill -usr1 -x sxhkd
" restart picom after write
au BufWritePost *picom.conf silent !killall picom; setsid picom &
" restart polybar after write
au BufWritePost *polybar/config silent !killall polybar; setsid polybar bar &; xdo lower -N Polybar &
" make install after write to config.h
au BufWritePost *config.*h silent !sudo make clean install
" restart bspwm after write
au BufWritePost *bspwmrc silent !bspc wm -r
" bind == to compile latex
au BufRead,BufReadPre,BufNewFile *.tex map == :w <CR> :!pdflatex '%'; rm *.log *.aux <CR>
" latex au
au BufNewFile,BufRead *.tex
    \ set nocursorline |
    \ set nornu |
    \ set number |
    \ let g:loaded_matchparen=1
