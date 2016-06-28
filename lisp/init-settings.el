;; Disable backup, auto-save and lockfiles
(setq backup-inhibited t
      make-backup-files nil
      auto-save-list-file-prefix nil
      auto-save-default nil
      create-lockfiles nil)


;; Enable recentf-mode
(recentf-mode)


;; Quick yes
(defalias 'yes-or-no-p 'y-or-n-p)


(provide 'init-settings)
