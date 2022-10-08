;; -*- lexical-binding: t; -*-
(setq show-paren-delay 0)
(show-paren-mode t)
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
  (ivy-mode 1)
  :bind
  (("M-x"     . counsel-M-x)
   ("C-c s"   . swiper)
   ("C-c g"   . counsel-rg)
   ("C-c f"   . counsel-git)
   ("C-c C-f" . counsel-find-file)
   ("C-h f"   . counsel-describe-function)
   ("C-h v"   . counsel-describe-variable)
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
  :bind
  ("C-x C-b" . persp-ivy-switch-buffer)
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
  (("C-c j" . avy-goto-char)
   ("C-c l" . avy-goto-line)))

(use-package goto-last-change
  :bind
  ("C-`" . goto-last-change))

(use-package yasnippet
  :config
  (yas-global-mode))

(use-package posframe)

(use-package lsp-bridge
  :load-path "custom-packages/lsp-bridge"
  :custom
  (acm-enable-yas nil)
  (acm-enable-doc nil)
  (acm-enable-tabnine nil)
  :config
  (add-to-list 'lsp-bridge-single-lang-server-extension-list '(("tsx")  . "typescriptreact"))
  (add-to-list 'lsp-bridge-single-lang-server-extension-list '(("scss") . "vscode-css-language-server"))
  (define-key lsp-bridge-mode-map (kbd "C-c d") 'lsp-bridge-find-def)
  (define-key lsp-bridge-mode-map (kbd "C-c u") 'lsp-bridge-find-references)
  (define-key lsp-bridge-mode-map (kbd "C-c y") 'lsp-bridge-list-diagnostics)
  (define-key lsp-bridge-mode-map (kbd "C-c C-r") 'lsp-bridge-rename)
  (define-key lsp-bridge-mode-map (kbd "C-c C-d") 'lsp-bridge-popup-documentation)
  (global-lsp-bridge-mode))

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


(provide 'init-tools)
