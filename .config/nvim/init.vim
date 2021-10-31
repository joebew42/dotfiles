" Disable LSP features in ALE that are
" already provided by coc.nvim
let g:ale_disable_lsp = 1

" Plugins
" see https://github.com/junegunn/vim-plug
" for more details.
call plug#begin(stdpath('data') . '/plugged')
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-commentary'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'wincent/ferret'
  Plug 'vim-airline/vim-airline'
  Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
  Plug 'joshdick/onedark.vim'
  Plug 'sheerun/vim-polyglot' " Syntax Highlighting
  Plug 'chrisbra/Colorizer'
  Plug 'dense-analysis/ale' " Linting & Fixing
  Plug 'neoclide/coc.nvim', { 'branch': 'release' } " VSCode Extensions

  " JavaScript
  Plug 'neoclide/coc-tsserver', { 'do': 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-eslint', { 'do': 'yarn install --frozen-lockfile' }
  Plug 'neoclide/coc-prettier', { 'do': 'yarn install --frozen-lockfile' }
  Plug 'ruanyl/coc-coverage', { 'do': 'yarn install --froze-lockfile' }

  " Elixir
  Plug 'elixir-lsp/coc-elixir', { 'do': 'yarn install && yarn prepack' }
  Plug 'elixir-editors/vim-elixir'
  Plug 'mhinz/vim-mix-format'

  " Python
  Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " Syntax Highlighting
  Plug 'Vimjas/vim-python-pep8-indent' " PEP8 Indentation
  Plug 'fannheyward/coc-pyright', { 'do': 'yarn install --frozen-lockfile' }

  " Ruby/Rails
  " Go
  " Rust
call plug#end()

" Global configuration
syntax on

filetype plugin on

let g:mapleader=','

set spell
set spelllang=en_us

set termguicolors
set number
set cursorline
set hlsearch
set ignorecase
set incsearch

set list
set listchars=eol:↙,tab:\ \ ⇆,trail:●,extends:…,precedes:…
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab

set wildignore+=*/.git/*,*/node_modules/*,*/build/*,

set nobackup
set nowritebackup
set noswapfile

colorscheme onedark

" Disable spell check in terminal
augroup term_open
  autocmd!
  autocmd TermOpen * setlocal nospell
augroup END

" Ctags
" Update tags index file on buffer save
" Check ~/.ctags to define your custom rules
augroup ctags
  autocmd!
  autocmd BufWritePost *.js silent !ctags -R
  autocmd BufWritePost *.py silent !ctags -R
augroup END

" fzf
nnoremap <C-p> :GFiles<CR>
nnoremap <C-x> :GFiles?<CR>
nnoremap <C-a> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <S-f> :Rg<CR>
nnoremap <C-t> :Tags<CR>

" NERDTree
nnoremap <C-q> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['.git[[dir]]','node_modules[[dir]]','build[[dir]]']

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme = 'onedark'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = 'C'

" mhinz/vim-mix-format
let g:mix_format_on_save = 1


" ALE
let g:ale_linters = {
      \    'python': ['flake8'],
      \}

let g:ale_fixers = {
      \    '*': ['remove_trailing_lines', 'trim_whitespace'],
      \    'python': ['yapf'],
      \}

let g:ale_fix_on_save = 1

" Navigate between errors quickly
nmap <silent> <C-h> <Plug>(ale_previous_wrap)
nmap <silent> <C-l> <Plug>(ale_next_wrap)

" neoclide/coc.nvim
" https://github.com/neoclide/coc.nvim#example-vim-configuration
set hidden
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use Q to show documentation in preview window.
nnoremap <silent> Q :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

augroup cursor_hold
  autocmd!
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup filetype_typescript_json
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" end of neoclide/coc.nvim

" Moving lines up or down
" https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Moving cursor between wrapped lines
" https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Moving between buffers
nnoremap <A-m> :bn<CR>
nnoremap <A-n> :bp<CR>
nnoremap <A-w> :bd<CR>

" Moving between windows
nnoremap <A-j> :wincmd j<CR>
nnoremap <A-k> :wincmd k<CR>
nnoremap <A-h> :wincmd h<CR>
nnoremap <A-l> :wincmd l<CR>
