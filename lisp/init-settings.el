;; Setup garbage collection
;; https://emacs.stackexchange.com/questions/34342/is-there-any-downside-to-setting-gc-cons-threshold-very-high-and-collecting-ga
(setq gc-cons-threshold (eval-when-compile (* 1024 1024 1024)))
(run-with-idle-timer 2 t (lambda () (garbage-collect)))


;; Disable backup, auto-save and lockfiles
(setq backup-inhibited t
      make-backup-files nil
      auto-save-list-file-prefix nil
      auto-save-default nil
      create-lockfiles nil)


;; Disable ring-bell-function
(setq ring-bell-function 'ignore)


;; Setup default path for 'find file'
(setq default-directory "~/Projects")


;; Enable quick yes
(defalias 'yes-or-no-p 'y-or-n-p)


;; Enable recentf-mode
(recentf-mode)
(add-to-list 'recentf-exclude (format (concat (expand-file-name user-emacs-directory) "elpa/.*")))


;; Enable advanced ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)


;; Make dired use the same buffer for viewing directory
(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))



(provide 'init-settings)
