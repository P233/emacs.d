# Personal Emacs Configuration for MacOS

## Installation

```
brew install --cask emacs
```

```
git clone git@github.com:P233/emacs.d.git ~/.emacs.d
```

## Fonts

- https://fsd.it/shop/fonts/pragmatapro/
- https://fonts.google.com/noto/specimen/Noto+Serif

## Dependencies

```
brew install deno fd ripgrep tree-sitter
```

```
npm i -g typescript-language-server vscode-langservers-extracted typescript prettier
```

```
cargo install emacs-lsp-booster
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
