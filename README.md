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

### Usage

Steps:

    cd
    mkdir vim-backup
    mv .vimrc vim-backup
    cp -r .vim vim-backup/
    git clone xxx vim-config
    cp -r vim-config/* .vim/
    ln -s .vim/vimrc ./.vimrc
    
Enjoy.
