# My Personal Emacs Configuration

## Install [emacs-plus](https://github.com/d12frosted/homebrew-emacs-plus)

```
brew install emacs-plus@28 --with-no-titlebar-and-round-corners --HEAD
```

## Install Git Submodules (customised packages)

```
git submodule init
git submodule update
```

### Submodules List:

- [emmet-mode](https://github.com/P233/emmet-mode)
- [lsp-bridge](https://github.com/manateelazycat/lsp-bridge)
- [emacs-pragmatapro-ligatures](https://github.com/lumiknit/emacs-pragmatapro-ligatures)

## Dependencies

```
brew install fd ripgrep clojure-lsp/brew/clojure-lsp-native
npm i -g typescript-language-server typescript vscode-langservers-extracted prettier
```
