# Vim configuration

This is my vim.

### What this is tweaked/extended for

* Haskell
* Pandoc markdown
* Emails

If you primarily use vim for day-to-day text editing plus these tasks, 
you might find my setup enjoyable.

### What this is not tweaked/extended for

* C/C++
* Python
* Ruby

If you develop heavily in these languages, you might consider someone 
else's setup.

### Installation

Backup your current setup, clone mine, and a symlink for `.vimrc`:

    cd
    mkdir vim-backup && mv .vimrc .vim vim-backup/
    git clone git://github.com/pbrisbin/vim-config.git .vim
    ln -s .vim/vimrc .vim
