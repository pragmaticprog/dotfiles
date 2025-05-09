" in case want to set master tag file... set tags+=path/to/my/tags/file
" VIMSCRIPT -------------------------------------------------------------- {{{
" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
	    autocmd!
	        autocmd FileType vim setlocal foldmethod=marker
augroup END
" preserve views
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
" set the colourscheme
try
	colorscheme habamax
catch
	colorscheme default
endtry
" set status line colours for active window
autocmd ColorScheme * highlight StatusLine ctermbg=0 ctermfg=103
" set status line colours for inactive window
autocmd ColorScheme * highlight StatusLineNC ctermbg=0 ctermfg=240
" set colours for  tab
autocmd ColorScheme * highlight TabLineSel ctermbg=0 ctermfg=103
" set colours for inactive tabs
autocmd ColorScheme * highlight TabLine ctermbg=0 ctermfg=240
" set background colour of tab line
autocmd ColorScheme * highlight TabLineFill ctermbg=0
" }}}
" remaps {{{
" set tagjump
nnoremap <leader>t g<C-]>
" map jk to escape in insert mode 
inoremap <nowait> jk <ESC>
" map space k/j to moving a line up or down respectively
nnoremap <leader>k :m-2<CR>
nnoremap <leader>j :m+<CR>
" remove search highlights
nnoremap <leader>m :noh<CR>
" map splits in normal mode
nnoremap tt :split 
nnoremap tv :vsplit 
" view command history
nnoremap <leader>q q:
" open a hyperlink in librewolf
nnoremap gx :let @0 = expand('<cfile>')<CR>:exe ':silent !librewolf % <C-R>0'<CR>
" map fzf
nnoremap <silent> <C-f> :Files<CR>
" map fzf for git files
nnoremap <silent> <leader><S-f> :GFiles --cached --others --exclude-standard<CR>
" map ripgrep
nnoremap <silent> <leader>f :Rg<CR>
" map show buffers
nnoremap <silent> <leader>b :buffers<CR>
nnoremap <silent> <leader><S-b> :Buffers<CR>
" map Mundo
nnoremap <C-y> :MundoToggle<CR>
" map fold toggle
nnoremap <BS> za
" map dispatch plugin make 
noremap <C-m> :Make<CR>
" exit visual mode
vnoremap m <ESC>
" map sourcing the vimrc file
nnoremap <leader>r :source $MYVIMRC<CR>
" remap . to work in visual mode
vnoremap . :norm .<ENTER>
" visual mode remap to not lose selection on shifting text
xnoremap < <gv
xnoremap > >gv
" map a change vim current directory to directory of open buffer
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" map netrw
nnoremap <leader><s-e> :Explore<CR>
" }}}
" status line {{{
" Clear status line when vimrc is reloaded.
set statusline=
set laststatus=2
" Status line left side.
set statusline+=%#MODIFIED#
set statusline+=\ %M\ %-F\ %y\ %R
set statusline+=%=\%{FugitiveStatusline()}\%{gutentags#statusline()}\ %p%%
" }}}
" configs {{{
" replace vims :grep with greprg
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
" disables vi compatibility and allows for more vim specific features to work
set nocompatible 
" dont prompt user to save file when moving to another buffer
set hidden 
" Show current line number
set number 
" Show relative line numbers
set relativenumber 
" search without matching case unless there is at least one capital
set ignorecase smartcase 
" show incremental search results as you type
set incsearch 
" higlight all matching words to search
set hlsearch 
" disable swap file
set noswapfile 
" set the leader button to space instead of default \
let mapleader = " " 
" show when the leader button is active
set showcmd 
" enable undo persistence
set undodir=~/.vim/undo_dir
set undofile
" set screen rolloff so that there are always lines moving above/below the
" cursor when moving
set scrolloff=2
" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
" }}}
" plugins {{{
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
" plugins
call plug#begin()
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'simnalamburt/vim-mundo'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
let g:peekaboo_window = 'vertical botright 80new'
let g:peekaboo_compact = "1"
let g:mundo_width = 45
let g:mundo_preview_height = 25
let g:gutentags_modules = ['ctags']
let g:gutentags_enabled = 1
let g:gutentags_project_root = ['makefile'] 
call plug#end()
" }}}
