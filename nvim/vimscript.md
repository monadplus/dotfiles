# Vimscript

### Mapping

```
{cmd} {attr} {lhs} {rhs}

where
{cmd}  is one of ':map', ':map!', ':nmap', ':vmap', ':imap',
       ':cmap', ':smap', ':xmap', ':omap', ':lmap', etc.
{attr} is optional and one or more of the following: <buffer>, <silent>,
       <expr> <script>, <unique> and <special>.
       More than one attribute can be specified to a map.
{lhs}  left hand side, is a sequence of one or more keys that you will use
       in your new shortcut.
{rhs}  right hand side, is the sequence of keys that the {lhs} shortcut keys
       will execute when entered.
```

- `:map` for recursive mapping for all modes.
- `:noremap` for non-recursive mapping for all modes.

Example:

```
:map j gg     " maps j to gg
:map Q j      " maps Q to gg
:noremap W j  " maps W to j
```

- `:map!` insert and command-line mode
- Normal `:nmap`, `:nnoremap`
- Insert/Replace `:imap`, `:inoremap`
- Visual/Select `:vmap`, `:vnoremap`
- Visual `:xmap`, `:xnoremap`
- Select `:smap`, `:snoremap`
- Command-line(: / ? > @ -) `:cmap`, `:cnoremap`
- Operator pending `:omap`, `:onoremap`
- Specific language `:lmap`, `:lnoremap`

Display all keybindngs: `:map`(all), `:nmap` (only normal mode), `:map g` (start with key sequence 'g'), `:map <buffer>` (current buffer keybindings)

Locate the keybinding `:verbose map <keybinding>`

Unbind: `:unmap <keybinding>`, `:unmap!`, `:nunmap`, ...

To unbind a plugin: `autocmd VimEnter * unmap! <keybinding>`, `autocmd FileType haskell unmap <keybinding>`

`:nnoremap <F3> :ls<CR>` the <CR>/<Enter>/<Return> is compulsory.

#### Mapping attrs

- <buffer>: mapping effective only in current buffer.
- <nowait>: emits the mapping as soon as it is matched
- <silent>: not echoed on the command line.
- <unique>: fails if the mapping is already defined
- more

For more information

```
:help :map
:help :noremap
:help recursive_mapping
:help :map-modes
```
