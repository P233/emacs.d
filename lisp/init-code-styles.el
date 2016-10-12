;; Set standard-indent size
(setq standard-indent global-indentation-size)


;; Disable tab indentation
(setq-default indent-tabs-mode nil)


;; Enable subword-mode
(global-subword-mode t)


;; Enable electric-pair-mode
(electric-pair-mode t)


;; Enable show-paren-mode
(setq show-paren-delay 0)
(show-paren-mode t)


;; Enable the following minor modes for programming languages
(add-hook 'prog-mode-hook
          (lambda ()
            (hs-minor-mode)
            (rainbow-delimiters-mode)))


;; Remove trailing whitespace and untabify before saving file
(add-hook 'before-save-hook
          (lambda ()
            (untabify 1 (point-max))
            (delete-trailing-whitespace)))



(provide 'init-code-styles)
