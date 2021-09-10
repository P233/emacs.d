;; -*- lexical-binding: t; -*-
(setq show-paren-delay 0)
(show-paren-mode t)
(global-subword-mode t)

(use-package smex)

(use-package counsel
  :demand t
  :config
  (setq ivy-wrap t
        ivy-height 20
        ivy-use-virtual-buffers t
        ivy-use-selectable-prompt t
        enable-recursive-minibuffers t)
  (ivy-mode 1)
  :bind
  (("M-x"   . counsel-M-x)
   ("C-c s" . swiper)
   ("C-c f" . counsel-git)
   ("C-c g" . counsel-git-grep)
   (:map ivy-minibuffer-map ("TAB" . ivy-partial))
   (:map ivy-minibuffer-map ("RET" . ivy-alt-done))))

(use-package projectile
  :config
  (setq projectile-completion-system 'ivy
        projectile-enable-caching t)
  (projectile-mode t))

(use-package ibuffer-projectile
  :after projectile
  :hook (ibuffer-mode . (lambda ()
                          (ibuffer-projectile-set-filter-groups)
                          (unless (eq ibuffer-sorting-mode 'alphabetic)
                            (ibuffer-do-sort-by-alphabetic)))))

(use-package counsel-projectile
  :after (counsel projectile)
  :bind
  (:map projectile-mode-map ("C-c C-p" . projectile-command-map))
  (:map projectile-mode-map ("C-c o" . counsel-projectile-switch-project)))

(use-package neotree
  :config
  (setq neo-theme 'arrow
        neo-smart-open t
        neo-window-position 'right
        neo-autorefresh nil
        neo-mode-line-type 'none
        neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "node_modules"))
  :bind
  (("C-c t" . neotree-toggle)
   ("C-c e" . neotree-show)))

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
  :config
  (setq avy-keys '(?u ?h ?e ?t ?o ?n ?a ?s ?i ?d))
  :bind
  (("C-c '" . avy-goto-char)
   ("C-c l" . avy-goto-line)))

(use-package goto-last-change
  :bind
  ("C-`" . goto-last-change))

(use-package flycheck
  :config
  (setq flycheck-check-syntax-automatically '(mode-enabled save)))

(use-package company-tabnine)

(use-package company
  :init
  (add-to-list 'company-backends #'company-tabnine)
  :config
  (setq company-idle-delay 0
        company-echo-delay 0
        company-show-numbers t
        company-dabbrev-downcasbe nil
        company-selection-wrap-around t
        company-minimum-prefix-length 1
        company-global-modes '(not org-mode))
  (global-company-mode)
  :bind
  ((:map company-active-map ("C-n" . company-select-next))
   (:map company-active-map ("C-p" . company-select-previous))))

(use-package lsp-mode
  :defer t
  :config
  (setq lsp-keymap-prefix "C-l"
        lsp-enable-snippet nil
        lsp-enable-file-watchers nil
        lsp-headerline-breadcrumb-enable nil)
  :hook
  ((web-mode clojure-mode swift-mode) . lsp)
  (lsp-mode . lsp-enable-which-key-integration)
  :commands lsp)

(use-package lsp-ui :defer t :commands lsp-ui-mode)
(use-package lsp-ivy :defer t :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :defer t :commands lsp-treemacs-errors-list)

(use-package which-key
  :defer t
  :config
  (which-key-mode))

(use-package magit
  :bind
  ("C-c m" . magit-status))

(use-package git-gutter-fringe
  :config
  (global-git-gutter-mode t))

(use-package vc-msg
  :bind
  ("C-c C-'" . vc-msg-show))

(use-package git-timemachine :defer t)

(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c h") 'hs-toggle-hiding)
(global-set-key (kbd "C-,") 'kill-ring-save)
(global-set-key (kbd "C-.") 'kill-region)
(global-set-key (kbd "C-x C-b") 'ibuffer)


(provide 'init-tools)
