"
" ██████╗░██╗░░░░░██╗░░░██╗░██████╗░██╗███╗░░██╗░██████╗
" ██╔══██╗██║░░░░░██║░░░██║██╔════╝░██║████╗░██║██╔════╝
" ██████╔╝██║░░░░░██║░░░██║██║░░██╗░██║██╔██╗██║╚█████╗░
" ██╔═══╝░██║░░░░░██║░░░██║██║░░╚██╗██║██║╚████║░╚═══██╗
" ██║░░░░░███████╗╚██████╔╝╚██████╔╝██║██║░╚███║██████╔╝
" ╚═╝░░░░░╚══════╝░╚═════╝░░╚═════╝░╚═╝╚═╝░░╚══╝╚═════╝░

" Plugins for neovim using vim-plug (https://github.com/junegunn/vim-plug)
call plug#begin('~/.local/share/nvim/plugged')

" Aesthetics
Plug 'vim-airline/vim-airline'                                    " Bottom status bar
Plug 'vim-airline/vim-airline-themes'                             " Themes for airline
Plug 'ap/vim-buftabline'                                          " Place buffers on tabline
Plug 'dracula/vim'                                                " My favourite theme
Plug 'luochen1990/rainbow'                                        " Colored parentheses

" Git integration
Plug 'tpope/vim-fugitive'                                         " Git porcelain
Plug 'airblade/vim-gitgutter'                                     " Show file git status

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Better nvim
Plug 'scrooloose/nerdcommenter'                                   " code commenter
Plug 'junegunn/vim-easy-align'                                    " alignment plugin
Plug 'tpope/vim-surround'                                         " quickly edit surroundings (brackets, html tags, etc)
Plug 'easymotion/vim-easymotion'                                  " Vim motion on speed!
Plug 'mg979/vim-visual-multi', {'branch': 'master'}               " Multiple cursors selection, etc
Plug 'tpope/vim-unimpaired'                                       " Better navigation
Plug 'jiangmiao/auto-pairs'                                       " Auto pair parens, brackets, etc.
Plug 'vim-ctrlspace/vim-ctrlspace'                                " Workspaces
Plug 'scrooloose/nerdtree'                                        " Directory as a tree
Plug 'Xuyuanp/nerdtree-git-plugin'                                " Shows files git status on the NerdTree

" Miscelaneous
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }  " fuzzy finder conf
Plug 'junegunn/fzf.vim'                                            " fuzzy finder
Plug 'chrisbra/Recover.vim'                                        " Add compare option to vim recover
Plug 'ervandew/supertab'                                           " Tab completition
Plug 'direnv/direnv.vim'                                           " direnv integration
Plug 'jlanzarotta/bufexplorer'                                     " Better buffer management

" Vim as IDE
Plug 'neoclide/coc.nvim', {'branch': 'release'}                    " LSP
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
Plug 'vim-syntastic/syntastic'                                     " Linter (e.g. hlint integration)

" Snippets
Plug 'SirVer/ultisnips'                                            " Snippets plugin
Plug 'honza/vim-snippets'                                          " Collection of snippets for several languages

" Programming Languages
Plug 'rhysd/vim-llvm'                                              " Syntax for LLVM
Plug 'derekelkins/agda-vim'                                        " Agda-mode port
Plug 'rust-lang/rust.vim'                                          " Rust syntax and syntastic integration
Plug 'ekalinin/Dockerfile.vim'                                     " Syntax for Dockerfile
Plug 'LnL7/vim-nix'                                                " Nix expressions in vim
Plug 'plasticboy/vim-markdown'                                     " Markdown utilities
Plug 'godlygeek/tabular'                                           " vim-markdown dependency
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }             " Live compilation of .tex
Plug 'KabbAmine/zeavim.vim'                                        " Zeal docs https://zealdocs.org/

" Haskell
Plug 'Twinside/vim-hoogle'                                         " Hoogle search integration
Plug 'neovimhaskell/haskell-vim'                                   " Haskell Syntax and Identation
Plug 'vmchale/pointfree'                                           " Pointfree for haskell
Plug 'vmchale/cabal-project-vim'                                   " Syntax highlight for *.cabal files
Plug 'vmchale/ghci-syntax'                                         " Syntax highlight for ghci configuration files
Plug 'sdiehl/vim-ormolu'                                           " Opinionated Haskell code formatter
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }                 " ghcid integration :Ghcid

" FIXME Tryied but not working
"Plug 'ryanoasis/vim-devicons'
"Plug 'sakshamgupta05/vim-todo-highlight'

call plug#end()
