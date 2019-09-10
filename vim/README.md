# VIM
This dot files contains some useful configurations to make very powerfull and pretty our beloved VIM

To use it properly you need some fonts like:
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) installed on your system, I personally use **Inconsolata**
- [Devicons](https://vorillaz.github.io/devicons/#/main)

> If you see NERDTree folders and files vertically stretched it's because your terminal needs **Mono** version of the patched font you're currently using

## Installation
In order to install this config is necessary to create `/home/{user}/.vim` dir and copy `colors` and `confs` folders into it, also copy this `vimrc` into user folder

```bash
mkdir .vim
cp -r co* ~/.vim/
cp vimrc ~/.vimrc
```

> That's it, now on the first run vim will install automatically `vim-plug` and use it to install all plugins configured on `vimrc`

## Plugins
The following plugins are used by this **vim** config

- NERDTree
- NERDCommenter
- NERDTree Git Plugin
- NERDTree Syntax Highlight
- Tagbar
- Lightline
- Vim Devicons
- Vim Closetag
- Vim Minimap (Only in GUI Mode)
- Conky Syntax (Only with Conky files)
- Kotlin Vim (Only with Kotlin files)

