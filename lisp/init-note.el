;; -*- lexical-binding: t; -*-
(use-package markdown-mode)

(use-package org
  :straight (:type built-in)
  :defer t
  :custom
  (org-ellipsis " ⭍")
  (org-tags-column 0)
  (org-log-into-drawer t)
  (org-pretty-entities t)
  (org-startup-indented t)
  (org-hide-leading-stars nil)
  (org-hide-emphasis-markers t)
  (org-image-actual-width '(800))
  (org-startup-with-inline-images t)
  (org-indent-mode-turns-on-hiding-stars nil)
  :custom-face
  (org-level-1 ((t (:height 1.15))))
  (org-level-2 ((t (:height 1.13))))
  (org-level-3 ((t (:height 1.11))))
  (org-level-4 ((t (:height 1.09))))
  (org-level-5 ((t (:height 1.07))))
  (org-level-6 ((t (:height 1.05))))
  (org-level-7 ((t (:height 1.03))))
  (org-level-8 ((t (:height 1.01))))
  (org-tag ((t (:inherit 'fixed-pitch))))
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
  (defun my/org-font-lock-drawer (limit)
    (when
        (or (re-search-forward "SCHEDULED:\\(\\(.\\|\n\\)+:\s*\n\\)" limit t)
            (re-search-forward ".+?:\s+\\(.+\\)$" limit t))
      (let ((beg (match-beginning 1))
            (end (match-end 1)))
        (put-text-property beg end 'face 'fixed-pitch)
        (put-text-property (match-beginning 0) (match-end 0) 'font-lock-multiline 't)
        (goto-char end))))
  (font-lock-add-keywords 'org-mode
                          '(my/org-font-lock-drawer))
  ;; https://emacs-china.org/t/org-mode/22313
  (font-lock-add-keywords 'org-mode
                          '(("\\cc\\( \\)[/+*_=~][^a-zA-Z0-9/+*_=~\n]+?[/+*_=~]\\( \\)?\\cc?"
                             (1 (prog1 () (compose-region (match-beginning 1) (match-end 1) ""))))
                            ("\\cc?\\( \\)?[/+*_=~][^a-zA-Z0-9/+*_=~\n]+?[/+*_=~]\\( \\)\\cc"
                             (2 (prog1 () (compose-region (match-beginning 2) (match-end 2) "")))))
                          'append)
  :hook
  (org-mode . (lambda ()
                (setq-local line-spacing 2)
                (visual-line-mode)
                (visual-fill-column-mode)
                (mixed-pitch-mode)
                (org-superstar-mode)
                (org-appear-mode))))

(use-package visual-fill-column
  :after org
  :custom
  (visual-fill-column-width 88))

(use-package mixed-pitch
  :after org
  :custom-face
  (default ((t (:font "PragmataPro Mono"))))
  (fixed-pitch ((t (:font "PragmataPro Mono" :height 1.0))))
  (variable-pitch ((t (:font "Noto Serif" :height 1.0)))))

(use-package org-superstar
  :after org
  :custom
  (org-superstar-leading-bullet ?\s)
  (org-superstar-special-todo-items t)
  (org-superstar-item-bullet-alist '((43 . "⬧") (45 . "⬨")))
  (org-superstar-headline-bullets-list '("☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷"))
  :custom-face
  (org-superstar-item ((t (:inherit 'fixed-pitch))))
  (org-superstar-header-bullet ((t (:height 232 :inherit 'fixed-pitch)))))

(use-package org-appear
  :after org)

(use-package org-ql
  :after org)


(provide 'init-note)
