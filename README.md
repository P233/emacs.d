# My Personal Emacs Configuration

## Install [Emacs mac port](https://github.com/railwaycat/homebrew-emacsmacport) through Homebrew

```
brew tap railwaycat/emacsmacport
brew install emacs-mac --with-natural-title-bar
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

## Install Global NPM Packages

```
npm i -g postcss-cli@5 postcss-sorting postcss-scss typescript prettier eslint
```

### Create a global postcss-sorting config file

```
curl https://gist.githubusercontent.com/P233/2cc2e2c739f04f142847604ac3855a94/raw/.postcssrc.json -o ~/.postcssrc.json
```

### Create a global eslint config file

```
touch ~/.eslintrc
```

## Install TabNine binary

See https://tabnine.com/

```
M-x company-tabnine-install-binary
```
