# Matt's dot files
------------------------------

Dotfiles are how you configure your system, these are mine.

This setup is heavily inspired by [holman's dotfiles][holman-dotfiles]

[holman-dotfiles]: https://github.com/holman/dotfiles

## install

```bash
git clone git://github.com/BRMatt/dotfiles ~/dotfiles
cd ~/dotfiles
rake install
```

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `rake install`.
- **topic/\*.completion.sh**: Any files ending in `completion.sh` get loaded
  last so that they get loaded after we set up zsh autocomplete functions.
