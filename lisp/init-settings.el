(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

(defvar my/indentation-size 2)
(setq standard-indent my/indentation-size)
(setq-default indent-tabs-mode nil
              tab-width my/indentation-size)

(setq backup-inhibited t
      make-backup-files nil
      auto-save-list-file-prefix nil
      auto-save-default nil
      create-lockfiles nil)
(setq ring-bell-function 'ignore)

(setq read-process-output-max (* 1024 1024))

(defalias 'yes-or-no-p 'y-or-n-p)


(provide 'init-settings)
