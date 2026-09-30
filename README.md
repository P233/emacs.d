# Emacs setup (macOS)

## 1. Dependencies

Install [Homebrew](https://brew.sh), then run the commands for the languages needed:

```sh
xcode-select --install # Skip if Command Line Tools are installed.
brew install ripgrep node
npm i -g typescript prettier # TypeScript 7+ is required for tsc --lsp.
brew install basedpyright black # Python completion, diagnostics and formatting.
brew install rust rust-analyzer # Rust toolchain, rustfmt and language server.
```

Skip tools already installed through another manager. Ensure their commands are
on `PATH` before building Emacs; the GUI uses the build terminal's `PATH`.

Optional:

- CSS/JSON via Eglot: `npm i -g vscode-langservers-extracted`.
- JS/TS fallback for projects using TypeScript < 7: `npm i -g typescript-language-server`.

Install with Font Book:

- [PragmataPro Mono](https://fsd.it/shop/fonts/pragmatapro/) — size 18.
- [Noto Serif SC Medium](https://fonts.google.com/noto/specimen/Noto+Serif+SC) — Chinese.

## 2. Build Emacs

Quit the old Emacs; uninstall its cask without `--zap`, or unlink its formula.
Move the old `/Applications/Emacs.app` aside and keep `~/.emacs.d`.

```sh
git clone git@github.com:P233/emacs.d.git ~/.emacs.d # Skip if already present.
mkdir -p ~/.config/emacs-plus
```

Create `~/.config/emacs-plus/build.yml` with these patches in order (Emacs 31.1):

```yaml
patches:
  - frame-transparency
  - frame-transparency-background:
      url: ~/.emacs.d/patches/emacs-31-frame-transparency-background.patch
      sha256: 4677ec7ceded2800d50d50325d7ddb090a88c5aefb744c8299b4ae802fcdcbe8
```

```sh
brew trust d12frosted/emacs-plus
brew tap d12frosted/emacs-plus
brew install emacs-plus@31
```

Use the source formula, not the cask. No extra compiler flags are needed.
Keep `build.yml` when moving to another Mac; it is outside this repository.

## 3. Launch

With `/Applications/Emacs.app` absent:

```sh
ln -s "$(brew --prefix emacs-plus@31)/Emacs.app" /Applications/
open /Applications/Emacs.app
```

Drag it from Finder into the Dock, replacing the old item. If Spotlight cannot
find the symlink, use `cp -R "$(brew --prefix emacs-plus@31)/Emacs.app" /Applications/`
instead, after removing the symlink. Refresh this copy after every upgrade/reinstall.

On first opening a source file, accept Emacs 31's grammar-install prompt and the
default `~/.emacs.d/var/treesit/` directory. No extra Tree-sitter package is needed.

Appearance: follows macOS, dark 80%, light 90%, blur 32, hidden title bar.
Edit fonts/theme/opacity in `lisp/init-interface.el`, blur/title bar in
`early-init.el`, then restart Emacs.

## 4. Update

Quit Emacs first:

```sh
brew update
brew upgrade emacs-plus@31
```

For changed patches, `build.yml`, or `PATH` directories, run
`brew reinstall emacs-plus@31` from the updated terminal. This also repairs
`Library not loaded` errors after dependency upgrades.
After editing a patch, update its SHA256 in `build.yml` with
`shasum -a 256 <patch-file>` before rebuilding. Refresh the application copy if used.
