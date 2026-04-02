;; -*- lexical-binding: t; -*-
(use-package apheleia
  :hook
  ((css-mode js-ts-mode typescript-ts-mode tsx-ts-mode json-ts-mode web-mode python-ts-mode)
   . apheleia-mode)
  :custom
  ;; Keep derived modes such as SCSS on the same filename-inferred formatter.
  (apheleia-mode-alist
   '((css-mode . prettier)
     (js-ts-mode . prettier)
     (typescript-ts-mode . prettier)
     (tsx-ts-mode . prettier)
     (json-ts-mode . prettier)
     (web-mode . prettier)
     (python-ts-mode . black)))
  :config
  ;; Use the global tools and let project configuration control formatting.
  (setf (alist-get 'prettier apheleia-formatters)
        '("prettier" "--stdin-filepath" filepath))
  (setf (alist-get 'black apheleia-formatters)
        '("black" "--quiet"
          (when (apheleia-formatters-extension-p "pyi") "--pyi")
          "--stdin-filename" filepath "-")))


(provide 'init-formatter)
