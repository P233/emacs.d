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

- [lsp-bridge](https://github.com/manateelazycat/lsp-bridge)
- [deno-bridge](https://github.com/manateelazycat/deno-bridge)
- [emmet2-mode](https://github.com/P233/emmet2-mode)
- [emacs-pragmatapro-ligatures](https://github.com/lumiknit/emacs-pragmatapro-ligatures)

## Dependencies

```
brew install fd ripgrep clojure-lsp/brew/clojure-lsp-native
pip3 install epc orjson pystardict
npm i -g typescript-language-server typescript prettier
```
