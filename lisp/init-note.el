;; -*- lexical-binding: t; -*-
(use-package visual-fill-column
  :custom
  (visual-fill-column-width 88))

(use-package mixed-pitch
  :custom-face
  (default ((t (:font "PragmataPro Mono"))))
  (fixed-pitch ((t (:font "PragmataPro Mono" :height 1.0))))
  (variable-pitch ((t (:font "Noto Serif" :height 1.0)))))

(use-package org
  :straight (:type built-in)
  :defer t
  :custom
  (org-ellipsis " ⭍")
  (org-pretty-entities t)
  (org-startup-indented t)
  (org-hide-leading-stars t)
  (org-hide-emphasis-markers t)
  (org-image-actual-width '(800))
  (org-startup-with-inline-images t)
  :custom-face
  (org-level-1 ((t (:height 1.15))))
  (org-level-2 ((t (:height 1.13))))
  (org-level-3 ((t (:height 1.11))))
  (org-level-4 ((t (:height 1.09))))
  (org-level-5 ((t (:height 1.07))))
  (org-level-6 ((t (:height 1.05))))
  (org-level-7 ((t (:height 1.03))))
  (org-level-8 ((t (:height 1.01))))
  (org-date ((t (:inherit 'fixed-pitch))))
  (org-todo ((t (:inherit 'fixed-pitch))))
  (org-done ((t (:inherit 'fixed-pitch))))
  (org-drawer ((t (:inherit 'fixed-pitch))))
  (org-ellipsis ((t (:inherit 'fixed-pitch))))
  (org-property-value ((t (:inherit 'fixed-pitch))))
  (org-special-keyword ((t (:inherit 'fixed-pitch))))
  (org-headline-done ((t (:inherit 'variable-pitch))))
  :config
  (unbind-key "C-'" org-mode-map)
  :hook
  (org-mode . (lambda ()
                (setq-local line-spacing 2)
                (visual-line-mode)
                (visual-fill-column-mode)
                (mixed-pitch-mode)
                (org-superstar-mode))))

(use-package org-superstar
  :defer t
  :custom
  (org-superstar-headline-bullets-list '("☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷"))
  (org-superstar-item-bullet-alist '((43 . "⬧") (45 . "⬨")))
  :custom-face
  (org-superstar-item ((t (:inherit 'fixed-pitch))))
  (org-superstar-header-bullet ((t (:height 232 :inherit 'fixed-pitch)))))

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


(defvar my/brain-path "~/Documents/MyBrain/")

(defun my/brain-rg ()
  (interactive)
  (counsel-rg "" my/brain-path))
(global-set-key (kbd "C-c a") 'my/brain-rg)

(defun my/brain-fd ()
  (interactive)
  (counsel-find-file "" my/brain-path))
(global-set-key (kbd "C-c C-a") 'my/brain-fd)


(provide 'init-note)
