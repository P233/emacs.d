;; -*- lexical-binding: t; -*-
(setq show-paren-delay 0)
(show-paren-mode t)
(global-subword-mode t)

(use-package gcmh
  :config
  (gcmh-mode))

(use-package smex)

(use-package counsel
  :demand t
  :custom
  (ivy-wrap t)
  (ivy-height 20)
  (ivy-use-virtual-buffers t)
  (ivy-use-selectable-prompt t)
  (ivy-switch-buffer-faces-alist '((dired-mode . ivy-subdir) (org-mode . link)))
  (enable-recursive-minibuffers t)
  :config
  (ivy-mode 1)
  :bind
  (("M-x"     . counsel-M-x)
   ("C-c s"   . swiper)
   ("C-c g"   . counsel-rg)
   ("C-c f"   . counsel-git)
   ("C-c C-f" . counsel-find-file)
   (:map ivy-minibuffer-map ("TAB" . ivy-partial))
   (:map ivy-minibuffer-map ("RET" . ivy-alt-done))))

(use-package ivy-xref
  :custom
  (xref-show-xrefs-function #'ivy-xref-show-defs)
  (xref-show-definitions-function #'ivy-xref-show-defs))

(use-package projectile
  :custom
  (projectile-enable-caching t)
  (projectile-completion-system 'ivy)
  :config
  (projectile-mode t)
  :bind
  ("C-c o" . projectile-switch-project))

(use-package perspective
  :custom
  (persp-mode-prefix-key (kbd "M-p"))
  :config
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

(use-package popup-kill-ring
  :bind
  ("C-c p" . popup-kill-ring))

(use-package avy
  :custom
  (avy-keys '(?u ?h ?e ?t ?o ?n ?a ?s ?i ?d))
  :bind
  (("C-c j" . avy-goto-char-2)
   ("C-c l" . avy-goto-line)))

(use-package goto-last-change
  :bind
  ("C-`" . goto-last-change))

(use-package flycheck
  :custom
  (flycheck-display-errors-delay 0)
  (flycheck-check-syntax-automatically '(mode-enabled save)))

(use-package company
  :custom
  (company-idle-delay 0)
  (company-echo-delay 0)
  (company-show-numbers t)
  (company-dabbrev-downcase nil)
  (company-selection-wrap-around t)
  (company-minimum-prefix-length 2)
  (company-global-modes '(not org-mode))
  :config
  (global-company-mode)
  :bind
  ((:map company-active-map ("C-n" . company-select-next))
   (:map company-active-map ("C-p" . company-select-previous))))

(use-package company-posframe
  :after company
  :custom
  (company-posframe-show-metadata nil)
  (company-posframe-show-indicator nil)
  (company-posframe-quickhelp-show-header nil)
  :config
  (company-posframe-mode 1))

(use-package yasnippet
  :config
  (yas-global-mode))

(use-package lsp-mode
  :defer t
  :custom
  (lsp-use-plists t)
  (lsp-enable-snippet nil)
  (lsp-enable-file-watcphers nil)
  (lsp-lens-enable nil)
  (lsp-eldoc-enable-hover nil)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-signature-auto-activate nil)
  (lsp-signature-render-documentation nil)
  (lsp-modeline-diagnostics-enable nil)
  (lsp-modeline-code-actions-enable nil)
  (lsp-completion-show-detail nil)
  :hook
  ((web-mode scss-mode clojure-mode swift-mode) . lsp)
  :bind
  ("C-c d" . lsp-find-definition)
  ("C-c u" . lsp-find-references)
  ("C-c C-r" . lsp-rename)
  ("C-c C-t" . lsp-find-type-definition)
  ("C-c C-s" . lsp-ivy-workspace-symbol))

(use-package lsp-ivy
  :after lsp-mode)

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

(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-.") 'kill-region)
(global-set-key (kbd "C-,") 'kill-ring-save)
(global-set-key (kbd "C-c h") 'hs-toggle-hiding)
(global-set-key (kbd "C-x C-b") 'ibuffer)


(provide 'init-tools)
