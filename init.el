;; -*- lexical-binding: t; -*-
(defvar native-comp-deferred-compilation-deny-list nil) ; temp fix

(defvar my/indentation-size 2)
(defvar my/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(require 'init-straight)
(require 'init-tools)
(require 'init-interface)
(require 'init-web)
(require 'init-lisp)
(require 'init-rust)
(require 'init-swift)
(require 'init-solidity)
(require 'init-note)
(require 'init-my-functions)

(with-eval-after-load 'recentf
  (add-to-list 'recentf-exclude "\\.chat\\'"))

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq backup-inhibited t
                  auto-save-default nil
                  auto-save-list-file-prefix nil
                  create-lockfiles nil
                  ring-bell-function 'ignore
                  find-program "fd"
                  default-directory "~/Projects"
                  confirm-kill-emacs 'y-or-n-p
                  standard-indent my/indentation-size
                  file-name-handler-alist my/file-name-handler-alist
                  mac-command-modifier 'meta
                  mac-option-modifier nil
                  frame-resize-pixelwise t)
            (setq-default indent-tabs-mode nil)
            (defalias 'yes-or-no-p 'y-or-n-p)
            (set-language-environment 'utf-8)))


(provide 'init)
