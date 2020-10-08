# Keybindings for emacs

Core bindings(leader, localleader): https://github.com/hlissner/doom-emacs/blob/4bc70a8537022eef078fdff43c2df9c145cb6377/core/core-keybinds.el


I couldn't find how to paste in :insert

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

### [magit]()

- status: `SPC g g` (press `?` for help)
- quit git status: `q`
- fold/unfold section, file: `TAB`

Tips:

- You can stage/unstage some region by VISUALly selecting it and `s`(stage)/`x`(discard).

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

`g z +key`

In :v mode:

`g z I`: evil-mc-make-cursor-in-visual-selection-beg
`g z A`: evil-mc-make-cursor-in-visual-selection-end

- [evil-multiedit](https://github.com/hlissner/evil-multiedit):

`M d`: upwards
`M D`: downwards
`C n` and `C p` to navigate and `RET` to select/unselect entry
(Same for :v)

- [iedit](https://github.com/victorhge/iedit) 

I dont use this

### [Dired](https://www.gnu.org/software/emacs/refcards/pdf/dired-ref.pdf)

TODO there is more

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
