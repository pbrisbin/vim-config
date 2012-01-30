# Vim configuration

This is my vim.

### What this is tweaked/extended for

* Haskell
* Ruby
* Pandoc
* Emails

If you primarily use vim for day-to-day text editing plus these tasks, 
you might find my setup enjoyable.

### What this is not tweaked/extended for

* C/C++
* Python

If you develop heavily in these languages, you might consider someone 
else's setup.

### Installation

* Backup your current setup

`mkdir ~/vim_backup && mv ~/.vim ~/.vimrc ~/vim_backup/`

* Clone my repo to your vim directory

`git clone git://github.com/pbrisbin/vim-config.git ~/.vim`

* Initialize all of the submodule plugins

`cd ~/.vim && git submodule update --init`

* Link your .vimrc

`ln -s ~/.vim/vimrc ~/.vimrc`

Enjoy!

### Thanks

* [rson][], my first ever vimrc was taken mostly from his
* [sam7wx][], I copied the submodule idea from his repo
* Anyone else who may have written or now maintains a plugin used in 
  this config.

[rson]:   https://github.com/rson/vimfiles
[sam7wx]: https://github.com/sam7wx/dotvim
