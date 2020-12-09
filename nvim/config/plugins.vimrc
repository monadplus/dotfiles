"
" ██████╗░██╗░░░░░██╗░░░██╗░██████╗░██╗███╗░░██╗░██████╗
" ██╔══██╗██║░░░░░██║░░░██║██╔════╝░██║████╗░██║██╔════╝
" ██████╔╝██║░░░░░██║░░░██║██║░░██╗░██║██╔██╗██║╚█████╗░
" ██╔═══╝░██║░░░░░██║░░░██║██║░░╚██╗██║██║╚████║░╚═══██╗
" ██║░░░░░███████╗╚██████╔╝╚██████╔╝██║██║░╚███║██████╔╝
" ╚═╝░░░░░╚══════╝░╚═════╝░░╚═════╝░╚═╝╚═╝░░╚══╝╚═════╝░

filetype plugin on "enable loading the plugin files.

"" Latex
let g:tex_flavor = 'latex'

"""vim-ctrlspace
let g:CtrlSpaceDefaultMappingKey = "<C-space> " "The last whitespace is intentional
let g:airline_exclude_preview = 1

"""vim-buftabline
nmap <M-1> <Plug>BufTabLine.Go(1)
nmap <M-2> <Plug>BufTabLine.Go(2)
nmap <M-3> <Plug>BufTabLine.Go(3)
nmap <M-4> <Plug>BufTabLine.Go(4)
nmap <M-5> <Plug>BufTabLine.Go(5)

""" vim-airline
let g:airline_powerline_fonts=1
let g:airline_statusline_ontop=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1

""" NerdTree
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "m",
    \ "Staged"    : "s",
    \ "Untracked" : "u",
    \ "Renamed"   : "r",
    \ "Unmerged"  : "n",
    \ "Deleted"   : "x",
    \ "Dirty"     : "~",
    \ "Clean"     : "c",
    \ "Unknown"   : "?"
    \ }
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeGitStatusEnable = 1

""" Rainbow brackets
let g:rainbow_active = 1

""" haskell-vim
let g:haskell_indent_if = 2               " Align 'then' two spaces after 'if'
let g:haskell_indent_before_where = 2     " Indent 'where' block two spaces under previous body
let g:haskell_indent_case_alternative = 1 " Allow a second case indent style (see haskell-vim README)
let g:haskell_indent_let_no_in = 0        " Only next under 'let' if there's an equals sign
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

""" Markdown
let g:vim_markdown_folding_disabled = 1

""" Syntastic Configuration
" A syntactic checker like hlint should be installed in your PATH
" Run :SyntasticInfo to see what syntactic checkers are supported and enabled.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0 " closed on open, not displayed until the file is saved
let g:syntastic_check_on_wq = 0
"""" Ignore hs - annoying
let g:syntastic_mode_map = { "mode": "active", "passive_filetypes": ["haskell", "hs", "rust", "rs"] }

""" Pointfree Configuration (:help pointfree)
au BufNewFile,BufRead *.hs nmap pf <Plug>Pointfree

"""" jedi-vim
let g:jedi#completions_enabled = 0


"""" zealvim.vim
let g:zv_file_types = {
            \   'py': 'python3,numpy,pandas,matplotlib',
            \   'tex' : 'latex'
            \ }

"""" vim-latex-live-preview
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = 'lualatex' . ' -shell-escape'
let g:livepreview_cursorhold_recompile = 0 " do not recompile on cursor hold over.

"""" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" TODO
"let g:UltiSnipsSnippetDirectories=['/etc/nixos/dotfiles/neovim/UltiSnips']

""" Rust
let g:rustfmt_autosave = 1
let g:syntastic_rust_checkers = ['cargo']
let g:rust_cargo_avoid_whole_workspace = 0

"""" vim-ormolu
let g:ormolu_options=["-o -XTypeApplications"]
let g:ormolu_disable=1 "Don't format on save

"""" COC
"Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

let g:airline#extensions#coc#enabled = 1

let airline#extensions#coc#error_symbol = 'Errors:'
let airline#extensions#coc#warning_symbol = 'Warnings:'
