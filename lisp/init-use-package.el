(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(("gnu"          . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa-stable" . "http://stable.melpa.org/packages/")
        ("melpa"        . "http://melpa.org/packages/"))
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



(provide 'init-use-package)
