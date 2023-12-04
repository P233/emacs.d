;; -*- lexical-binding: t; -*-
(show-paren-mode t)
(column-number-mode t)
(electric-pair-mode t)
(global-subword-mode t)

(use-package gcmh
  :config
  (gcmh-mode))

(use-package smex)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

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
  (setq ivy-switch-buffer-faces-alist '((dired-mode . ivy-subdir) (org-mode . link)))
  (ivy-configure 'counsel-yank-pop :height ivy-height)
  (ivy-mode t)
  :bind
  (("M-x"     . counsel-M-x)
   ("C-c s"   . swiper)
   ("C-c g"   . counsel-rg)
   ("C-c f"   . counsel-git)
   ("C-x C-f" . counsel-find-file)
   ("C-h f"   . counsel-describe-function)
   ("C-h v"   . counsel-describe-variable)
   ("C-c p"   . counsel-yank-pop)
   (:map ivy-minibuffer-map ("TAB" . ivy-partial))
   (:map ivy-minibuffer-map ("RET" . ivy-alt-done))))

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
  (copilot-idle-delay 0.5)
  (copilot-enable-predicates '(evil-emacs-state-p copilot--buffer-changed))
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

(use-package lsp-bridge
  :straight (:type git
                   :host github
                   :repo "manateelazycat/lsp-bridge"
                   :files (:defaults "*.el" "*.py" "acm" "core" "langserver" "multiserver" "resources")
                   :build (:not compile))
  :after markdown-mode
  :custom
  (acm-enable-doc nil)
  (acm-enable-tabnine nil)
  (acm-enable-search-file-words nil)
  (acm-markdown-render-font-height 180)
  (lsp-bridge-diagnostic-fetch-idle 1)
  (lsp-bridge-lookup-doc-tooltip-border-width 2)
  (lsp-bridge-enable-diagnostics nil)
  :config
  (add-to-list 'lsp-bridge-single-lang-server-extension-list '(("ts" "tsx" "js" "mjs") . "typescript"))
  (define-key lsp-bridge-mode-map (kbd "C-c d") 'lsp-bridge-find-def)
  (define-key lsp-bridge-mode-map (kbd "C-c u") 'lsp-bridge-find-references)
  (define-key lsp-bridge-mode-map (kbd "C-c C-r") 'lsp-bridge-rename)
  (define-key lsp-bridge-mode-map (kbd "C-c C-d") 'lsp-bridge-popup-documentation)
  (define-key lsp-bridge-mode-map (kbd "C-c C-c C-r") 'lsp-bridge-restart-process)
  :hook
  ((js-ts-mode typescript-ts-mode tsx-ts-mode emacs-lisp-mode rust-ts-mode swift-mode python-ts-mode) . lsp-bridge-mode))

(use-package deno-bridge
  :straight (:type git :host github :repo "manateelazycat/deno-bridge")
  :init
  (use-package websocket))

(use-package treesit
  :straight (:type built-in)
  :custom
  (treesit-extra-load-path (list (concat user-emacs-directory "tree-sitter-module/dist")))
  :config
  (setq-default treesit-font-lock-level 4))

(use-package perspective
  :custom
  (persp-mode-prefix-key (kbd "M-p"))
  :bind
  ("C-x b" . persp-ivy-switch-buffer)
  :init
  (persp-mode))

(use-package magit
  :custom
  (magit-diff-highlight-hunk-region-functions '(magit-diff-highlight-hunk-region-dim-outside magit-diff-highlight-hunk-region-using-face))
  :custom-face
  (magit-diff-hunk-region ((t (:slant italic))))
  :bind
  ("C-c m" . magit-status))

(use-package magit-todos
  :after magit
  :config
  (magit-todos-mode))

(use-package git-gutter-fringe
  :config
  (global-git-gutter-mode t))

(use-package vc-msg
  :bind
  ("C-c C-'" . vc-msg-show))

(use-package git-timemachine
  :defer t)

(use-package goto-line-preview
  :bind
  ("M-g M-g" . goto-line-preview))

(use-package open-newline
  :straight (:type git :host github :repo "manateelazycat/open-newline")
  :bind
  (("M-RET" . open-newline-below)
   ("<C-return>" . open-newline-above)))

(use-package move-text
  :config
  (move-text-default-bindings))

(use-package visual-regexp
  :bind
  (("C-c r" . vr/replace)
   ("C-c q" . vr/query-replace)))

(use-package expand-region
  :bind
  (("C-'" . er/expand-region)
   ("C-\"" . er/contract-region)))

(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode t))

(use-package vundo
  :bind
  ("C-=" . vundo))

(use-package apheleia
  :config
  (apheleia-global-mode))

(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c h") 'hs-toggle-hiding)

(setq project-switch-commands 'project-find-file)
(global-set-key (kbd "C-c o") 'project-switch-project)


(provide 'init-tools)
