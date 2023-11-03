;; -*- lexical-binding: t; -*-
(defvar my/indentation-size 2)
(defvar my/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(require 'init-straight)
(require 'init-tools)
(require 'init-interface)
(require 'init-web)
(require 'init-lisp)
(require 'init-rust)
(require 'init-swift)
(require 'init-note)
(require 'init-my-functions)

(setq auto-mode-alist '(("/git-rebase-todo\\'"          . git-rebase-mode)
                        ("\\.el$"                       . emacs-lisp-mode)
                        ("\\.tsx\\'"                    . tsx-ts-mode)
                        ("\\.ts\\'"                     . typescript-ts-mode)
                        ("\\.jsx$"                      . tsx-ts-mode)
                        ("\\.m?js$"                     . typescript-ts-mode)
                        ("\\.css$"                      . css-mode)
                        ("\\.scss$"                     . scss-mode)
                        ("\\.json$"                     . json-ts-mode)
                        ("\\.yaml$"                     . yaml-ts-mode)
                        ("\\.org\\'"                    . org-mode)
                        ("\\.mdx?\\'"                   . markdown-mode)
                        ("\\.\\(html\\|astro\\)\\'"     . web-mode)
                        ("\\.\\(svg\\|jpe?g\\|png\\)$"  . image-mode)
                        ("\\.swift\\(interface\\)?\\'"  . swift-mode)
                        ("\\.rs$"                       . rust-ts-mode)))

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
                  frame-resize-pixelwise t
                  word-wrap-by-category t
                  custom-file (concat user-emacs-directory "custom.el"))
            (setq-default indent-tabs-mode nil)
            (defalias 'yes-or-no-p 'y-or-n-p)
            (set-language-environment 'utf-8)))


(provide 'init)
