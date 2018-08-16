;; Smex mode
(use-package smex)


;; Popwin mode
(use-package popwin
  :config
  (popwin-mode t))


;; Ivy mode
(use-package ivy
  :init
  (setq ivy-use-virtual-buffers t
        ivy-height 20
        ivy-wrap t
        ivy-use-selectable-prompt t)
  :config
  (ivy-mode t)
  :bind
  ("M-x"   . counsel-M-x)
  ("C-c s" . swiper)
  ("C-c g" . counsel-git)
  ("C-c f" . counsel-git-grep)
  (:map ivy-minibuffer-map ("TAB" . ivy-partial))
  (:map ivy-minibuffer-map ("RET" . ivy-alt-done)))


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
  ("C-c t" . neotree-toggle))



(provide 'init-utilities)
