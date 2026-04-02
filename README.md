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
brew install ripgrep uv
```

```
npm i -g typescript-language-server vscode-langservers-extracted typescript prettier
```

JS/TS files use the native language server of the global TypeScript (`tsc --lsp`), so it must be 7 or newer. `M-x eglot` can still pick `typescript-language-server`, but only in a workspace whose own `node_modules/typescript` is older than 7: TypeScript 7 no longer ships `tsserver.js`.

```
uv tool install basedpyright
uv tool install black
```

Web/JS/TS and Python formatting runs asynchronously through Apheleia, using the global Prettier and Black and their project configuration. Saving writes the buffer immediately; the formatted result is saved when ready.

```
brew install rust rust-analyzer
```

Rust buffers are formatted on save by rust-analyzer, which runs the `rustfmt` shipped with `rust`.

### Tree-sitter Grammars

Emacs offers to install a missing grammar into `~/.emacs.d/var/treesit/` the first time a mode listed in `treesit-enabled-modes` needs it, using the version pinned by that mode. For other languages, run `M-x treesit-install-language-grammar` and install into the same directory. Both require `git` and a C compiler (`xcode-select --install`).
