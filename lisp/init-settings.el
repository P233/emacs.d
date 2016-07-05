;; Disable backup, auto-save and lockfiles
(setq backup-inhibited t
      make-backup-files nil
      auto-save-list-file-prefix nil
      auto-save-default nil
      create-lockfiles nil)


(setq ring-bell-function 'ignore)


;; Enable recentf-mode
(recentf-mode)


;; Quick yes
(defalias 'yes-or-no-p 'y-or-n-p)


;; Make dired use the same buffer for viewing directory
(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))


(provide 'init-settings)
