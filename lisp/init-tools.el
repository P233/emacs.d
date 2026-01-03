;; -*- lexical-binding: t; -*-
(use-package no-littering
  :demand t
  :config
  (setq custom-file (no-littering-expand-etc-file-name "custom.el")))

(use-package gcmh
  :demand t
  :config
  (gcmh-mode))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package which-key
  :config
  (which-key-mode))

(put 'dired-find-alternate-file 'disabled nil)

(setq project-switch-commands 'project-find-file)


(defun my/git-root ()
  (or (vc-root-dir)
      (locate-dominating-file default-directory ".git")
      default-directory))

(defun my/open-in-vscode ()
  (interactive)
  (let* ((root (expand-file-name (my/git-root)))
         (file (buffer-file-name))
         (code (executable-find "code"))
         (args (when file
                 (list "--goto" (format "%s:%d:%d"
                                        file
                                        (line-number-at-pos)
                                        (1+ (current-column)))))))
    (if code
        (apply #'start-process "vscode" nil code "-r" root args)
      (apply #'start-process "vscode" nil "open" "-a" "Visual Studio Code" root
             (when args (cons "--args" args))))))


(provide 'init-tools)
