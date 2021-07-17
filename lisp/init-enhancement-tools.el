(global-set-key (kbd "C-x C-b") 'ibuffer)

(recentf-mode)
(add-to-list 'recentf-exclude (concat user-emacs-directory "elpa/.*"))

(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(use-package smex)

(use-package flycheck
  :custom
  (flycheck-check-syntax-automatically '(mode-enabled save)))

(use-package company-tabnine)

(use-package company
  :after company-tabnine
  :init
  (add-to-list 'company-backends #'company-tabnine)
  :custom
  (company-idle-delay 0)
  (company-echo-delay 0)
  (company-show-numbers t)
  (company-dabbrev-downcasbe nil)
  (company-selection-wrap-around t)
  (company-minimum-prefix-length 1)
  (company-global-modes '(not org-mode))
  :bind
  (:map company-active-map ("C-n" . company-select-next))
  (:map company-active-map ("C-p" . company-select-previous))
  :config
  (global-company-mode))

(use-package counsel
  :custom
  (ivy-wrap t)
  (ivy-height 20)
  (ivy-use-virtual-buffers t)
  (ivy-use-selectable-prompt t)
  :config
  (ivy-mode 1)
  :bind
  ("M-x"   . counsel-M-x)
  ("C-c s" . swiper)
  ("C-c f" . counsel-git)
  ("C-c g" . counsel-git-grep)
  (:map ivy-minibuffer-map ("TAB" . ivy-partial))
  (:map ivy-minibuffer-map ("RET" . ivy-alt-done)))

(use-package projectile
  :custom
  (projectile-completion-system 'ivy)
  :config
  (projectile-mode t))

(use-package counsel-projectile
  :after projectile
  :config
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c o") 'counsel-projectile-switch-project))

(use-package neotree
  :custom
  (neo-theme 'arrow)
  (neo-smart-open t)
  (neo-window-position 'right)
  (neo-autorefresh nil)
  (neo-mode-line-type 'none)
  (neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "node_modules"))
  :bind
  ("C-c t" . neotree-toggle)
  ("C-c e" . neotree-show))

(use-package gcmh
  :config
  (gcmh-mode))

(use-package zoom
  :config
  (zoom-mode t))


(provide 'init-enhancement-tools)
