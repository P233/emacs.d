;; Smex mode
(use-package smex)


;; Popwin mode
(use-package popwin
  :config
  (popwin-mode t))


;; Ivy, Counsel, and Swiper
(use-package counsel
  :init
  (setq ivy-use-virtual-buffers t
        ivy-height 20
        ivy-wrap t
        ivy-use-selectable-prompt t)
  (ivy-mode 1)
  :bind
  ("M-x"   . counsel-M-x)
  ("C-c s" . swiper)
  ("C-c f" . counsel-git)
  ("C-c g" . counsel-git-grep)
  (:map ivy-minibuffer-map ("TAB" . ivy-partial))
  (:map ivy-minibuffer-map ("RET" . ivy-alt-done)))


;; Projectile
(use-package projectile
  :config
  (projectile-mode t)
  (setq projectile-completion-system 'ivy))

(use-package counsel-projectile
  :config
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c o") 'counsel-projectile-switch-project))


;; Buffer-move mode
(use-package buffer-move
  :bind
  ;; move buffer
  ("<C-S-up>"    .  buf-move-up)
  ("<C-S-down>"  .  buf-move-down)
  ("<C-S-left>"  .  buf-move-left)
  ("<C-S-right>" .  buf-move-right)
  ;; resize window
  ("<S-up>"      .  shrink-window)
  ("<S-down>"    .  enlarge-window)
  ("<S-left>"    .  shrink-window-horizontally)
  ("<S-right>"   .  enlarge-window-horizontally))


;; Neotree
(use-package neotree
  :init
  (setq neo-theme 'arrow
        neo-smart-open t
        neo-window-position 'right
        neo-autorefresh nil
        neo-mode-line-type 'none
        neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "node_modules"))
  :bind
  ("C-c t" . neotree-toggle)
  ("C-c e" . neotree-refresh))


;; Zoom mode
(use-package zoom
  :config
  (zoom-mode t))



(provide 'init-utilities)
