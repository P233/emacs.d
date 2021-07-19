;; -*- lexical-binding: t; -*-
(setq package-enable-at-startup nil
      package-quickstart t
      frame-inhibit-implied-resize t
      frame-title-format nil
      inhibit-startup-message t
      initial-scratch-message ""
      initial-major-mode 'fundamental-mode
      backup-inhibited t
      make-backup-files nil
      auto-save-list-file-prefix nil
      auto-save-default nil
      create-lockfiles nil
      read-process-output-max (* 1024 1024)
      custom-file (concat user-emacs-directory "custom.el")
      byte-compile-warnings '(cl-functions))

(defvar my/indentation-size 2)
(defvar my/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(require 'init-use-package)

(use-package gcmh :config (gcmh-mode))

(require 'init-interface)

(require 'init-tools)

(require 'init-web)
(require 'init-rust)
(require 'init-swift)
(require 'init-lisp)
(require 'init-org)
(require 'init-docker)

(require 'init-my-functions)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq ring-bell-function 'ignore
                  default-directory "~/Projects"
                  standard-indent my/indentation-size
                  file-name-handler-alist my/file-name-handler-alist)
            (setq-default indent-tabs-mode nil
                          tab-width my/indentation-size)
            (defalias 'yes-or-no-p 'y-or-n-p)
            (set-language-environment 'utf-8)))


(provide 'init)
