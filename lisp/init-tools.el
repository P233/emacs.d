;; -*- lexical-binding: t; -*-
(use-package gcmh
  :demand t
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
  :custom
  (acm-enable-tabnine nil)
  (lsp-bridge-enable-hover-diagnostic t)
  :config
  (add-to-list 'lsp-bridge-single-lang-server-extension-list '(("ts" "tsx" "js" "mjs") . "typescript"))
  (define-key lsp-bridge-mode-map (kbd "C->") 'lsp-bridge-diagnostic-jump-next)
  (define-key lsp-bridge-mode-map (kbd "C-<") 'lsp-bridge-diagnostic-jump-prev)
  (define-key lsp-bridge-mode-map (kbd "C-c d") 'lsp-bridge-find-def)
  (define-key lsp-bridge-mode-map (kbd "C-c u") 'lsp-bridge-find-references)
  (define-key lsp-bridge-mode-map (kbd "C-c C-r") 'lsp-bridge-rename)
  (define-key lsp-bridge-mode-map (kbd "C-c C-d") 'lsp-bridge-popup-documentation)
  (define-key lsp-bridge-mode-map (kbd "C-c C-c C-r") 'lsp-bridge-restart-process)
  :hook
  ((js-ts-mode typescript-ts-mode tsx-ts-mode emacs-lisp-mode rust-ts-mode swift-mode python-ts-mode) . lsp-bridge-mode))

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
  (persp-mode-prefix-key (kbd "M-p"))
  :bind
  ("C-x b" . persp-ivy-switch-buffer))

(use-package magit
  :custom
  (magit-diff-highlight-hunk-region-functions '(magit-diff-highlight-hunk-region-dim-outside magit-diff-highlight-hunk-region-using-face))
  :custom-face
  (magit-diff-hunk-region ((t (:slant italic))))
  :bind
  ("C-c m" . magit-status))

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
(global-set-key (kbd "C-c o") 'project-switch-project)


(provide 'init-tools)
