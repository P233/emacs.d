# Personal Emacs Configuration for MacOS

## Install [emacs-plus](https://github.com/d12frosted/homebrew-emacs-plus)

```
brew tap d12frosted/emacs-plus
brew install emacs-plus@30 --with-gnu-head-icon
```

```
git clone git@github.com:P233/emacs.d.git ~/.emacs.d
```

For the first time, start Emacs from the command line.

## Install Fonts

- https://fsd.it/shop/fonts/pragmatapro/
- https://fonts.google.com/noto/specimen/Noto+Serif

## Dependencies

```
brew install deno fd ripgrep tree-sitter
```

```
pip install epc orjson sexpdata six setuptools paramiko rapidfuzz watchdog packaging
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

## Straight lockfile

```elisp
(("deno-bridge" . "63890058ce6f391871f92ade77096f87c306dcc9"))
:gamma
```

Add the above code to `./straight/versions/default.el`.

