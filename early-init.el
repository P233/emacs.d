;; -*- lexical-binding: t; -*-
(set-language-environment 'utf-8)

(setq auto-save-list-file-prefix nil
      backup-inhibited t
      confirm-kill-emacs 'y-or-n-p
      create-lockfiles nil
      custom-file (concat user-emacs-directory "custom.el")
      default-directory "~/Projects"
      file-name-handler-alist nil
      find-program "fd"
      frame-inhibit-implied-resize t
      frame-resize-pixelwise t
      frame-title-format nil
      inhibit-startup-message t
      initial-major-mode 'fundamental-mode
      initial-scratch-message ""
      mac-command-modifier 'meta
      mac-option-modifier nil
      make-backup-files nil
      package-enable-at-startup nil
      read-process-output-max (* 1024 1024)
      ring-bell-function 'ignore
      show-paren-delay 0
      standard-indent 2
      word-wrap-by-category t
      auto-save-default nil
      warning-minimum-level :error)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(defalias 'yes-or-no-p 'y-or-n-p)

(tooltip-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(electric-indent-mode -1)

(add-to-list 'default-frame-alist '(undecorated-round . t))
(add-to-list 'load-path (concat user-emacs-directory "lisp"))
