# How to use this repo

For Bash you simply create a symlink of the .bashrc file to `~/.bashrc`.

As for Vim, you first need to:
1. Create a symlink of .vimrc file  to `~/.vimrc`
2. Then, in order for the plugins to work, you need to download the [vim-plug plugin manager](https://github.com/junegunn/vim-plug) file and add it to `~/.vim/autoload/` with the following command:

```bash
# Using the Bash shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
or
```ps1
# Using PowerShell
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/.vim/autoload/plug.vim -Force
```

3. Finnaly, run `:PlugInstall` to install the plugins

# About the Symlinks

In Windows, symlinks can be created only on the Command Prompt and when running it as an admin with the following commands:
```bat
mklink LINK TARGET        & :: creates symlinks for files (the & is not included)
mklink /D LINK TARGET     & :: creates symlinks for directories (the & is not included)
```

# More About This Repo

While I indeed would like to create a script to automate the process of create files/directories and symlinks, I will refrain from doing so since there's too little files to handle and also because I honestly don't feel like it.
