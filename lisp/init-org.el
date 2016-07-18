(setq org-startup-folded nil
      org-startup-truncated nil)

(require 'ox-md nil t)

(add-hook 'org-mode-hook
          (lambda ()
            (modify-syntax-entry ?~ "(~" org-mode-syntax-table)
            (define-key org-mode-map (kbd "C-'") nil)))


(provide 'init-org)
