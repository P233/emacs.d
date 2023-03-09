# My Personal Emacs Configuration

## Install [emacs-plus](https://github.com/d12frosted/homebrew-emacs-plus)

```
brew install emacs-plus@28 --with-no-titlebar-and-round-corners --with-native-comp --HEAD
```

## Install Git Submodules

```
git submodule init
git submodule update
```

### Submodules List:

- [lsp-bridge](https://github.com/manateelazycat/lsp-bridge)
- [mind-wave](https://github.com/manateelazycat/mind-wave)
- [deno-bridge](https://github.com/manateelazycat/deno-bridge)
- [emmet2-mode](https://github.com/P233/emmet2-mode)
- [emacs-pragmatapro-ligatures](https://github.com/lumiknit/emacs-pragmatapro-ligatures)

## Dependencies

```
brew install fd ripgrep clojure-lsp/brew/clojure-lsp-native
pip3 install epc orjson sexpdata six openai
npm i -g typescript-language-server typescript prettier
```
