# How to use this repo

For Bash you simply create a symlink of the .bashrc file to ```~/.bashrc```.

As for Vim, you first need to:
    1. Create a symlink of .vimrc file  to ```~/.vimrc```
    2. Then, in order for the plugins to work, you need to download the (vim-plug plugin manager)[https://github.com/junegunn/vim-plug] file and add to ```~/.vim/autoload/``` with the following command:
        ```curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim```

# About the Symlinks

In Windows, symlinks can be created only by running the Command Prompt as an admin with the following commands:
```
mklink LINK TARGET  # creates symlinks for files
mklink /D LINK TARGET  # creates symlinks for directories
```

# More About This Repo

While I indeed would like to create a script to automate the process of create files/directories and symlinks, I will refrain from doing so since there's too little files to handle and also because I honestly don't feel like it.
