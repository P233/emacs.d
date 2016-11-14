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


;; Enable subword-mode
(global-subword-mode t)


;; Enable show-paren-mode
(setq show-paren-delay 0)
(show-paren-mode t)


;; Enable the following minor modes for programming languages
(add-hook 'prog-mode-hook
          (lambda ()
            (hs-minor-mode)
            (rainbow-delimiters-mode)))


;; npm install -g js-beautify
(use-package web-beautify)


;; Clone indirect buffer
(global-set-key (kbd "C-c C-c") 'clone-indirect-buffer)



(provide 'init-code-styles)
