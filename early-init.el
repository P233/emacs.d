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
      show-paren-delay 0)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

(show-paren-mode t)
(column-number-mode t)
(global-subword-mode t)

(add-to-list 'default-frame-alist '(undecorated-round . t))
(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(add-to-list 'default-frame-alist '(font . "PragmataPro Mono 18"))
(set-fontset-font "fontset-default" 'han "FZFW ZhuZi MinchoS")


