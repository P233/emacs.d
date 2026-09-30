;; -*- lexical-binding: t; -*-
(set-language-environment 'utf-8)

;; Defer garbage collection during startup; gcmh-mode owns the threshold afterwards
(setq gc-cons-threshold most-positive-fixnum)

;; Temporarily disable file name handlers during startup
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Restore handlers before command-line files are visited.
(add-hook 'after-init-hook
          (lambda ()
            (setq file-name-handler-alist default-file-name-handler-alist)))

(add-hook 'emacs-startup-hook
          (lambda ()
            ;; Fallback for a failed init, where gcmh never took over
            (unless (bound-and-true-p gcmh-mode)
              (setq gc-cons-threshold (* 16 1024 1024)))))

(setq backup-inhibited t
      bidi-inhibit-bpa t
      confirm-kill-emacs 'y-or-n-p
      create-lockfiles nil
      default-directory "~/Projects"
      frame-inhibit-implied-resize t
      frame-resize-pixelwise t
      ns-use-proxy-icon nil
      inhibit-startup-message t
      initial-major-mode 'fundamental-mode
      initial-scratch-message ""
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
      use-short-answers t
      word-wrap-by-category t
      auto-save-default nil
      warning-minimum-level :error
      native-comp-async-report-warnings-errors 'silent)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq-default bidi-paragraph-direction 'left-to-right)

(tooltip-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; Emacs Plus with the frame-transparency patch keeps text fully opaque.
;; Blur must be configured before Cocoa creates the first window.
;; Background opacity follows the theme in init-interface.el.
(when (eq system-type 'darwin)
  (add-to-list 'default-frame-alist '(undecorated-round . t))
  (add-to-list 'default-frame-alist '(alpha . 100))
  (add-to-list 'default-frame-alist '(ns-background-blur . 32))
  (add-to-list 'default-frame-alist
               '(ns-alpha-elements
                 ns-alpha-default ns-alpha-fringe ns-alpha-glyphs)))
(add-to-list 'load-path (concat user-emacs-directory "lisp"))

;; Prefer bytecode on this Mac and avoid background native compilation.
;; Reassess both startup and editing performance when upgrading Emacs.
(setq load-no-native t
      native-comp-jit-compilation nil)

(when (and (fboundp 'startup-redirect-eln-cache)
           (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "var/eln-cache/" user-emacs-directory))))
