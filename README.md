# Vim configuration

## Usage

Backup any existing config (optional):

~~~
$ mv ~/.vim{,.bak}
$ mv ~/.vimrc ~/.vim.bak/vimrc
~~~

Install my config:

~~~
$ git clone https://github.com/pbrisbin/vim-config ~/.vim
~~~

Install Vundle:

~~~
$ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
~~~

Install bundles:

~~~
$ vim +BundleInstall +qall
~~~

Install `.vimrc`:

~~~
$ ln -s ~/.vim/vimrc ~/.vimrc
~~~
