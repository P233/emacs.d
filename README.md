# My Personal Emacs Configuration on MacOS

## Install [emacs-plus](https://github.com/d12frosted/homebrew-emacs-plus)

```
brew install emacs-plus@29 --with-gnu-head-icon
git clone git@github.com:P233/emacs.d.git .emacs.d
```

## Dependencies

```
brew install deno fd ripgrep tree-sitter clojure-lsp/brew/clojure-lsp-native
pip3 install epc orjson sexpdata six openai
npm i -g typescript-language-server typescript prettier
```

### Tree-sitter Modules

```
git submodule init
git submodule update

~/.emacs.d/tree-sitter-module/batch.sh
```
