;; -*- lexical-binding: t; -*-
(use-package gcmh
  :demand t
  :config
  (gcmh-mode))

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
  (counsel-find-file-ignore-regexp (regexp-opt '(".git" ".dist" ".next" ".husky" ".DS_Store" "node_modules")))
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
   ("C-c C-s"   . my/swiper-thing-at-point)
   ("<f1>"      . counsel-rg)
   ("<f2>"      . counsel-git)
   ("C-<f1>"    . my/counsel-rg-at-point)
   ("C-h f"     . counsel-describe-function)
   ("C-h v"     . counsel-describe-variable)
   ("C-c p"     . counsel-yank-pop)
   (:map ivy-minibuffer-map
         ("TAB" . ivy-partial)
         ("RET" . ivy-alt-done))))

(use-package prescient
  :config
  (prescient-persist-mode))

(use-package ivy-prescient
  :custom
  (ivy-prescient-enable-filtering nil)
  (ivy-prescient-retain-classic-highlighting t)
  :config
  (ivy-prescient-mode))

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
  (copilot-idle-delay 0.2)
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

(use-package yasnippet)

(use-package corfu
  :custom
  (corfu-auto t)
  :init
  (global-corfu-mode))

(use-package eglot
  :straight (:type built-in)
  :hook
  ((js-ts-mode typescript-ts-mode tsx-ts-mode ruby-ts-mode rust-ts-mode python-ts-mode swift-mode) . eglot-ensure)
  :bind
  (("C->"     . flymake-goto-next-error)
   ("C-<"     . flymake-goto-prev-error)
   ("C-c C-d" . xref-find-definitions)
   ("C-c C-u" . xref-find-references)
   ("C-c C-r" . eglot-rename)))

(use-package eldoc-box
  :custom
  (eldoc-idle-delay 1)
  :hook
  (eglot--managed-mode . eldoc-box-hover-at-point-mode))

(use-package treesit
  :straight (:type built-in)
  :defer t
  :custom
  (treesit-extra-load-path (list (concat user-emacs-directory "tree-sitter-module/dist")))
  :config
  (setq-default treesit-font-lock-level 4))

;; (use-package treesit-fold
;;   :straight (treesit-fold :type git :host github :repo "emacs-tree-sitter/treesit-fold")
;;   :config
;;   (defun my/treesit-fold-jsx-element (node offset)
;;     (let* ((children (treesit-node-children node))
;;            (opening-element nil)
;;            (closing-element nil))
;;       (dolist (child children)
;;         (let ((type (treesit-node-type child)))
;;           (cond
;;            ((equal type "jsx_opening_element") (setq opening-element child))
;;            ((equal type "jsx_closing_element") (setq closing-element child)))))
;;       (when (and opening-element closing-element)
;;         (let ((fold-start (treesit-node-end opening-element))
;;               (fold-end (treesit-node-start closing-element)))
;;           (treesit-fold--cons-add (cons fold-start fold-end) offset)))))
;;   (push '(jsx_element . my/treesit-fold-jsx-element)
;;         (alist-get 'tsx-ts-mode treesit-fold-range-alist))
;;   ;; (push '(parenthesized_expression . treesit-fold-range-seq)
;;   ;;       (alist-get 'tsx-ts-mode treesit-fold-range-alist))
;;   (global-treesit-fold-indicators-mode))

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

(use-package magit-prime
  :straight (:type git :host github :repo "Azkae/magit-prime")
  :config
  (add-hook 'magit-pre-refresh-hook 'magit-prime-refresh-cache))

(use-package diff-hl
  :custom
  (diff-hl-margin-symbols-alist '((insert  . " ")
                                  (delete  . " ")
                                  (change  . " ")
                                  (unknown . " ")
                                  (ignored . " ")))
  :config
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (global-diff-hl-mode))

(use-package vc-msg
  :bind
  ("C-c C-'" . vc-msg-show))

(use-package git-timemachine
  :defer t)


;; Loading yas snippets after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (yas-global-mode)))


(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(setq project-switch-commands 'project-find-file)
(global-set-key (kbd "<f4>") 'project-switch-project)


(provide 'init-tools)
