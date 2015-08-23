set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

filetype off
filetype plugin indent off

if ! isdirectory(expand('~/.vim/bundle'))
  echon 'Installing neobundle.vim...'
  silent call mkdir(expand('~/.vim/bundle'), 'p')
  silent call system('git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim')
  echo 'done.'
  if v:shell_error
    echoerr 'neobundle.vim installation has failed!'
    finish
  endif
endif

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/vimproc', {
  \   'build' : {
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \   },
  \ }

NeoBundle 'ctrlpvim/ctrlp.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'nanotech/jellybeans.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

set nobackup
set noswapfile
set noundofile

set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

set scrolloff=5
set wildmenu
set wildmode=list:longest
set hidden
set autoread
set splitright
set splitbelow

set cursorline
set laststatus=2

nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
vnoremap j gj
vnoremap gj j
vnoremap k gk
vnoremap gk k

if neobundle#tap('ctrlp.vim')
  let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
  let g:ctrlp_switch_buffer = 'Et'
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_use_caching = 1
  let g:ctrlp_clear_cache_on_exit = 0
  let g:ctrlp_open_new_file = 'r'
  let g:ctrlp_prompt_mappings = {
    \   'PrtBS()': ['<bs>'],
    \   'PrtCurLeft()': ['<left>'],
    \   'PrtCurRight()': ['<right>'],
    \   'PrtClearCache()': ['<c-l>'],
    \ }

  let g:ctrlp_mruf_max = 300

  nnoremap [ctrlp] <Nop>
  nnoremap m <Nop>
  nmap m [ctrlp]

  " Buffer
  nnoremap <silent> [ctrlp]b :<C-u>CtrlPBuffer<CR>
  " MRU
  nnoremap <silent> [ctrlp]m :<C-u>CtrlPMRUFiles<CR>
  " Tag
  nnoremap <silent> [ctrlp]t :<C-u>CtrlPTag<CR>
  " Dir
  nnoremap <silent> [ctrlp]d :<C-u>CtrlPDir<CR>

  call neobundle#untap()
endif

if neobundle#tap('lightline.vim')
  function! GitBranchName() " {{{
    try
      if exists('*fugitive#head')
        let _ = fugitive#head()
        return strlen(_) ? _ : ''
      endif
    catch
    endtry
    return ''
  endfunction " }}}

  let g:lightline = {
    \   'colorscheme': 'jellybeans',
    \   'active': {
    \     'left': [
    \       ['mode', 'paste'],
    \       ['git_branch_name', 'readonly', 'filename', 'modified']
    \     ]
    \   },
    \   'component_function': {
    \     'git_branch_name': 'GitBranchName'
    \   }
    \ }

  call neobundle#untap()
endif

syntax enable

set t_Co=256
colorscheme jellybeans

if filereadable(expand('~/.vimrc.local'))
  execute 'source' expand('~/.vimrc.local')
endif

filetype on
