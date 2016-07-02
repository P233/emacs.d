(setq org-startup-folded nil
      org-startup-truncated nil)


(add-hook 'org-mode-hook
          (lambda ()
            (modify-syntax-entry ?~ "(~" org-mode-syntax-table)
            (modify-syntax-entry ?= "(=" org-mode-syntax-table)
            (modify-syntax-entry ?* "(*" org-mode-syntax-table)
            (modify-syntax-entry ?/ "(/" org-mode-syntax-table)
            (define-key org-mode-map (kbd "C-'") nil)))


(provide 'init-org)
