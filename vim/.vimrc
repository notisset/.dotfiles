set formatoptions-=cro
set nocompatible              " be iMproved, required
set pastetoggle=<F10>
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin '907th/vim-auto-save'
Plugin 'scrooloose/nerdtree'
Plugin 'plasticboy/vim-markdown'
Plugin 'nelstrom/vim-markdown-preview'
"Plugin 'suan/vim-instant-markdown'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" turn on filetype
filetype plugin indent on
syntax enable

" markdown syntax highlighting for md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
