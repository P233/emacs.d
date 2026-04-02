;; -*- lexical-binding: t; -*-
(setq-default straight-repository-branch "develop")
;; Skip the startup find(1) scan; package edits made outside Emacs need M-x straight-check-all
(setq straight-check-for-modifications '(check-on-save find-when-checking))
;; Native code is never loaded (load-no-native in early-init.el), so don't spend rebuilds producing it
(setq straight-disable-native-compile t)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t
      straight-vc-git-default-clone-depth 1)

(straight-use-package '(use-package :type built-in))


(provide 'init-straight)
