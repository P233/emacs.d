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

(use-package counsel
  :init
  (setq ivy-use-virtual-buffers t
        ivy-height 20
        ivy-wrap t
        ivy-use-selectable-prompt t)
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-g") 'counsel-git)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-c C-g") 'counsel-git-grep)
  (ivy-mode t)
  :config
  (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-partial)
  (define-key ivy-minibuffer-map (kbd "RET") 'ivy-alt-done))


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
        company-global-modes '(not org-mode markdown-mode))
  (global-company-mode)
  :config
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

(use-package company-quickhelp
  :init
  (setq company-quickhelp-delay nil)
  (company-quickhelp-mode)
  :config
  (eval-after-load 'company
    '(define-key company-active-map (kbd "C-h") #'company-quickhelp-manual-begin)))


;;----------------------------------------------------------------------------
;; Yasnippet
;;----------------------------------------------------------------------------

(use-package yasnippet
  :init
  (yas-global-mode t)
  :config
  (setq yas-snippet-dirs (expand-file-name "snippets" user-emacs-directory)))


;;----------------------------------------------------------------------------
;; Vistual Replace
;;----------------------------------------------------------------------------

(use-package visual-regexp
  :config
  (define-key global-map (kbd "C-r") 'vr/replace)
  (define-key global-map (kbd "C-q") 'vr/query-replace))


;;----------------------------------------------------------------------------
;; Magit
;;----------------------------------------------------------------------------

(use-package magit
  :bind
  ("C-x C-'" . magit-status))

(use-package git-gutter-fringe
  :init
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
        neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "node_modules")))

(use-package avy
  :init
  (setq avy-keys '(?u ?h ?e ?t ?o ?n ?a ?s ?i ?d))
  (global-set-key (kbd "C-c C-'") 'avy-goto-char))


(use-package ace-window
  :init
  (global-set-key (kbd "M-o") 'ace-window))


(use-package pinyin-search
  :init
  (global-set-key (kbd "C-c C-\"") 'pinyin-search))


(use-package buffer-move
  :init
  ;; move buffer
  (global-set-key (kbd "<C-S-up>")    'buf-move-up)
  (global-set-key (kbd "<C-S-down>")  'buf-move-down)
  (global-set-key (kbd "<C-S-left>")  'buf-move-left)
  (global-set-key (kbd "<C-S-right>") 'buf-move-right)
  ;; resize window
  (global-set-key (kbd "<S-up>")      'shrink-window)
  (global-set-key (kbd "<S-down>")    'enlarge-window)
  (global-set-key (kbd "<S-left>")    'shrink-window-horizontally)
  (global-set-key (kbd "<S-right>")   'enlarge-window-horizontally))


(use-package popup-kill-ring
  :bind
  ("C-c C-p" . popup-kill-ring))


;;----------------------------------------------------------------------------
;; end
;;----------------------------------------------------------------------------

(provide 'init-packages)
