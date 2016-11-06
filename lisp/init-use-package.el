(require 'package)
(setq package-enable-at-startup nil
      package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
                          ("melpa" . "http://elpa.zilongshanren.com/melpa/")))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)

(require 'use-package)



(provide 'init-use-package)
