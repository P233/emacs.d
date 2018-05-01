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


;; Pagkaces Settings
(require 'init-packages)


;; Language Settings
(require 'init-code-styles)
(require 'init-front-end)
(require 'init-flutter)
(require 'init-elixir)
(require 'init-lisp)
(require 'init-org)


;; My Functions
(require 'init-my-functions)


;; Custom File
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)



(provide 'init)
