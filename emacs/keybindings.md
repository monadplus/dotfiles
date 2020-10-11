# Keybindings for emacs

Core bindings(leader, localleader): https://github.com/hlissner/doom-emacs/blob/4bc70a8537022eef078fdff43c2df9c145cb6377/core/core-keybinds.el

## TODO

- [ ] Paste in insert mode

### Buffers

- New buffer: `SPC b N`
- Save buffer: `SPC b s` or `:w`
- Switch to workspace buffer: `SPC ,` or `SPC b b`
- Switch to buffer: `SPC <` or `SPC b B`
- Close others: `SPC b O`

### Windows

- Split vertical: `C-w s`
- Split horizontal: `C-w s`
- Move: `C-w hjkl`
- Move next: `C-w C-w`
- Close: `C-w q`
- Close others: `C-w C-o` or `SPC w O`
- Horizontal Increase/Decrease: `C-w < >`
- Vertical Increase/Decrease: `C-w + -`

### Evaluating emacs lisp

1. Go to a scratch buffer, swap to emacs-lisp-mode and `SPC m e b`
2. Eval using `SPC ;`

### [org-mode]()

- Change to `org-mode`
- `Tab` to fold/unfold
- `Shift + Tab` cycle fold/unfold
- `M j or M k` to move section up/down
- `M h or M l` to move section left/right (promote/demote)
- `C-RET`: new section
- Create a link manually: [[heading-name]]
- Create a link (heading/file/url): org-store-link + org-insert-link [[heading-name]]

More: keep watching https://www.youtube.com/watch?v=BRqjaN4-gGQ&list=PLhXZp00uXBk4np17N39WvB80zgxlZfVwj&index=10

### [LaTeX]()

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

#### preview-latex

Available previews: `SPC h v preview-default-options-list` ("displaymath" "floats" "graphics" "textmath" "sections" "footnotes")

How to include additional environments like enumerate:

```tex
\usepackage[displaymath,textmath,sections,graphics,floats]{preview}
\PreviewEnvironment{enumerate}
\PreviewEnvironment{tabular}
```

### pdf

Once `pdf` is added to `init.el`, [pdf-tools](https://github.com/politza/pdf-tools) is installed. pdf-tools is a replacement for `DocView` (the default pdf viewer in eamcs). Once installed, run `M-x pdf-tools help` and it will trigger the installation of `pdfinfo` (in Arch Linux works out of the box).

(optional) `sudo pacman -Syy imagemagick`

TODO change keybindings: https://github.com/politza/pdf-tools#some-keybindings

### [flycheck]()

- `C-c !`

### grammar

(Disabled) Too much errors. It may be useful for writing a document or a book but not for org/markdown files.

First install the back-end `sudo pacman -Syy languagetool`

Check:

- [emacs-langtool](https://github.com/mhayashi1120/Emacs-langtool)
- [writegood mode](https://github.com/bnbeckwith/writegood-mode)

### spell

Spellcheck is automatically loaded in many text-mode derivatives, which includes org-mode, markdown-mode, the Git Commit buffer (from magit), mu4e-compose-mode, and others.

First install the back-end `sudo pacman -Syy aspell aspell-en`

Uses the package [emacs-spell-flu](https://gitlab.com/ideasman42/emacs-spell-fu) 

Fix a word: `z =`

### [magit]()

- status: `SPC g g` (press `?` for help)
- quit git status: `q`
- fold/unfold section, file: `TAB`

Tips:

- You can stage/unstage some region by VISUALly selecting it and `s`(stage)/`x`(discard).

#### +forge


First you need to generate a github token with permissions: repo, user and read:org.

Then you need to create the file `~/.authinfo.gpg` (opening the file with emacs will automatically allow you to edit it, and once saved, it will encrypt it!) with the following line: 

```
machine api.github.com login monadplus^forge password **********
```

Validate it using: `M-; (auth-source-search :host "api.github.com" :user "monadplus^forge")`

The variable `auth-sources` contains the list of files that are searched and used during authentication.

Keybindings:
- `M-x forge-pull`: to start/update
- `C-c C-e`: edit section (issue title, state, etc)
- `C-c C-n`: create new comment

- How to merge a pull request? Create a local branch `b y` from the pull-request and then `m i` (merge into)

### [gist](https://github.com/defunkt/gist.el)

Configuration:

```bash
git config --global github.user <your-github-user-name>
# The token requires `gist` permission
git config --global github.oauth-token <your-personal-access-token-with-gist-scope>
# ^^^^ Stored in plain text in .gitconfig ...
```

Keybindings:

- `M-x gist-list`: to show your gists.
- `c` to create a gist from a buffer (alternative `M-x gist-buffer-private`)
- `d` delete a gist
- `e` edit description
- `TAB` to open the gist
- Once the gist is opened, you can edit it and press `SPC f s` to save it.

There are more functions but the documentation is really bad.

More here https://github.com/hlissner/doom-emacs/blob/develop/modules/tools/gist/config.el

### [Neotree]()

Open: `SPC o p`

### Markdown

`SPC <localleader>` localleader = `m`

### [evil-snipe](https://github.com/hlissner/evil-snipe)

(also works in visual mode)

Find: `f` + letter
Find: `s` + letter + letter
Backwards: `F` or `S`

Move forward `;` and backwards `,`

After editing, the search is remembered, so you can press `; or ,` again.

### [Avy](https://github.com/abo-abo/avy)

Search (jump to word): `gs SPC`

There is an option to search in all windows (nil by default).

There are more commands not mapped:
- avy-goto-char
- avy-goto-char-2
- avy-goto-char-timer
- avy-goto-line
- avy-goto-word

### multiple-cursors (collection of packages)

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

### [Dired](https://www.gnu.org/software/emacs/refcards/pdf/dired-ref.pdf)

TODO

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

### [Projectile](https://github.com/bbatsov/projectile)

- Discover projects: `SPC : projectile-discover-projects-in-directory`

- Go to project: `SPC p p`

- Search file in project `SPC SPC`

- Recent files `SPC f r`
- Recent files (project) `SPC f R`

### zen

Remove all distractions

- Active/Deactive: `SPC t z`
