# Personal Emacs Configuration for MacOS

## Install [emacs-plus](https://github.com/d12frosted/homebrew-emacs-plus)

```
brew install emacs-plus@29 --with-gnu-head-icon
```

```
git clone git@github.com:P233/emacs.d.git ~/.emacs.d
```

## Dependencies

```
brew install deno fd ripgrep tree-sitter
```

```
pip3 install epc orjson sexpdata six paramiko rapidfuzz pyright
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
