call plug#begin('~/.config/nvim/plugged')

" install plugins automatically if this first-run
if empty(glob('~/.config/nvim/plugged'))
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Navigation
" ==========
"
" Ctrl-p
" > open a fuzzy finder prompt for files in :pwd
"
" ;
" > Open a fuzzy finder of the open buffers
"
" -
" > Open netrw with the current file highlighted. Press again to go up
" > to parent with current dir highlighted
"
" Ctrl-[h,j,k,l]
" > Move to the specified pane, in any mode, even terminal
"
" Ctrl-\n
" > Get of terminal insert mode
"
" Ctrl-o
" > Zoom in/out of the current buffer 
"
" Misc
" ====
"
" <Enter>
" > In normal mode, clear any highlighted terms
"
" gc[motion] or selection
" > (un)Comment the selection

" themes
Plug 'cocopon/iceberg.vim'
Plug 'gkeep/iceberg-dark'

" tools for debugging themes
Plug 'cocopon/inspecthi.vim'
Plug 'cocopon/colorswatch.vim'

" VSCode like plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-eslint',
  \ ]

Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim' 
Plug 'jparise/vim-graphql'
Plug 'cespare/vim-toml'
Plug 'kevinoid/vim-jsonc'

Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" 

" Install the fzf binary
if filereadable('/usr/local/opt/fzf/plugin/fzf.vim')
  " from brew on osx
  Plug '/usr/local/opt/fzf'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif

" These are the vim wrappers for fzf
Plug 'junegunn/fzf.vim'

" Tim has some good reckons
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'

Plug 'troydm/zoomwintab.vim'

Plug 'mkarmona/colorsbox'

" Minimal status bar
Plug 'itchyny/lightline.vim'

" Show indicator for lines added/removed in the left gutter
Plug 'airblade/vim-gitgutter'

Plug 'joshdick/onedark.vim'

call plug#end()

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

let g:go_version_warning = 0

set termguicolors

let mapleader=","                     " comma is the leader key

" theming stuff

set background=dark
hi Quote ctermbg=109 guifg=#83a598
colorscheme iceberg
let g:lightline = { 'colorscheme': 'icebergDark' }
hi Quote ctermbg=109 guifg=#83a598

set visualbell                        " stop beeping at me

set number                            " show line numbers
set listchars=tab:▸\ ,eol:¬,trail:·   " textmate style whitespace markers
set nowrap                            " Don't wrap long lines
set tabstop=2                         " A tab is two spaces long
set shiftwidth=2                      " Auto-indent using 2 spaces
set expandtab                         " Use spaces instead of tabs
set smarttab                          " Backspace deletes whole tabs at the beginning of a line
set sts=2                             " Backspace deletes whole tabs at the end of a line
set list                              " Show invisible characters

set nojoinspaces                      " Avoid double spaces when joining lines
set nostartofline                     " don't jump to the start of line when scrolling

set ignorecase                        " Make searches case insensitive
set smartcase                         " (Unless they contain a capital letter)

set wildmenu                          " Sensible, powerful tab completion
set wildmode=list:longest,full        "

set mouse=a

" Highlight cursor line of currently active buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Enable relative line numbers when moving into a pane, disable when leaving
au FocusLost * :set norelativenumber
au FocusGained * :set relativenumber

" Use abs line numbers when editing a file, otherwise relative
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

au TermOpen * setlocal nonumber norelativenumber

" When editing JS/TS files do syntax highlighting from start of file
" to avoid things getting out of sync
" https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear


""""""""""""""""""""""
" FILE TYPES TO IGNORE
""""""""""""""""""""""""

set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/ruby/*,*/vendor/plugins/*,*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/node_modules/*,*/.sass-cache/*,*/tmp/*
set wildignore+=*/ebin/*,*/dev/*,*/rel/*,*/deps/*
set wildignore+=*/.git/*,*/.rbx/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/.pew
set wildignore+=*.swp,*~,._*

""""""""""""""""""""""""""""""""""""
" WHERE TO PUT BACKUP AND SWAP FILES
""""""""""""""""""""""""""""""""""""""
set backupdir=~/.nvim_backup,/tmp
set directory=~/.nvim_temp,/tmp

"""""""""""""""""""""""""""""""""""""""
" SET FILE TYPES FOR VARIOUS EXTENSIONS
""""""""""""""""""""""""""""""""""""""""
filetype on                       " Enable filetype detection
filetype indent on                " Enable filetype-specific indenting
filetype plugin on                " Enable filetype-specific plugins

function! s:setupWrapping()
  set wrap
  set linebreak
  set textwidth=72
  set nolist
endfunction

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,*.ru,*.rake,*.rabl} set ft=ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set ft=markdown | call s:setupWrapping()
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.scss set filetype=scss

" Remember last location in a file, unless it's a git commit message
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif

""""""""""""""""""""""""""""""""""""""""
" FILETYPE-SPECIFIC SETTINGS
"""""""""""""""""""""""""""""""""""""""""

autocmd FileType {c,objc,erlang} setlocal shiftwidth=4 tabstop=4 sts=4
autocmd FileType {go} setlocal shiftwidth=8 tabstop=8 sts=8 noexpandtab


autocmd FileType {markdown,git} setlocal spell

"""""""""""""""""""""""""""""""""""""""""
" CONFIGURE EXTENSIONS
"""""""""""""""""""""""""""""""""""""""""

let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1
let g:go_disable_autoinstall = 1

let g:go_highlight_structs = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

autocmd QuickFixCmdPost *grep* cwindow

""""""""""
" MAPPINGS
""""""""""

" Make :W do the same as :w
command! W :w

" Hit return to clear search highlighting
noremap <cr> :nohlsearch<cr>

" Move around splits with Ctrl + HJKL
tnoremap <c-h> <C-\><C-N><C-w>h
tnoremap <c-j> <C-\><C-N><C-w>j
tnoremap <c-k> <C-\><C-N><C-w>k
tnoremap <c-l> <C-\><C-N><C-w>l
inoremap <c-h> <C-\><C-N><C-w>h
inoremap <c-j> <C-\><C-N><C-w>j
inoremap <c-k> <C-\><C-N><C-w>k
inoremap <c-l> <C-\><C-N><C-w>l
nnoremap <c-h> <C-w>h
nnoremap <c-j> <C-w>j
nnoremap <c-k> <C-w>k
nnoremap <c-l> <C-w>l

" Hook up some shortcuts for fzf
nmap ; :Buffers<CR>
nmap <c-p> :Files<CR>
"" use rip-grep for searching files
nmap <c-g> :Rg<CR>

" Make it easy to edit/reload vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

let g:airline_powerline_fonts = 1

" <leader>G opens the Git status window
map <leader>G :Gstatus<cr>

" Press <leader>tb to open the tag bar
map <leader>tb :TagbarOpenAutoClose<cr>

" vim-go mappings

" Opens godoc for word under cursor in current window
au FileType go nmap <Leader>gd <Plug>(go-doc)
" As above, but in a vertical split
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gs <Plug>(go-doc-split)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" run :GoBuild or :GoTestCompile based on the kind of go file
" Taken from https://github.com/fatih/vim-go-tutorial
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" coc.vim
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" Allow jumping between errors in a file
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)

" use tab/shift-tab to navigate through suggestions
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MOVE WINDOW TO PREVIOUS/NEXT TAB
" http://vim.wikia.com/wiki/Move_current_window_between_tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! MoveToPrevTab()
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    vsp
  else
    close!
    exe "0tabnew"
  endif
  exe "b".l:cur_buf
endfunc

function! MoveToNextTab()
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    vsp
  else
    close!
    tabnew
  endif
  exe "b".l:cur_buf
endfunc
