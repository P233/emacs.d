;; -*- lexical-binding: t; -*-
(setq package-enable-at-startup nil
      package-quickstart t
      make-backup-files nil
      frame-title-format nil
      frame-inhibit-implied-resize t
      inhibit-startup-message t
      initial-scratch-message ""
      initial-major-mode 'fundamental-mode
      read-process-output-max (* 1024 1024))

(setenv "PATH" (concat "/opt/homebrew/bin/:" (getenv "PATH")))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

(add-to-list 'default-frame-alist '(undecorated-round . t))

