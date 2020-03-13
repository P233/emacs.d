(require 'package)

(defvar package-menu-exclude-packages '("emmet-mode"))

(setq package-enable-at-startup nil
      package-archives
      '(("gnu"          . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa-stable" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
        ("melpa"        . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))
      package-archive-priorities
      '(("melpa-stable" . 1)
        ("gnu"          . 2)
        ("melpa"        . 3)))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)
(require 'use-package)

;; https://emacs.stackexchange.com/questions/9331/mark-package-to-never-be-considered-for-upgrade
(defun package-menu--remove-excluded-packages (orig)
  (let ((included (-filter
                   (lambda (entry)
                     (let ((name (symbol-name (package-desc-name (car entry)))))
                       (not (member name package-menu-exclude-packages))))
                   tabulated-list-entries)))
    (setq-local tabulated-list-entries included)
    (funcall orig)))
(advice-add 'package-menu--find-upgrades :around #'package-menu--remove-excluded-packages)


(provide 'init-use-package)
