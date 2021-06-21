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
Plug 'joshdick/onedark.vim'
Plug 'janko-m/vim-test'
Plug 'OmniSharp/omnisharp-vim'
Plug 'rust-lang/rust.vim'
call plug#end()
nnoremap <F8> :TagbarToggle<CR>
set background=dark
set termguicolors
colorscheme Iosvkem
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

let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:instant_markdown_mathjax = 1
let g:vim_markdown_math = 1
let g:tagbar_position = 'left'
let g:airline_detect_spell = 0

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

let g:airline_skip_empty_sections = 1
let g:airline_section_x = ''
let g:airline_section_y = ''


function MyCustomPythonHighlights()
	hi semshiImported        guifg=#b67fda cterm=NONE gui=None
	hi semshiGlobal          guifg=#b67fda
	hi semshiBuiltin         guifg=#00aa80
	hi semshiAttribute       guifg=#b67fda
	hi semshiSelf            guifg=#519af8
endfunction
autocmd FileType python call MyCustomPythonHighlights()

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview', 'popup'
" and 'popuphidden' if you don't want to see any documentation whatsoever.
" Note that neovim does not support `popuphidden` or `popup` yet:
" https://github.com/neovim/neovim/issues/10996
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  " Highlight the completion documentation popup background/foreground the same as
  " the completion menu itself, for better readability with highlighted
  " documentation.
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
  set previewheight=5
endif

let g:coc_sources_disable_map = { 'cs': ['cs-1', 'cs-2', 'cs-3'] }

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END
