;; -*- lexical-binding: t; -*-
(use-package mixed-pitch
  :custom-face
  (default ((t (:font "PragmataPro Mono"))))
  (fixed-pitch ((t (:font "PragmataPro Mono" :height 1.0))))
  (variable-pitch ((t (:font "Noto Serif" :height 1.0)))))

(use-package visual-fill-column
  :custom
  (visual-fill-column-width 88))

(use-package markdown-mode
  :demand t
  :mode
  ("\\.mdx?\\'" "\\.chat\\'")
  :custom
  (markdown-hide-markup t)
  (markdown-fontify-code-blocks-natively t)
  :custom-face
  (markdown-header-face-1 ((t (:height 1.25))))
  (markdown-header-face-2 ((t (:height 1.20))))
  (markdown-header-face-3 ((t (:height 1.15))))
  (markdown-header-face-4 ((t (:height 1.10))))
  (markdown-header-face-4 ((t (:height 1.05))))
  (markdown-header-face-5 ((t (:height 1.00))))
  (markdown-markup-face ((t (:inherit 'fixed-pitch))))
  (markdown-table-face ((t (:inherit 'fixed-pitch))))
  (markdown-metadata-key-face ((t (:inherit 'fixed-pitch))))
  (markdown-metadata-value-face ((t (:inherit 'fixed-pitch))))
  :hook
  (markdown-mode . (lambda ()
                     (setq-local line-spacing 2)
                     (mixed-pitch-mode)
                     (visual-line-mode)
                     (visual-fill-column-mode)
                     (when (string-match-p "md" (file-name-extension buffer-file-name))
                       (prettier-js-mode)))))


(provide 'init-note)
