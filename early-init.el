;; -*- lexical-binding: t; -*-
(set-language-environment 'utf-8)

;; Defer garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Temporarily disable file name handlers during startup
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024))
            (setq file-name-handler-alist default-file-name-handler-alist)))

(setq auto-save-list-file-prefix nil
      backup-inhibited t
      bidi-inhibit-bpa t
      confirm-kill-emacs 'y-or-n-p
      create-lockfiles nil
      default-directory "~/Projects"
      find-program "fd"
      frame-inhibit-implied-resize t
      frame-resize-pixelwise t
      ns-use-proxy-icon nil
      inhibit-startup-message t
      initial-major-mode 'fundamental-mode
      initial-scratch-message ""
      large-hscroll-threshold 1000
      long-line-threshold 1000
      mac-command-modifier 'meta
      mac-option-modifier 'super
      make-backup-files nil
      package-enable-at-startup nil
      read-process-output-max (* 1024 1024)
      recentf-exclude '("\\.cache" "\\.git/" "^/opt" "^/tmp/")
      ring-bell-function 'ignore
      show-paren-delay 0
      standard-indent 2
      syntax-wholeline-max 1000
      word-wrap-by-category t
      auto-save-default nil
      warning-minimum-level :error
      native-comp-async-report-warnings-errors nil)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default bidi-display-reordering nil)
(defalias 'yes-or-no-p 'y-or-n-p)

(tooltip-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'load-path (concat user-emacs-directory "lisp"))

(when (and (fboundp 'startup-redirect-eln-cache)
           (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "var/eln-cache/" user-emacs-directory))))
