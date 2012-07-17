# Vim configuration

## Generic tips

`cr` stands for Carriage Return (Enter)

In insert mode you can use `Ctrl-P` to auto-complete text.

`J` joins the line below with the current one, e.g. `this is<cursor>\n2 lines` becomes `this is 2 lines`

Semicolon `;` is an alias for `:` so you don't need to do `Shift-:`

Use `Ctrl-^` to switch back to the previous file in that window. Works well if you use the explorer to find/edit a file then want to go back to the explorer.

## Bundles

### Fugitive

`Ctrl-G s`: Run `git status`
`Ctrl-G c`: Run `git commit`
`Ctrl-G b`: Run `git blame`
`Ctrl-G l`: Run `git lg`
`Ctrl-G g`: Open the current file in github
`Ctrl-G p`: Run `git push`

### Ctrl-P

An awesome fuzzy file finder.

`Ctrl-P`: Open the fuzzy finder, start typing to search.

When open use `Ctrl-t` to open the selected file in a new tab, or `Enter` to open in the currently highlighted buffer.


### Ack

A better grep

`Ctrl-A` And then type to search in the current directory

### Local vimrc

Put a `_vimrc_local.vim` in the project root and this plugin will load it whenever you open a file in that project.

e.g.

```viml  
set wildignore+=*/app/cache/*,*/app/log/*
let g:ctrlp_working_path_mode = 0
```
