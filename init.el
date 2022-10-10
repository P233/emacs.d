;; -*- lexical-binding: t; -*-
(setq package-enable-at-startup nil
      package-quickstart t
      make-backup-files nil
      frame-title-format nil
      frame-inhibit-implied-resize t
      inhibit-startup-message t
      initial-scratch-message ""
      initial-major-mode 'fundamental-mode
      read-process-output-max (* 1024 1024)
      custom-file (concat user-emacs-directory "custom.el")
      byte-compile-warnings '(cl-functions))

(defvar my/indentation-size 2)
(defvar my/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(require 'init-use-package)
(require 'init-tools)
(require 'init-interface)
(require 'init-org)
(require 'init-web)
(require 'init-lisp)
(require 'init-rust)
(require 'init-swift)
(require 'init-docker)
(require 'init-flutter)
(require 'init-solidity)
(require 'init-my-functions)

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
                  mac-option-modifier nil)
            (set-face-bold-p 'bold nil)
            (setq-default indent-tabs-mode nil)
            (defalias 'yes-or-no-p 'y-or-n-p)
            (set-language-environment 'utf-8)))


(provide 'init)
