# dotfiles
Dotfiles Repo (with GNU Stow)

This is a standard dotfiles repository for managing config files across
different machines. It uses GNU stow to handle different versions.

## Usage
A _package_ is just a directory containing the files we want to manage.
Sometimes we want to version the package across different machines, e.g., a
personal machine and a work machine. In that case I'll just add a subdirectory
for each of those. Conceptually this is exactly like having two packages
that are just named `package/work` and `package/personal`.

If you want to stow the file `~/path/to/file` in `package/work`, first mirror
the directory structure (the `path/to` part) inside it, and use `touch file` to
create a dummy version of the file too. Then go to `dotfiles/package` and run:

``` sh
$ stow --adopt -nvSt ~ work
```
This will do a dry run of the command, printing out what it will do. If that
looks good, drop the `-n` flag and run it for real. This should move the
original file into your dotfiles repo and leave behind a symlink to it.

If you want to un-stow the contents of the package, run:

``` sh
$ stow -vDt ~ work
```

The most common use-case will be when you're applying your packages to a new
machine, in which case you just use the same command as stowing, minus the
`--adopt` flag.

``` sh
$ stow --adopt -nvSt ~ work
```
