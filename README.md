# My Personal Emacs Configuration

## Install [Emacs mac port](https://github.com/railwaycat/homebrew-emacsmacport) through Homebrew

```
brew tap railwaycat/emacsmacport
brew install emacs-mac --with-mac-metal --with-rsvg --with-starter --with-natural-title-bar
brew install fd ripgrep
```

### Natural Title Bar

```
defaults write org.gnu.Emacs HideDocumentIcon YES
defaults write org.gnu.Emacs TransparentTitleBar DARK
```

See: https://github.com/railwaycat/homebrew-emacsmacport/wiki/Natural-Title-Bar

## Install Git Submodules (customised packages)

```
git submodule init
git submodule update
```

### Submodules List:

- [emmet-mode](https://github.com/P233/emmet-mode)
- [emacs-pragmatapro-ligatures](https://github.com/lumiknit/emacs-pragmatapro-ligatures)

## Dependencies

```
brew install clojure-lsp/brew/clojure-lsp-native
npm i -g typescript-language-server typescript prettier
```
