;; -*- lexical-binding: t; -*-
(use-package visual-fill-column
  :custom
  (visual-fill-column-width 88))

(use-package mixed-pitch
  :custom-face
  (default ((t (:font "PragmataPro Mono"))))
  (fixed-pitch ((t (:font "PragmataPro Mono" :height 1.0))))
  (variable-pitch ((t (:font "Noto Serif" :height 1.0)))))

(use-package markdown-mode
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
                     (visual-line-mode)
                     (visual-fill-column-mode)
                     (mixed-pitch-mode))))


(defvar my/knowledge-base-path "~/Documents/MyKnowledgeBase")

(defun my/knowledge-base-rg ()
  (interactive)
  (counsel-rg "" my/knowledge-base-path))
(global-set-key (kbd "C-c a") 'my/knowledge-base-rg)

(defun my/knowledge-base-fd ()
  (interactive)
  (counsel-find-file "" my/knowledge-base-path))
(global-set-key (kbd "C-c C-a") 'my/knowledge-base-fd)


(provide 'init-note)
