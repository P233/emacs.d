;; -*- lexical-binding: t; -*-
(use-package no-littering
  :demand t
  :config
  (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
  ;; Overrides the session-list location no-littering assigns at load time
  (setq auto-save-list-file-prefix nil))

(use-package gcmh
  :demand t
  :config
  (gcmh-mode))

(use-package exec-path-from-shell
  :if (not (bound-and-true-p ns-emacs-plus-injected-path))
  :config
  (exec-path-from-shell-initialize))

(use-package which-key
  :straight (:type built-in)
  :config
  (which-key-mode 1))

;; Recentf must recognize remote paths while startup file handlers are disabled.
(let ((file-name-handler-alist (or file-name-handler-alist default-file-name-handler-alist)))
  (recentf-mode t))
(savehist-mode t)
(global-auto-revert-mode t)

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
