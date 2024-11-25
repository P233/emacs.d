;; -*- lexical-binding: t; -*-
(use-package gcmh
  :demand t
  :config
  (gcmh-mode))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package smex)

(use-package counsel
  :demand t
  :custom
  (ivy-wrap t)
  (ivy-height 20)
  (ivy-use-virtual-buffers t)
  (ivy-use-selectable-prompt t)
  (enable-recursive-minibuffers t)
  (counsel-find-file-ignore-regexp (regexp-opt '(".git" ".next" ".obsidian" ".husky" ".DS_Store" "node_modules")))
  :config
  (defun my/swiper-thing-at-point ()
    (interactive)
    (swiper (thing-at-point 'symbol)))
  (defun my/counsel-rg-at-point ()
    (interactive)
    (let* ((symbol (thing-at-point 'symbol))
           (search-term (if symbol (regexp-quote symbol) ""))
           (project-root (or (project-root (project-current))
                             (vc-root-dir))))
      (counsel-rg search-term project-root)))
  (setq ivy-switch-buffer-faces-alist '((dired-mode . ivy-subdir) (org-mode . link)))
  (ivy-configure 'counsel-yank-pop :height ivy-height)
  (ivy-mode t)
  :bind
  (("M-x"       . counsel-M-x)
   ("C-s"       . swiper)
   ("C-M-s"     . my/swiper-thing-at-point)
   ("M-<f1>"    . my/counsel-rg-at-point)
   ("<f1>"      . counsel-rg)
   ("<f2>"      . counsel-git)
   ("C-h f"     . counsel-describe-function)
   ("C-h v"     . counsel-describe-variable)
   ("C-c p"     . counsel-yank-pop)
   ("C-x C-b"   . counsel-ibuffer)
   (:map ivy-minibuffer-map
         ("TAB" . ivy-partial)
         ("RET" . ivy-alt-done))))

(use-package ivy-posframe
  :custom
  (ivy-posframe-display-functions-alist '((counsel-yank-pop . ivy-posframe-display-at-point)))
  :config
  (ivy-posframe-mode))

(use-package ivy-xref
  :custom
  (xref-show-xrefs-function #'ivy-xref-show-defs)
  (xref-show-definitions-function #'ivy-xref-show-defs))

(use-package copilot
  :straight (:type git :host github :repo "zerolfx/copilot.el" :files (:defaults "dist"))
  :custom
  (copilot-max-char -1)
  (copilot-idle-delay 0.3)
  (copilot-enable-predicates '(copilot--buffer-changed))
  :config
  (defun my/copilot-complete ()
    (interactive)
    (or (copilot-accept-completion)
        (move-end-of-line nil)))
  (defun my/select-current-line ()
    (interactive)
    (set-mark-command nil)
    (move-end-of-line nil))
  (with-eval-after-load 'copilot
    (define-key copilot-mode-map (kbd "C-e") #'my/copilot-complete)
    (define-key copilot-mode-map (kbd "C-S-e") #'my/select-current-line))
  :hook
  (prog-mode . copilot-mode))

(use-package yasnippet
  :config
  (yas-global-mode))

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0)
  :init
  (global-corfu-mode))

(use-package eglot
  :straight (:type built-in)
  :custom
  (eglot-send-changes-idle-time 0.1)
  :hook
  ((js-ts-mode typescript-ts-mode tsx-ts-mode ruby-ts-mode rust-ts-mode python-ts-mode swift-mode) . eglot-ensure)
  :bind
  (("C->"     . flymake-goto-next-error)
   ("C-<"     . flymake-goto-prev-error)
   ("C-c C-d" . xref-find-definitions)
   ("C-c C-u" . xref-find-references)
   ("C-c C-r" . eglot-rename)))

(use-package eldoc-box
  :hook
  (eglot--managed-mode . eldoc-box-hover-at-point-mode))

(use-package treesit
  :straight (:type built-in)
  :defer t
  :custom
  (treesit-extra-load-path (list (concat user-emacs-directory "tree-sitter-module/dist")))
  :config
  (setq-default treesit-font-lock-level 4))

(use-package perspective
  :init
  (persp-mode)
  :custom
  (persp-mode-prefix-key (kbd "<f5>"))
  :bind
  ("C-x b" . persp-ivy-switch-buffer))

(use-package magit
  :custom
  (magit-diff-highlight-hunk-region-functions '(magit-diff-highlight-hunk-region-dim-outside magit-diff-highlight-hunk-region-using-face))
  :custom-face
  (magit-diff-hunk-region ((t (:slant italic))))
  :bind
  ("C-v" . magit-status))

(use-package git-gutter-fringe
  :config
  (global-git-gutter-mode))

(use-package vc-msg
  :bind
  ("C-c C-'" . vc-msg-show))

(use-package git-timemachine
  :defer t)


(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(setq project-switch-commands 'project-find-file)
(global-set-key (kbd "<f4>") 'project-switch-project)


(provide 'init-tools)
