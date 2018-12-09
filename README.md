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

* [emmet-mode](https://github.com/P233/emmet-mode)


## Install Global NPM Packages

```
yarn global add postcss-cli postcss-sorting typescript
```

### Add postcss-sorting config file

```
curl https://gist.githubusercontent.com/P233/2cc2e2c739f04f142847604ac3855a94/raw/.postcssrc.json -o ~/.postcssrc.json
```


## Byte Compile .emacs.d

```
M-x my/byte-compile-init-dir
```

Make sure to execute this function each time after you updated the configuration.