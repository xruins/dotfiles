
set nowritebackup
set nobackup
set virtualedit=block
set backspace=indent,eol,start
set ambiwidth=double
set wildmenu

" --------------------
"  search
" --------------------
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

" --------------------
"  appearance
" --------------------
set noerrorbells
set shellslash
set showmatch matchtime=1
" change indent way
set cinoptions+=:0
set cmdheight=2
set laststatus=2
set showcmd
set display=lastline
" show TAB and EOL
set list

set listchars=tab:^\ ,trail:~
set history=10000

" indent and tab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" hide some bars
set guioptions-=T
set guioptions-=m
set guioptions+=R

set showmatch
set smartindent
set noswapfile
set nofoldenable
set title
set number

" --------------------
"  UI behaviour
" --------------------

" copy to clipboard when yank
set guioptions+=a
set clipboard=unnamed,autoselect
" press Esc twice to disable highlight
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
syntax on
" treat all numbers as decimal
set nrformats=
" cursor movement over rows
set whichwrap=b,s,h,l,<,>,[,],~
" let buffer scroll with mouse wheel
set mouse=a

" auto reload .vimrc
augroup source-vimrc
  autocmd!
    autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
	  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
	  augroup END

" auto comment off
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" preserve location of cursor
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
	    autocmd BufRead *.txt set tw=78
		    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif