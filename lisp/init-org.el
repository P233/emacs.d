;; -*- lexical-binding: t; -*-
(use-package org
  :pin manual
  :defer t
  :custom
  (org-directory "~/Dropbox/org")
  (org-agenda-files "~/Dropbox/org/agenda.org")
  (org-ellipsis " ⭍")
  (org-pretty-entities t)
  (org-startup-indented t)
  (org-hide-leading-stars t)
  (org-hide-emphasis-markers t)
  (org-image-actual-width '(800))
  (org-startup-with-inline-images t)
  (org-todo-keywords '((sequence "     " "   ")))
  :custom-face
  (org-level-1 ((t (:height 1.15))))
  (org-level-2 ((t (:height 1.13))))
  (org-level-3 ((t (:height 1.11))))
  (org-level-4 ((t (:height 1.09))))
  (org-level-5 ((t (:height 1.07))))
  (org-level-6 ((t (:height 1.05))))
  (org-level-7 ((t (:height 1.03))))
  (org-level-8 ((t (:height 1.01))))
  (org-todo ((t (:inherit 'fixed-pitch))))
  (org-done ((t (:inherit 'fixed-pitch))))
  (org-ellipsis ((t (:inherit 'fixed-pitch))))
  (org-property-value ((t (:inherit 'fixed-pitch))))
  (org-special-keyword ((t (:inherit 'fixed-pitch))))
  :config
  (unbind-key "C-'" org-mode-map)
  (unbind-key "C-," org-mode-map)
  :hook
  (org-mode . (lambda ()
                (setq-local line-spacing 2)
                (mixed-pitch-mode)
                (visual-line-mode)
                (visual-fill-column-mode)
                (org-superstar-mode))))

(use-package mixed-pitch
  :after org
  :custom-face
  (default ((t (:font "PragmataPro Mono Liga"))))
  (fixed-pitch ((t (:font "PragmataPro Mono Liga"))))
  (variable-pitch ((t (:font "Noto Serif")))))

(use-package org-superstar
  :after org
  :custom
  (org-superstar-headline-bullets-list '("☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷"))
  (org-superstar-item-bullet-alist '((43 . "⬧") (45 . "⬨")))
  :custom-face
  (org-superstar-item ((t (:inherit 'fixed-pitch))))
  (org-superstar-header-bullet ((t (:height 232 :inherit 'fixed-pitch)))))

(use-package visual-fill-column
  :after org
  :custom
  (visual-fill-column-width 72))

(use-package org-roam
  :custom
  (org-roam-directory "~/Dropbox/org-roam")
  :bind
  (("C-c n f" . org-roam-node-find)
   ("C-c n i" . org-roam-node-insert)))

(use-package org-roam-ui
  :after org-roam
  :custom
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t)
  (org-roam-ui-open-on-start t))


(provide 'init-org)
