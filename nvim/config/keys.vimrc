let mapleader=','

nnoremap <leader>o :only<CR>

nnoremap Y y$

" Search using vimgrep
:nnoremap ff :vimgrep <cword> **/*.hs<CR>
:nnoremap <leader>ff :vimgrep <cword> **/*.sql<CR>

" Git
:nnoremap gf :G<CR>
:nnoremap gv :Gvdiff<CR>

" Rename variable
function! Rnvar()
  let word_to_replace = expand("<cword>")
  "let replacement = input("New name: " . word_to_replace)
  let replacement = input("New name: ")
  execute '%s/' . word_to_replace . '/' . replacement . '/gc'
endfunction
:nnoremap <leader>rn :call Rnvar()<CR>

" Replace tabs with spaces
:nnoremap <leader>tt :%s/\t/  /g<CR>

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

" Nerdtree
map <C-F> :NERDTreeToggle<CR>
map <C-S> :NERDTreeFind<CR>

" Toggle display of tabs and EOF
nnoremap <leader>l :set list!<CR>

" Help on current word
augroup vimscript_augroup
  autocmd!
  autocmd FileType vim nnoremap <buffer> <M-z> :execute "help" expand("<cword>")<CR>
augroup END

" Fuzzy finder shortcut
nnoremap <C-p> :FZF<CR>
let $FZF_DEFAULT_COMMAND='rg --hidden --files'

" Hoogle
nnoremap <leader>1 :Hoogle<CR>
nnoremap <leader>2 :HoogleClose<CR>
nnoremap <leader>3 :SyntasticToggleMode<CR>
nnoremap <leader>5 :LLPStartPreview<CR>
"au BufNewFile,BufRead *.hs map <buffer> <F1> :Hoogle

" Unicode Characters
"imap <buffer> \forall ∀
"imap <buffer> \to →
"imap <buffer> \lambda λ
"imap <buffer> \Sigma Σ
"imap <buffer> \exists ∃
"imap <buffer> \equiv ≡

" Ormolu
nnoremap <M-f> :call RunOrmolu()<CR>

" Coc
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
