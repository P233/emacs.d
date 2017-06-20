(load-library "find-lisp")


(setq org-src-fontify-natively t
      org-agenda-files (find-lisp-find-files (expand-file-name "org-notes" user-emacs-directory) "\.org$"))

(add-hook 'org-mode-hook
          (lambda ()
            (modify-syntax-entry ?~ "(~" org-mode-syntax-table)))



(provide 'init-org)
