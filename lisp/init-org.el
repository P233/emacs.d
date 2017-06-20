(setq org-src-fontify-natively t)

(add-hook 'org-mode-hook
          (lambda ()
            (modify-syntax-entry ?~ "(~" org-mode-syntax-table)))



(provide 'init-org)
