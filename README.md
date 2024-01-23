# Personal Emacs Configuration for MacOS

## Install [emacs-plus](https://github.com/d12frosted/homebrew-emacs-plus)

```
brew tap d12frosted/emacs-plus
brew install emacs-plus@29 --with-gnu-head-icon
```

```
git clone git@github.com:P233/emacs.d.git ~/.emacs.d
```

## Install Fonts

- https://fsd.it/shop/fonts/pragmatapro/
- https://fonts.google.com/noto/specimen/Noto+Serif

## Dependencies

```
brew install deno fd ripgrep tree-sitter
```

```
pip3 install epc orjson sexpdata six paramiko rapidfuzz pyright black
```

```
npm i -g typescript-language-server vscode-langservers-extracted typescript prettier
```

### Tree-sitter Modules

```
cd ~/.emacs.d
```

```
git submodule init
git submodule update
```

```
~/.emacs.d/tree-sitter-module/batch.sh
```
