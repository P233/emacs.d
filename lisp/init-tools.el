;; -*- lexical-binding: t; -*-
(show-paren-mode t)
(column-number-mode t)
(electric-pair-mode t)
(global-subword-mode t)

(use-package gcmh
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
  :config
  (setq ivy-switch-buffer-faces-alist '((dired-mode . ivy-subdir) (org-mode . link)))
  (ivy-configure 'counsel-yank-pop :height ivy-height)
  (ivy-mode t)
  :bind
  (("M-x"     . counsel-M-x)
   ("C-c s"   . swiper)
   ("C-c g"   . counsel-rg)
   ("C-c f"   . counsel-git)
   ("C-c C-f" . counsel-find-file)
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

(use-package perspective
  :custom
  (persp-mode-prefix-key (kbd "M-p"))
  :bind
  ("C-x b" . persp-ivy-switch-buffer)
  :init
  (persp-mode))

(use-package neotree
  :custom
  (neo-theme 'arrow)
  (neo-smart-open t)
  (neo-autorefresh nil)
  (neo-mode-line-type 'none)
  (neo-window-position 'right)
  (neo-default-system-application "open")
  (neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "node_modules"))
  :custom-face
  (neo-dir-link-face ((t (:inherit font-lock-builtin-face))))
  (neo-expand-btn-face ((t (:inherit font-lock-builtin-face))))
  :bind
  (("C-c e"   . neotree-show)
   ("C-c t"   . neotree-toggle)
   ("C-c C-o" . neotree-open-file-in-system-application)))

(use-package move-text
  :config
  (move-text-default-bindings))

(use-package expand-region
  :bind
  (("C-'" . er/expand-region)
   ("C-=" . er/contract-region)))

(use-package visual-regexp
  :bind
  (("C-c r" . vr/replace)
   ("C-c q" . vr/query-replace)))

(use-package avy
  :custom
  (avy-keys '(?u ?h ?e ?t ?o ?n ?a ?s ?i ?d))
  :bind
  (("C-c j" . avy-goto-char)
   ("C-c l" . avy-goto-line)))

(use-package goto-last-change
  :bind
  ("C-`" . goto-last-change))

(use-package copilot
  :straight (:type git :host github :repo "zerolfx/copilot.el" :files (:defaults "dist"))
  :custom
  (copilot-idle-delay 0.5)
  (copilot-max-char 1000000)
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
  ((js-ts-mode typescript-ts-mode tsx-ts-mode rust-ts-mode emacs-lisp-mode swift-mode) . lsp-bridge-mode))

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

(use-package combobulate
  :straight (:type git :host github :repo "mickeynp/combobulate")
  :after treesit
  :custom
  (combobulate-key-prefix "C-c C-z")
  :hook
  ((js-ts-mode . combobulate-mode)
   (css-ts-mode . combobulate-mode)
   (yaml-ts-mode . combobulate-mode)
   (json-ts-mode . combobulate-mode)
   (typescript-ts-mode . combobulate-mode)
   (tsx-ts-mode . combobulate-mode)))

(use-package magit
  :bind
  ("C-c m" . magit-status))

(use-package git-gutter-fringe
  :config
  (global-git-gutter-mode t))

(use-package vc-msg
  :bind
  ("C-c C-'" . vc-msg-show))

(use-package git-timemachine
  :defer t)

(use-package rainbow-mode
  :defer t)

(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c h") 'hs-toggle-hiding)

(setq project-switch-commands 'project-find-file)
(global-set-key (kbd "C-c o") 'project-switch-project)


(provide 'init-tools)
