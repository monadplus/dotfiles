# Ripgrep

Command line tool that  searches your files for patterns.

## Usage

### Search

```bash
# All lines with word
rg fast README.md
# All words that contains fast*
rg 'fast\w+' README.md # \w: any word
                       # +:  at least one.
rg 'fast\w*' README.md
```

More on regexs [here](https://docs.rs/regex/1.4.3/regex/#syntax)

Recursive search

```bash
# It's the default behaviour: rg <string> ./
rg 'fn write\(' # or rg -F 'fn write('
rg 'fn write\(' src # only src/
```

### Automatic filtering

By default:

- Files and directories that match the rules in your `.gitignore` glob pattern.
- Hidden files and directories.
- Binary files.
- Symbolic links aren't followed.

How to toggle them:

- You can disable `.gitignore` handling with the `--no-ignore` flag.
- Hidden files and directories can be searched with the `--hidden` flag.
- Binary files can be searched via the `--text` (-a for short) flag. Be careful with this flag! Binary files may emit control characters to your terminal, which might cause strange behavior.
- ripgrep can follow symlinks with the `--follow` (-L for short) flag.
- `-u`/`-uu`/`-uuu` (--unrestricted)

### Filtering

```bash
# rg --type-list to display all globs types
rg <str/regex> -g '*.toml' # only toml files
rg <str/regex> -g '!*.toml' # everything but toml files
rg <str/regex> -g '*.{c,h}' # only c and h files.
rg <str/regex> --type rust
rg <str/regex> -trust
rg <str/regex> -Trust # exclude files of this type.
```

### Replacements

```bash
rg fast README.md -r FAST
rg '^.*fast.*$' README.md -r FAST # Replace the entire line for FAST
rg 'fast\s+(\w+)' README.md -r 'fast-$1' # Capturing group $0 corresponds to entire match.
rg 'fast\s+(?P<word>\w+)' README.md -r 'fast-$word' # named capturing group
```

To replace in file it is better to use other tools like `sed`:

```bash
# --files-with-matches prints only the filenames
# xargs for each output executes the command on the rhs
# sed does the replacement in the file
rg 'foo' --files-with-matches | xargs sed -i 's/foo/bar/g'
```

## Configuration file

See docs.


