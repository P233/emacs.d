;; -*- lexical-binding: t; -*-
(use-package org
  :pin manual
  :defer t
  :config
  (setq org-directory "~/Dropbox/org"
        org-agenda-files "~/Dropbox/org/agenda.org"
        org-ellipsis " ⭍"
        org-startup-indented t
        org-pretty-entities t
        org-hide-leading-stars t
        org-hide-emphasis-markers t
        org-startup-with-inline-images t
        org-image-actual-width '(800)
        org-todo-keywords '((sequence "     " "   ")))
  (dolist (face '((org-level-1 . 1.15)
                  (org-level-2 . 1.13)
                  (org-level-3 . 1.11)
                  (org-level-4 . 1.09)
                  (org-level-5 . 1.07)
                  (org-level-6 . 1.05)
                  (org-level-7 . 1.03)
                  (org-level-8 . 1.01)))
    (set-face-attribute (car face) nil :height (cdr face)))
  (dolist (face '(org-todo
                  org-done
                  org-ellipsis
                  org-special-keyword
                  org-property-value))
    (set-face-attribute face nil :inherit 'fixed-pitch))
  :hook
  (org-mode . (lambda ()
                (setq-local line-spacing 2)
                (mixed-pitch-mode)
                (visual-line-mode)
                (visual-fill-column-mode)
                (org-superstar-mode))))

(use-package mixed-pitch
  :after org
  :config
  (set-face-attribute 'default nil :font "PragmataPro Mono Liga")
  (set-face-attribute 'fixed-pitch nil :font "PragmataPro Mono Liga")
  (set-face-attribute 'variable-pitch nil :font "Noto Serif"))

(use-package org-superstar
  :after org
  :config
  (setq org-superstar-headline-bullets-list '("☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷")
        org-superstar-item-bullet-alist '((43 . "⬧") (45 . "⬨")))
  (set-face-attribute 'org-superstar-item nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-superstar-header-bullet nil :height 232 :inherit 'fixed-pitch))

(use-package visual-fill-column
  :after org
  :custom
  (visual-fill-column-width 72))

(use-package org-roam
  :config
  (setq org-roam-directory "~/Dropbox/org-roam")
  :bind
  (("C-c n f" . org-roam-node-find)
   ("C-c n i" . org-roam-node-insert)))

(use-package org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))


(provide 'init-org)
