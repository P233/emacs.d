;; -*- lexical-binding: t; -*-
(use-package gcmh
  :config
  (gcmh-mode))

(set-language-environment 'utf-8)

(defalias 'yes-or-no-p 'y-or-n-p)

(defvar my/indentation-size 2)
(setq standard-indent my/indentation-size)
(setq-default indent-tabs-mode nil
              tab-width my/indentation-size)


(provide 'init-settings)
