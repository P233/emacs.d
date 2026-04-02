;; -*- lexical-binding: t; -*-
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
  (defun my/counsel-rg-at-point ()
    (interactive)
    (let* ((symbol (thing-at-point 'symbol))
           (search-term (if symbol (regexp-quote symbol) ""))
           (project (project-current)))
      (counsel-rg search-term (and project (project-root project)))))
  (setq ivy-switch-buffer-faces-alist '((dired-mode . ivy-subdir) (org-mode . link)))
  (ivy-configure 'counsel-yank-pop :height ivy-height)
  (ivy-mode t))

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

;; Only loaded by eglot to expand snippet completions (rust-analyzer call arguments)
(use-package yasnippet
  :defer t)

(use-package corfu
  :custom
  (corfu-auto t)
  (text-mode-ispell-word-completion nil)
  :init
  (global-corfu-mode))


(provide 'init-completion)
