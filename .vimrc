call plug#begin('~/.vim/plugged')
let mapleader = ','
let g:mapleader = ','
let g:plug_timeout = 100

" ================================ Plugins to be installed =======================================
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer' }
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'kien/rainbow_parentheses.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Lokaltog/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/DrawIt'
Plug 'terryma/vim-expand-region'
"Plug 'plasticboy/vim-markdown'
Plug 'aceofall/gtags.vim'
Plug 'erikzaadi/vim-ansible-yaml'

" themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'
Plug 'tomasr/molokai'
Plug 'cocopon/iceberg.vim'
Plug 'zenorocha/dracula-theme'
Plug 'daylerees/colour-schemes'


" languages-perl
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }

"Load local plugins
if filereadable(expand("~/.vim/vimrc.bundles.local"))
  source ~/.vim/vimrc.bundles.local
endif

call plug#end()


" ================================ global configuration =======================================
set nocompatible                                             " don't bother with vi compatibility
syntax enable                                                " enable syntax highlighting
filetype on                                                  " turn on file type check
filetype indent on                                           " turn on indent acording to file type
filetype plugin on                                           " turn on indent acording to file type and plugin
filetype plugin indent on
set autoindent
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set clipboard=unnamed                                        " yank and paste with the system clipboard
set directory-=.                                             " don't store swapfiles in the current directory
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set list                                                     " show trailing whitespace
set number                                                   " show line numbers
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set showcmd
set smartcase                                                " case-sensitive search if any caps
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full
set binary
set hlsearch                                                 " highlight search
set noeol                                                    " no end of line at the end of the file
set cursorcolumn
set cursorline
set completeopt=longest,menu

" Show “invisible” characters
set list
set list listchars=tab:\¦\                                   " for indentline plugin
set listchars=tab:▸\ ,trail:▫
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
"set lcs=tab:▸\ ,trail:·

" tab
set tabstop=4     " 设置Tab键的宽度[等同的空格个数]
set shiftwidth=4  " 每一次缩进对应的空格数
set softtabstop=4 " 按退格键时可以一次删掉 4 个空格
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set expandtab     " 将Tab自动转化成空格    [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set shiftround    " 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'

" FileEncode Settings
set encoding=utf-8                                                       " 设置新文件的编码为 UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1  " 自动判断编码时，依次尝试以下编码：
set termencoding=utf-8
set ffs=unix,dos,mac                                         " Use Unix as the standard file type
set formatoptions+=m
set formatoptions+=B
set hidden                                                   " A buffer becomes hidden when it is abandoned
set wildmode=list:longest
set ttyfast

" configuration for airline
set t_Co=256
set laststatus=2


" Enable basic mouse behavior such as resizing buffers.
set mouse-=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" macos vs linux clipboard
if has("mac")
  set clipboard+=unnamed
else
  set clipboard=unnamedplus
endif


" ================================ Key Mapping =======================================
" :help map ===> [n|v|nore|un|]map
" nore: no recursive
" map {lhs} {rhs} ===> 表示将{lhs}按键序列映射到{rhs}按键序列
" Command-Line/Ex Mode
" normal mode enter (:) and then get into Command-Line namely C-mode
" normal mode enter (Q) and then get into multi-Command-Line namely Ex-mode

let mapleader = ','
let g:mapleader = ','
inoremap jj <ESC>
set pastetoggle=<leader>2

map <F2>                     :retab <CR> :wq! <CR>
map Y                        y$
map <leader><space>          :FixWhitespace<cr>

" normal no recursive mapping
nnoremap <leader>p           :CtrlP<CR>
nnoremap <leader>b           :CtrlPBuffer<CR>
nnoremap <leader>f           :CtrlPMRU<CR>
nnoremap <leader>T           :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <Leader>aa          :Ag!<space>
nnoremap <Leader>aw          :Ag! -w<space>
nnoremap <Leader>aq          :Ag -Q<space>
nnoremap <Leader>as          :Ag ''<left>
nnoremap <leader>n           :NERDTreeToggle<CR>
nnoremap <leader>]           :TagbarToggle<CR>
nnoremap <leader>jd          :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gd          :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>w           :w<CR>
nnoremap <leader>it          :IndentLinesToggle<CR>
nnoremap <leader>0           :GundoToggle<CR>

nnoremap <Leader>gd          :Gdiff<CR>
nnoremap <Leader>gc          :Gcommit<CR>
nnoremap <Leader>ga          :Gcommit --amend<CR>
nnoremap <Leader>gs          :Gstatus<CR>
nnoremap <Leader>gb          :Gblame<CR>
nnoremap <Leader>gw          :Gwrite<CR>
nnoremap <Leader>gpp         :Gpush<CR>
nnoremap <Leader>gpf         :Gpush -f
nnoremap <Leader>gpd         :Gpush --dry<CR>
nnoremap <Leader>gpr         :Gpull --rebase<CR>
nnoremap <Leader>gfc         :Git checkout %<CR>
nnoremap <Leader>gfr         :Gremove<CR>
nnoremap <Leader>gP          :Git push -u origin<space>
nnoremap <silent> <Leader>g1 :Git diff<CR>
nnoremap <silent> <Leader>g2 :Git diff --staged<CR>

" no recursive normal and visual mode mapping
noremap <leader>gh           :! open https://github.com<CR>
noremap <leader>gg           :! open https://google.com<CR>
noremap <leader>g            :GitGutterToggle<CR>
noremap <silent><leader>/    :nohls<CR> " 去掉搜索高亮
noremap <leader>nep          :set noexpandtab<CR>
noremap <C-h>                <C-w>h
noremap <C-j>                <C-w>j
noremap <C-k>                <C-w>k
noremap <C-l>                <C-w>l
nnoremap <C-t>               :tabnew<CR>
inoremap <C-t>               <Esc>:tabnew<CR>
nnoremap [b                  :bprevious<cr>
nnoremap ]b                  :bnext<cr>
noremap <left>               :bp<CR>
noremap <right>              :bn<CR>
nnoremap <leader>q           :q<CR>
nnoremap <C-e>               2<C-e>
nnoremap <C-y>               2<C-y>
nnoremap <C-t>               :tabnew<CR>
inoremap <C-t>               <Esc>:tabnew<CR>

" nomal mapping
nmap s                       <Plug>(easymotion-s)
nmap t                       <Plug>(easymotion-s2)
nmap <Leader>cp              :!xclip -i -selection clipboard % <CR><CR>

" command line mode no recursive mode mapping
cnoremap <C-k>               <t_ku>
cnoremap <C-a>               <Home>
cnoremap <C-e>               <End>
cnoremap w!!                 %!sudo tee > /dev/null %

" visual mode mapping
vmap v                      <Plug>(expand_region_expand)
vmap V                      <Plug>(expand_region_shrink)
vnoremap <                  <gv
vnoremap >                  >gv


" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Go crazy!
if filereadable(expand("~/.vimrc.local"))
  " In your .vimrc.local, you might like:
  " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
  " autocmd! bufwritepost .vimrc source ~/.vimrc
  source ~/.vimrc.local
endif


" =========================> plugins config <===============================================
" Track the engine.
" Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
" Plugin 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" git submodule update --init --recursive
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsExpandTrigger       = '<C-j>'
let g:UltiSnipsJumpForwardTrigger  = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:UltiSnipsSnippetDirectories  = ['UltiSnips']
let g:UltiSnipsSnippetsDir         = '~/.vim/UltiSnips'
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" YouCompleteMe
" remap Ultisnips for compatibility for YCM
let g:ycm_goto_buffer_command      = 'horizontal-split'
let g:ycm_global_ycm_extra_conf    = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" syntastic'
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5
highlight SyntasticErrorSign guifg=white guibg=black

" gtags
set cscopetag                  " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope'   " 使用 gtags-cscope 代替 cscope
let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1

" vim-easymotion
let g:EasyMotion_smartcase = 1

" vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'


" vim-signature
" m[a-zA-Z]   打标签
" '[a-zA-Z]   跳转到标签位置
" '. 最后一次变更的地方
" '' 跳回来的地方
" m<space>    去除所有标签


" ctrlp.vim
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window = 'order:ttb,max:20'
"let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1


" ctrlsf.vim
" In CtrlSF window:
" 回车/o, 打开
" t 在tab中打开(建议)
" T - Lkie t but focus CtrlSF window instead of opened new tab.
" q - Quit CtrlSF window.
" let g:ctrlsf_position = 'below'
" let g:ctrlsf_winsize = '30%'
let g:ctrlsf_auto_close = 0
let g:ctrlsf_confirm_save = 0
" Note: cannot use <CR> or <C-m> for open
" Use : <sapce> or <tab>
let g:ctrlsf_mapping = {
    \ "open"  : "<Space>",
    \ "openb" : "O",
    \ "tab"   : "t",
    \ "tabb"  : "T",
    \ "prevw" : "p",
    \ "quit"  : "q",
    \ "next"  : "<C-J>",
    \ "prev"  : "<C-K>",
    \ "pquit" : "q",
    \ }



" Automatic commands
if has("autocmd")
  " COOL HACKS
  " Make sure Vim returns to the same line when you reopen a file.
  augroup line_return
      au!
      au BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \     execute 'normal! g`"zvzz' |
          \ endif
  augroup END

  fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
  call cursor(l, c)
    endfun

  autocmd BufNewFile,BufRead *.h  setlocal filetype=h

  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  endif

  au BufNewFile,BufRead *.yaml set filetype=yaml.ansible
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.md set spell
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript " Treat .json files as .js
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown " Treat .md files as Markdown
  autocmd FileType python,c,c++,lua set tabstop=4 shiftwidth=4 expandtab ai
  autocmd FileType ruby,javascript,sh,go,html,css,scss set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
  autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown.mkd
  autocmd FileType c,cpp,erlang,go,lua,javascript,python,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
  au Syntax * RainbowParenthesesLoadRound
endif


" ======================== UI =======================
" rainbow_parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" vim-airline
" airline {{{
    " use the patched font for powerline: https://github.com/powerline/fonts
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_left_sep = '▶'
    let g:airline_left_alt_sep = '❯'
    let g:airline_right_sep = '◀'
    let g:airline_right_alt_sep = '❮'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '⎇'
    " 是否打开tabline
    let g:airline#extensions#tabline#enabled = 1
" }}}

if (&t_Co == 256 || has('gui_running'))
    if ($TERM_PROGRAM == 'iTerm.app')
        "colorscheme molokai
        "colorscheme iceberg
        colorscheme dracula
    else
        "colorscheme solarized
        "colorscheme iceberg
        colorscheme dracula
    endif
endif

