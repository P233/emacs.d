;; Set global-indentation-size
(defvar global-indentation-size 2
  "Globally shared indentation setting.")


;; Disable backup, auto-save and lockfiles
(setq backup-inhibited t
      make-backup-files nil
      auto-save-list-file-prefix nil
      auto-save-default nil
      create-lockfiles nil)


;; Disable ring-bell-function
(setq ring-bell-function 'ignore)


;; Enable recentf-mode
(recentf-mode)


;; Auto revert buffer
(global-auto-revert-mode t)


;; Enable quick yes
(defalias 'yes-or-no-p 'y-or-n-p)


;; Enable advanced ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)


;; Make dired use the same buffer for viewing directory
(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))



(provide 'init-settings)
