# Keybindings for emacs

## General

### [Motions](https://vimhelp.org/motion.txt.html)

- change: `c`
- delete: `d`
- yank: `y`
- case: `g~`(swap), `gu` (upper), `gU` (lower)
- shift: `>` and `<`

Word motions:
- next word: `w`
- next WORD: `W`
- start of word: `b`
- start of WORD: `B`
- end of word: `e`
- end of WORD: `E`

### Text Objects 

`a` includes white spaces or delimiters (e.g. "[]")

- word: `aw` or `iw`
- sentence: `as` or `is`
- paragraph: `as` or `is`
- single/double quote: `a"`/`a'`/`a\``
- [] block: `a]` or `i]`
- () block: `a)` or `i)`
- {} block: `a}` or `i}`
- <> block: `a>` or `i>`
- tag: `at` or `it` (e.g. <a></a>)

### Buffers

- New buffer: `SPC b N`
- Save buffer: `SPC b s` or `:w`
- Switch to workspace buffer: `SPC ,` or `SPC b b`
- Switch to buffer: `SPC <` or `SPC b B`
- Close others: `SPC b O`

### Windows

- Split vertical: `C-w s`
- Split horizontal: `C-w s`
- Move: `C-w h/j/k/l`
- Move next: `C-w C-w`
- Close: `C-w q`
- Close others: `C-w C-o` or `SPC w O`
- Horizontal Increase/Decrease: `C-w < >`
- Vertical Increase/Decrease: `C-w + -`

### Evaluating emacs lisp

1. Go to a scratch buffer, swap to emacs-lisp-mode and `SPC m e b`
2. Eval using `SPC ;`
3. Place the cursor on the last parenthesis of an s-expr and `C-x C-e`

## [emacs-evil](https://github.com/emacs-evil/evil)
### [evil-exchange](https://github.com/Dewdrops/evil-exchange) 
### [evil-indent-plus](https://github.com/TheBB/evil-indent-plus)
### [evil-numbers](https://github.com/cofi/evil-numbers) 

Increment/decrement numbers: `g-` and `g=`

### [evil-lion](https://github.com/edkolev/evil-lion)

Align: :v `gl`
Align: :n `gl`
Right-align: :n `gL`

Example: `glip=` and `glip,`

one = 1
three = 3
fifteen = 15

one, two, three,
four, sixteen, seventeen,

### [evil-nerd-commenter](https://github.com/redguardtoo/evil-nerd-commenter)

- Comment :nv `gc`
- Copy and comment  :nv `gC`

### [evil-surround](https://github.com/emacs-evil/evil-surround)

- Add :v `S`
- Add :n `ys<textobject>`
- Delete :n `ds<textobject>`
- Change :n `cs<textobject>`

### [evil-snipe](https://github.com/hlissner/evil-snipe)

(also works in visual mode)

Find: `f` + letter
Find: `s` + letter + letter
Backwards: `F` or `S`

Move forward `;` and backwards `,`

After editing, the search is remembered, so you can press `; or ,` again.

### [evil-visualstar](https://github.com/bling/evil-visualstar)

Make a visual selection `v` or `V`, and then hit `*`

## haskell

- Ormolu format: `C-c f`
- Hlint: `C-c l`
- doc: `g ?`
- goto definition: `g ]`
- restart lsp: `g r`

## rgb

- [rainbow-mode](https://elpa.gnu.org/packages/rainbow-mode.html)
- [kurecolor](https://github.com/alphapapa/kurecolor) - Why is this so complicated?

## multiple-cursors

- [evil-mc](https://github.com/gabesoft/evil-mc)

`g z`

In :v mode:

`g z I`: evil-mc-make-cursor-in-visual-selection-beg
`g z A`: evil-mc-make-cursor-in-visual-selection-end

- [evil-multiedit](https://github.com/hlissner/evil-multiedit):

`M d`: upwards
`M D`: downwards
`C n` and `C p` to navigate and `RET` to select/unselect entry
(Same for :v)

- [iedit](https://github.com/victorhge/iedit) 

## org

Keybindings: [evil-org-mode](https://github.com/Somelauw/evil-org-mode)

- Change to `org-mode`
- `Tab` to fold/unfold
- `Shift + Tab` cycle fold/unfold
- `M j or M k` to move section up/down
- `M h or M l` to move section left/right (promote/demote)
- `C-RET`: new section
- Create a link manually: [[heading-name]] or [[file:filename.txt::section_1]] or [[file:filename.txt::44]]
- Create/Edit a link: `SPC m l l`

### +presenter

TODO

### +noter

Create notes

- [org-noter](https://github.com/weirdNox/org-noter)

### +pomodoro

[org-pomodoro](https://github.com/marcinkoziej/org-pomodoro)

### +pandoc

`M-x org-pandoc-export-as-xxxx` (buffer)
`M-x org-pandoc-export-to-xxxx` (file)
`M-x org-pandoc-export-to-xxxx-and-open` (file and open)

- There's a lot of customizing option: [ox-pandoc](https://github.com/kawabata/ox-pandoc)

### [htmlize](https://github.com/hniksic/emacs-htmlize)

- `M-x htmlize-buffer` and `M-x htmlize-file`
- `M-x htmlize-many-files`
- `M-x htmlize-many-files-dired` marked on dired

Customize variable `htmlize-output-type` (css, inline-css, font)

### [ob-async](https://github.com/astahlman/ob-async)

Async execution of snippets

```org
#+BEGIN_SRC sh :async
sleep 3s && echo 'Done!'
#+END_SRC
```

### [org-cliplink](https://github.com/rexim/org-cliplink)

- Copy an url to the clipboard and then `M-x org-cliplink`.

### [orgit](https://github.com/magit/orgit)

Link to Magic buffers from Org docs.

### [org-yt](https://github.com/TobiasZawada/org-yt)

Youtube links in org-mode.

### [ox-clip](https://github.com/jkitchin/ox-clip)

This module copies selected regions in org-mode as formatted text on the clipboard that can be pasted into other applications. When not in org-mode, the htmlize library is used instead.

### [toc-org](https://github.com/snosov1/toc-org)

TODO: not working :-(

After the installation, every time you’ll be saving an org file, the first headline with a :TOC: tag will be updated with the current table of contents.

Add `:TOC:` at the headline of the document

### [org-pdftools](https://github.com/fuxialexander/org-pdftools)

TODO

## ivy

- Jump to file in project: `SPC SPC`
- Jump to file from current directory: `SPC .`
- Jump to symbol in file: `SPC s i`
- Search project: `SPC s p`
- Search another project: `SPC s P`
- Search directory: `SPC s d`
- Search another directory: `SPC s D`
- ...

## LaTeX

- `auctex` is the major plugin
- `+lsp`: Install [texlab](https://github.com/latex-lsp/texlab) and enjoy!
- `+fold`: Write `M-x +fold` or `z`
- `preview-latex`: preview math formulas and floats in your .tex file.
- [latex-preview-pane](https://github.com/jsinglet/latex-preview-pane): `SPC m m` to open this minor mode. (No good documentation, just look at the sources)
- [cdlatex](https://github.com/cdominik/cdlatex): 
- [company-reftex](https://github.com/TheBB/company-reftex): This package provides two backends for Company for completing label references and citations in LaTeX

Keybindings:

- `LaTeX-section`: `C-c C-s`
- `LaTeX-environment`: `C-c C-e`
- `LaTeX-macro`: `C-c C-m`
- `TeX-font`: `C-c C-f C-b/C-i/C-e/...`
- Compile: `C-c C-c` (errors `C-c \``)
- Compile region: `C-c C-r`

- Open/close fold: `z a`
- Open all fold: `z r`
- Close all fold: `z m`

### preview-latex

Available previews: `SPC h v preview-default-options-list` ("displaymath" "floats" "graphics" "textmath" "sections" "footnotes")

How to include additional environments like enumerate:

```tex
\usepackage[displaymath,textmath,sections,graphics,floats]{preview}
\PreviewEnvironment{enumerate}
\PreviewEnvironment{tabular}
```

## pdf

Once `pdf` is added to `init.el`, [pdf-tools](https://github.com/politza/pdf-tools) is installed. pdf-tools is a replacement for `DocView` (the default pdf viewer in eamcs). Once installed, run `M-x pdf-tools help` and it will trigger the installation of `pdfinfo` (in Arch Linux works out of the box).

(optional) `sudo pacman -Syy imagemagick`

Keybindings:
- next/previous page: `j` and `k`
- quit: `q`
- outline: `TAB`
- dar-mode: `z m`
- enlarge/shrink: `=` and `-`
- fit page: `P`
- reset: `=`

If the pdf was produced with LaTeX you can jump to the source location

## flycheck

- `C-c !`

## grammar

(Disabled) Too much errors. It may be useful for writing a document or a book but not for org/markdown files.

First install the back-end `sudo pacman -Syy languagetool`

Check:

- [emacs-langtool](https://github.com/mhayashi1120/Emacs-langtool)
- [writegood mode](https://github.com/bnbeckwith/writegood-mode)

## spell

Spellcheck is automatically loaded in many text-mode derivatives, which includes org-mode, markdown-mode, the Git Commit buffer (from magit), mu4e-compose-mode, and others.

First install the back-end `sudo pacman -Syy aspell aspell-en`

Uses the package [emacs-spell-flu](https://gitlab.com/ideasman42/emacs-spell-fu) 

Fix a word: `z =`

## magit

- status: `SPC g g` (press `?` for help)
- quit git status: `q`
- fold/unfold section, file: `TAB`

Tips:

- You can stage/unstage some region by VISUALly selecting it and `s`(stage)/`x`(discard).

### git-gutter/git-gutter-fringe

- Next hunk: `SPC g ]`
- Previous hunk: `SPC g [`
- Revert hunk: `SPC g r`
- Stage hunk: `SPC g s`
- Preview hunk: `SPC g p`

More at `M-x git-gutter:`

### +forge

First you need to generate a github token with permissions: repo, user and read:org.

Then you need to create the file `~/.authinfo.gpg` (opening the file with emacs will automatically allow you to edit it, and once saved, it will encrypt it!) with the following line: 

```txt
machine api.github.com login monadplus^forge password **********
```

Validate it using: `M-; (auth-source-search :host "api.github.com" :user "monadplus^forge")`

The variable `auth-sources` contains the list of files that are searched and used during authentication.

Keybindings:
- `M-x forge-pull`: to start/update
- `C-c C-e`: edit section (issue title, state, etc)
- `C-c C-n`: create new comment

- How to merge a pull request? Create a local branch `b y` from the pull-request and then `m i` (merge into)

## [gist](https://github.com/defunkt/gist.el)

Configuration:

```bash
git config --global github.user <your-github-user-name>
# The token requires `gist` permission
git config --global github.oauth-token <your-personal-access-token-with-gist-scope>
# ^^^^ Stored in plain text in .gitconfig ...
```

Keybindings:

- List: `SPC g l g` or `M-x +gist/list`
- `c` to create a gist from a buffer (alternative `M-x gist-buffer-private`)
- `d` delete a gist
- `e` edit description
- `TAB` to open the gist
- Once the gist is opened, you can edit it and press `SPC f s` to save it.

There are more functions but the documentation is really bad.

More here https://github.com/hlissner/doom-emacs/blob/develop/modules/tools/gist/config.el

## Neotree

Toggle neotree: `C-f`
Open current file in neotree: `C-s`

## Markdown

Before you need to install:

- Linting: 
  - [markdownlint](https://github.com/DavidAnson/markdownlint): the readme contains all errors explained.
  - [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli) (not sure if you need the client)

- Preview: 
  - pandoc: `sudo pacman -S pandoc`. Pandoc preview is better than +grip.
  - (optional +grip) [grip-mode](https://github.com/seagle0128/grip-mode): github preview render

Keybindings:

- `SPC <localleader>`
- More [here](https://github.com/hlissner/doom-emacs/blob/fdbf68cf3cfa57837a2d7288e14261cb3ae881e8/modules/lang/markdown/config.el#L96) 

## [Avy](https://github.com/abo-abo/avy)

Search (jump to word): `gs SPC`
kk

THERE ARE more commands not mapped:
- avy-goto-char
- avy-goto-char-2
- avy-goto-char-timer
- avy-goto-line
- avy-goto-word

## [Dired](https://www.gnu.org/software/emacs/refcards/pdf/dired-ref.pdf)

- Open: `SPC o -` or open a directory
- Go in: `RET`
- Go out: `-`
- Create directory: `+`
- Create file: `SPC .`
- Delete directory: `-`
- Execute actions: `x`
- Owner: `O`
- Permissions: `M` (example u+rwx, g+r)
- Select: `m`
- Copy: `C`
- Move/Rename: `R`
- Rename: `i` and then save the buffer `:w`

## [Projectile](https://github.com/bbatsov/projectile)

- Discover projects: `SPC : projectile-discover-projects-in-directory`

- Go to project: `SPC p p`

- Search file in project `SPC SPC`

- Recent files `SPC f r`
- Recent files (project) `SPC f R`

## zen-mode

- Active/Deactivate: `SPC t z`
