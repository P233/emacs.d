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

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
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
  :hook
  (prog-mode . copilot-mode))

(use-package yasnippet)

(use-package corfu
  :custom
  (corfu-auto t)
  :init
  (global-corfu-mode))

;; Loading yas snippets after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (yas-global-mode)))


(provide 'init-completion)
