syntax on
let mapleader = ","
set smartcase
set autoread
autocmd! bufwritepost $MYVIMRC source $MYVIMRC
au BufWinLeave *.* silent! mkview
au BufWinEnter *.* silent! loadview
set completeopt=menu
set noswapfile
set showcmd
set foldenable
set foldlevel=100
set foldmethod=indent
set hidden
set hid
set autoindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent
set showmatch
set iskeyword=@,48-57,_,192-255
set cursorline
set wildmenu
set wildmode=longest:full,full
set number
set exrc
set clipboard+=unnamedplus
set title
set mat=2
set spelllang=en_us,ru_yo
set spell
set langmap=КЕНГШЩЗФЫВАПРОЛДЖЧСМИТЬБЮ;PYFGCRLAOEUIDHTNSQJKXBMWV,кенгшщзфывапролджчсмитьбю;pyfgcrlaoeuidhtnsqjkxbmwv
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
filetype plugin on
call plug#begin()
Plug 'neutaaaaan/iosvkem'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-rooter'
Plug 'bling/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
Plug 'cdelledonne/vim-cmake'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'lervag/vimtex'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'python-rope/ropevim'
Plug 'itchyny/vim-cursorword'
Plug 'scrooloose/nerdcommenter'
Plug 'tikhomirov/vim-glsl'
call plug#end()
nnoremap <F8> :TagbarToggle<CR>
set background=dark
colorscheme Iosvkem
set termguicolors
let g:airline_powerline_fonts = 1
let g:instant_markdown_mathjax = 1
let g:vim_markdown_math = 1
let g:tagbar_position = 'left'
source /home/dmitry/.config/nvim/coc.nvim
nmap <leader>w :w<CR>
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
set colorcolumn=100
noremap <leader>s :Rg<CR>
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

autocmd InsertLeave * set nopaste
let g:cpp_class_decl_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
