;;----------------------------------------------------------------------------
;; Mark package to never be considered for upgrade
;;----------------------------------------------------------------------------

;; https://emacs.stackexchange.com/questions/9331/mark-package-to-never-be-considered-for-upgrade
(defvar package-menu-exclude-packages '("emmet-mode"))

(defun package-menu--remove-excluded-packages (orig)
  (let ((included (-filter
                   (lambda (entry)
                     (let ((name (symbol-name (package-desc-name (car entry)))))
                       (not (member name package-menu-exclude-packages))))
                   tabulated-list-entries)))
    (setq-local tabulated-list-entries included)
    (funcall orig)))

(advice-add 'package-menu--find-upgrades :around #'package-menu--remove-excluded-packages)


;;----------------------------------------------------------------------------
;; Ivy
;;----------------------------------------------------------------------------

(use-package ivy
  :init
  (setq ivy-use-virtual-buffers t
        ivy-height 20
        ivy-wrap t
        ivy-use-selectable-prompt t)
  :config
  (ivy-mode t)
  (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-partial)
  (define-key ivy-minibuffer-map (kbd "RET") 'ivy-alt-done)
  :bind
  ("M-x"   . counsel-M-x)
  ("C-c s" . swiper)
  ("C-c g" . counsel-git)
  ("C-c f" . counsel-git-grep))


;;----------------------------------------------------------------------------
;; Company
;;----------------------------------------------------------------------------

(use-package company
  :init
  (setq company-idle-delay 0
        company-echo-delay 0
        company-show-numbers t
        company-minimum-prefix-length 2
        company-dabbrev-downcase nil
        company-selection-wrap-around t
        company-global-modes '(not org-mode))
  :config
  (global-company-mode)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))


;;----------------------------------------------------------------------------
;; Yasnippet
;;----------------------------------------------------------------------------

(use-package yasnippet
  :config
  (yas-global-mode t)
  (setq yas-snippet-dirs (expand-file-name "snippets" user-emacs-directory)))


;;----------------------------------------------------------------------------
;; Expand Region
;;----------------------------------------------------------------------------

(use-package expand-region
  :bind
  ("C-'" . er/expand-region))

;; Custome copy and cut key bindings
(global-set-key (kbd "C-,") 'kill-ring-save)
(global-set-key (kbd "C-.") 'kill-region)


;;----------------------------------------------------------------------------
;; Vistual Replace
;;----------------------------------------------------------------------------

(use-package visual-regexp
  :bind
  ("C-c r" . vr/replace)
  ("C-c q" . vr/query-replace))


;;----------------------------------------------------------------------------
;; Popwin
;;----------------------------------------------------------------------------

(use-package popwin
  :config
  (popwin-mode t))


;;----------------------------------------------------------------------------
;; Magit
;;----------------------------------------------------------------------------

(use-package magit
  :bind
  ("C-c m" . magit-status))

(use-package git-gutter-fringe
  :config
  (global-git-gutter-mode t))

(use-package git-timemachine)


;;----------------------------------------------------------------------------
;; Flycheck
;;----------------------------------------------------------------------------

(use-package flycheck
  :config
  (flycheck-add-mode 'javascript-eslint 'web-mode))


;;----------------------------------------------------------------------------
;; Other Packages
;;----------------------------------------------------------------------------

(use-package smex)


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


(use-package avy
  :init
  (setq avy-keys '(?u ?h ?e ?t ?o ?n ?a ?s ?i ?d))
  :bind
  ("C-c '" . avy-goto-char))


(use-package pinyin-search
  :bind
  ("C-c \"" . pinyin-search))


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


(use-package popup-kill-ring
  :bind
  ("C-c p" . popup-kill-ring))


;;----------------------------------------------------------------------------
;; end
;;----------------------------------------------------------------------------

(provide 'init-packages)
