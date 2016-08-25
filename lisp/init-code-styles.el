; Global indentation size
(defvar global-indentation-size 2
  "indent everything with 2 spaces")
(setq standard-indent global-indentation-size)


;; Use spaces for indentation
(setq indent-tabs-mode nil)
;; Remove trailing whitespace and untabify all lines when saving file
(add-hook 'before-save-hook
          (lambda ()
            (delete-trailing-whitespace)
            (untabify (point-min) (point-max))))


;; Subword-mode
(global-subword-mode t)


;; Show paren
(setq show-paren-delay 0)
(show-paren-mode t)


;; Auto bracket
(electric-pair-mode t)



(provide 'init-code-styles)
