;; (package-initialize)
(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(require 'init-use-package)

(require 'init-interface)
(require 'init-settings)

(require 'init-editing-tools)
(require 'init-enhancement-tools)
(require 'init-lsp)
(require 'init-git)

(require 'init-markup)
(require 'init-css)
(require 'init-javascript)
(require 'init-php)
(require 'init-rust)
(require 'init-lisp)
(require 'init-org)
(require 'init-docker)

(require 'init-my-functions)

(setq custom-file (concat user-emacs-directory "custom.el"))
(setq default-directory "~/Projects")


(provide 'init)
