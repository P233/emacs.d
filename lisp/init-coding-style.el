;; Prefer UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;; Set standard-indent size
(setq standard-indent global-indentation-size)


;; Disable tab indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width global-indentation-size)


;; Flycheck
(use-package flycheck)



(provide 'init-coding-style)
