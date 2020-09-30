" map leader
let mapleader=','

:nnoremap ff :vimgrep <cword> **/*.hs<CR>
:nnoremap <leader>ff :vimgrep <cword> **/*.sql<CR>

" Git
:nnoremap gf :G<CR>
:nnoremap gv :Gvdiff<CR>

" Quit
:nnoremap qq :q<CR>

" Rename
function! Rnvar()
  let word_to_replace = expand("<cword>")
  "let replacement = input("New name: " . word_to_replace)
  let replacement = input("New name: ")
  execute '%s/' . word_to_replace . '/' . replacement . '/gc'
endfunction
:nnoremap <leader>rn :call Rnvar()<CR>

" Replace tabs with spaces
:nnoremap <leader>tt :%s/\t/  /g<CR>

nnoremap <Esc><Esc> :w<CR>
nnoremap <leader>W :wa<CR>

nnoremap Y y$

" Delete without copying
"nnoremap <leader>d "_d
"xnoremap <leader>d "_d
"xnoremap <leader>p "_dP

" Switching buffer
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" Moving buffer
nnoremap <M-H> <C-w>H
nnoremap <M-J> <C-w>J
nnoremap <M-K> <C-w>K
nnoremap <M-L> <C-w>L
nnoremap <M-x> <C-w>x

" Resizing buffer
nnoremap <M-=> <C-w>=
nnoremap <M-+> <C-w>+
nnoremap <M--> <C-w>-
nnoremap <M-<> <C-w><
nnoremap <M->> <C-w>>

" Disable arrow keys and page up / down
noremap  <Up>       <nop>
noremap  <Down>     <nop>
noremap  <Left>     <nop>
noremap  <Right>    <nop>
inoremap <Up>       <nop>
inoremap <Down>     <nop>
inoremap <Left>     <nop>
inoremap <Right>    <nop>
vnoremap <Up>       <nop>
vnoremap <Down>     <nop>
vnoremap <Left>     <nop>
vnoremap <Right>    <nop>
noremap  <PageUp>   <nop>
inoremap <PageUp>   <nop>
vnoremap <PageUp>   <nop>
noremap  <PageDown> <nop>
inoremap <PageDown> <nop>
vnoremap <PageDown> <nop>

" Disable mouse / touchpad (only in vim)
inoremap <ScrollWheelUp> <nop>
inoremap <S-ScrollWheelUp> <nop>
inoremap <C-ScrollWheelUp> <nop>
inoremap <ScrollWheelDown> <nop>
inoremap <S-ScrollWheelDown> <nop>
inoremap <C-ScrollWheelDown> <nop>
inoremap <ScrollWheelLeft> <nop>
inoremap <S-ScrollWheelLeft> <nop>
inoremap <C-ScrollWheelLeft> <nop>
inoremap <ScrollWheelRight> <nop>
inoremap <S-ScrollWheelRight> <nop>
inoremap <C-ScrollWheelRight> <nop>

" Clear search highlighting
nnoremap <C-z> :nohlsearch<CR>

" Terminal mode exit shortcut
:tnoremap <Esc> <C-\><C-n>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"    Nerdtree
map <C-F> :NERDTreeToggle<CR>
map <C-S> :NERDTreeFind<CR>

" Toggle display of tabs and EOF
nnoremap <leader>l :set list!<CR>

" Help on current word
" Vimscript
augroup vimscript_augroup
  autocmd!
  autocmd FileType vim nnoremap <buffer> <M-z> :execute "help" expand("<cword>")<CR>
augroup END

" Fuzzy finder shortcut
nnoremap <C-p> :FZF<CR>
let $FZF_DEFAULT_COMMAND='rg --hidden --files'

" Dash
" :nmap <silent> <leader>d <Plug>DashSearch

" Hoogle
"au BufNewFile,BufRead *.hs map <buffer> <F1> :Hoogle
nnoremap <leader>1 :Hoogle<CR>
nnoremap <leader>2 :HoogleClose<CR>
nnoremap <leader>3 :SyntasticToggleMode<CR>
nnoremap <leader>5 :LLPStartPreview<CR>

nnoremap <leader>o :only<CR>

" Unicode Characters
"
" Already included in agda-vim plugin
"imap <buffer> \forall ∀
"imap <buffer> \to →
"imap <buffer> \lambda λ
"imap <buffer> \Sigma Σ
"imap <buffer> \exists ∃
"imap <buffer> \equiv ≡

" YouCompleteMe
map <leader>d :YcmCompleter GetDoc<CR>
map <leader>D :pc<CR>
map <leader>g :YcmCompleter GoTo<CR>
map <leader>t :YcmCompleter GetType<CR>
map <leader>f :YcmCompleter Format<CR>
map <leader>rr :YcmCompleter RefactorRename<CR>
