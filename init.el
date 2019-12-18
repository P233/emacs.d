;; (package-initialize)


;; Global Variables
(defvar global-indentation-size 2
  "Globally shared indentation setting.")


;; Load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-use-package)


;; Emacs Settings
(require 'init-interface)
(require 'init-settings)


;; Language Settings
(require 'init-coding-style)
(require 'init-coding-tools)

(require 'init-markup)
(require 'init-css)
(require 'init-javascript)
(require 'init-elixir)
(require 'init-flutter)
(require 'init-php)
(require 'init-rust)
(require 'init-lisp)
(require 'init-org)
(require 'init-docker)
(require 'init-plantuml)


;; Git
(require 'init-git)


;; Utilities
(require 'init-utilities)


;; My Functions
(require 'init-my-functions)


;; Custom File
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)



(provide 'init)
