;; Prefer utf8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;; Set standard-indent size
(setq standard-indent global-indentation-size)

;; Disable tab indentation
(setq-default indent-tabs-mode nil)

;; Remove trailing whitespace and untabify before saving file
(add-hook 'before-save-hook
          (lambda ()
            (untabify 1 (point-max))
            (delete-trailing-whitespace)))


;; Enable electric-pair-mode
(electric-pair-mode t)



(provide 'init-code-styles)
