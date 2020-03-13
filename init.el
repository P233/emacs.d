;; (package-initialize)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-use-package)

(require 'init-interface)
(require 'init-settings)

(require 'init-editing-tools)
(require 'init-enhancement-tools)
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

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(setq default-directory "~/Projects")


(provide 'init)
