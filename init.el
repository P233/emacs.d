;; (package-initialize)

;; Load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "packages" user-emacs-directory))
(require 'init-use-package)


;; Emacs Settings
(require 'init-osx)
(require 'init-interface)
(require 'init-settings)


;; Pagkaces Settings
(require 'init-packages)


;; Language Settings
(require 'init-code-styles)
(require 'init-markup)
(require 'init-css)
(require 'init-javascript)
(require 'init-elixir)
(require 'init-lisp)
(require 'init-org)


;; My Functions
(require 'init-my-functions)


;; My Packages
(require 'stylefmt)
(require 'pragmatapro)


;; Custom File
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)



(provide 'init)
