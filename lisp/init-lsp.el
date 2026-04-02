;; -*- lexical-binding: t; -*-
(use-package eglot
  :straight (:type built-in)
  :custom
  (eglot-events-buffer-config '(:size 0))
  (eglot-autoshutdown t)
  :hook
  ((js-ts-mode typescript-ts-mode tsx-ts-mode rust-ts-mode python-ts-mode) . eglot-ensure)
  :config
  ;; tsc --lsp asks to watch every ancestor directory up to /, which macOS forbids under /private/var
  (setq eglot-watch-files-outside-project-root nil)
  (add-to-list 'eglot-server-programs
               `(((js-mode :language-id "javascript")
                  (js-ts-mode :language-id "javascript")
                  (tsx-ts-mode :language-id "typescriptreact")
                  (typescript-ts-mode :language-id "typescript")
                  (typescript-mode :language-id "typescript"))
                 . ,(eglot-alternatives '(("tsc" "--lsp" "--stdio")
                                          ("typescript-language-server" "--stdio"))))))

(use-package flymake
  :straight (:type built-in)
  :commands (flymake-show-buffer-diagnostics
             flymake-goto-next-error
             flymake-goto-prev-error))

(use-package eldoc-box
  :commands eldoc-box-hover-at-point-mode
  :custom
  (eldoc-idle-delay 1)
  :init
  (defun my/eglot-eldoc-box-mode ()
    "Match Eldoc Box to Eglot management without repeating mode setup."
    (let ((managed (eglot-managed-p)))
      (unless (eq managed (bound-and-true-p eldoc-box-hover-at-point-mode))
        (eldoc-box-hover-at-point-mode (if managed 1 -1)))))
  :hook
  (eglot-managed-mode . my/eglot-eldoc-box-mode))

(use-package treesit
  :straight (:type built-in)
  :custom
  (treesit-enabled-modes '(typescript-ts-mode tsx-ts-mode js-ts-mode json-ts-mode
                           yaml-ts-mode python-ts-mode rust-ts-mode))
  (treesit-font-lock-level 4))


(provide 'init-lsp)
