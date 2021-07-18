;; -*- lexical-binding: t; -*-
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      package-quickstart t
      package-enable-at-startup nil
      frame-title-format nil
      inhibit-startup-message t
      initial-scratch-message ""
      initial-major-mode 'fundamental-mode
      backup-inhibited t
      make-backup-files nil
      auto-save-list-file-prefix nil
      auto-save-default nil
      create-lockfiles nil
      ring-bell-function 'ignore
      read-process-output-max (* 1024 1024)
      byte-compile-warnings '(cl-functions))

(defvar my/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(require 'init-use-package)

(require 'init-settings)
(require 'init-interface)

(require 'init-editing-tools)
(require 'init-enhancement-tools)
(require 'init-lsp)
(require 'init-git)

(require 'init-markup)
(require 'init-css)
(require 'init-javascript)
(require 'init-php)
(require 'init-rust)
(require 'init-swift)
(require 'init-lisp)
(require 'init-org)
(require 'init-docker)

(require 'init-my-functions)

(add-hook 'emacs-startup-hook
  (lambda ()
    (setq file-name-handler-alist my/file-name-handler-alist
          custom-file (concat user-emacs-directory "custom.el")
          default-directory "~/Projects")))

(provide 'init)
