" Plugins
" see https://github.com/junegunn/vim-plug
" for more details.
call plug#begin(stdpath('data') . '/plugged')
  Plug 'preservim/nerdtree'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
  Plug 'morhetz/gruvbox'
call plug#end()

" global configuration
syntax on
set number
set noswapfile
set hlsearch
set ignorecase
set incsearch

set list
set listchars=eol:↙,tab:\ \ ⇆,trail:●,extends:…,precedes:…,space:·

set autoindent
set tabstop=2
set shiftwidth=2
set expandtab

set wildignore+=*/.git/*,*/node_modules/*,*/build/*,

" navigate through buffers
nnoremap <C-j> :bprevious<CR>
nnoremap <C-k> :bnext<CR>

" gruvbox theme
colorscheme gruvbox

" fzf
nnoremap ; :GFiles<CR>

" NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['.git[[dir]]','node_modules[[dir]]','build[[dir]]']

" ctrlp.vim
" ignore file in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'wombat'


" Automatically remove all trailing whitespace on save
" https://vim.fandom.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * %s/\s\+$//e

" Moving lines up or down
" https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <S-j> :m .+1<CR>==
nnoremap <S-k> :m .-2<CR>==
inoremap <S-j> <Esc>:m .+1<CR>==gi
inoremap <S-k> <Esc>:m .-2<CR>==gi
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv

