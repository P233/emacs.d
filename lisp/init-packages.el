;;----------------------------------------------------------------------------
;; Ivy
;;----------------------------------------------------------------------------

(use-package counsel
  :diminish ivy-mode
  :init
  (setq ivy-use-virtual-buffers t
        ivy-height 20
        ivy-wrap t)
  (ivy-mode t)
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-g") 'counsel-git)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-c C-g") 'counsel-git-grep)
  (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-partial)
  (define-key ivy-minibuffer-map (kbd "RET") 'ivy-alt-done))


;;----------------------------------------------------------------------------
;; Company
;;----------------------------------------------------------------------------

(use-package company
  :diminish company-mode
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
  :diminish yas-minor-mode
  :init
  (setq yas-snippet-dirs (expand-file-name "snippets" user-emacs-directory))
  (yas-global-mode t))


;;----------------------------------------------------------------------------
;; Evil
;;----------------------------------------------------------------------------

(use-package evil
  :init
  (setq evil-shift-width global-indentation-size
        evil-want-C-i-jump nil
        evil-emacs-state-cursor 'bar)
  (evil-mode)

  :config
  ;; Replace evil insert state with Emacs state
  (defadvice evil-insert-state (around emacs-state-instead-of-insert-state activate)
    (evil-emacs-state))

  ;; Evil emacs state for Magit commit
  (add-hook 'with-editor-mode-hook 'evil-emacs-state)

  ;; Key bindings for evil-emacs state
  ;; ---------------------------------
  (define-key evil-normal-state-map (kbd "M-.") nil) ; unbind "M-." for tags
  (define-key evil-emacs-state-map  [escape]    'evil-normal-state)
  (define-key evil-emacs-state-map  (kbd "C-o") 'evil-execute-in-normal-state)
  (define-key evil-emacs-state-map  (kbd "M-p") 'evil-complete-previous)
  (define-key evil-emacs-state-map  (kbd "M-n") 'evil-complete-next)
  (define-key evil-emacs-state-map  (kbd "M-P") 'evil-complete-previous-line)
  (define-key evil-emacs-state-map  (kbd "M-N") 'evil-complete-next-line)
  ;; show all yasnippet in company
  (define-key evil-emacs-state-map  (kbd "C-.") 'company-yasnippet)
  ;; expand yasnippet instead of trigging company autocomple.
  (define-key evil-emacs-state-map  (kbd "C-,") 'yas-expand)
  ;; align-regexp
  (define-key evil-visual-state-map (kbd "C-=") 'align-regexp)
  ;; yank without moving cursor
  (define-key evil-visual-state-map (kbd "y") (lambda ()
                                                (interactive)
                                                (save-excursion
                                                  (call-interactively 'evil-yank)))))


;;----------------------------------------------------------------------------
;; Evil Plugins
;;----------------------------------------------------------------------------

(use-package evil-leader
  ;; not works in *Messages*
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "b" 'switch-to-buffer
    "c" 'evil-commentary-line
    "f" 'find-file
    "g" 'counsel-git
    "h" 'hs-toggle-hiding
    "k" 'kill-buffer
    "m" 'magit-status
    "p" 'parinfer-toggle-mode
    "q" 'kill-buffer-and-window
    "r" 'neotree-refresh
    "s" 'save-buffer
    "t" 'neotree-toggle
    "u" 'undo-tree-visualize
    "x" 'kill-this-buffer))


(use-package evil-commentary
  :diminish evil-commentary-mode
  :init
  (evil-commentary-mode))

(use-package evil-surround
  :config
  (evil-add-to-alist
   'evil-surround-pairs-alist
     ?\( '("(" . ")")
     ?\[ '("[" . "]")
     ?\{ '("{" . "}")
     ?\) '("( " . " )")
     ?\] '("[ " . " ]")
     ?\} '("{ " . " }"))
  (global-evil-surround-mode))


;;----------------------------------------------------------------------------
;; Magit
;;----------------------------------------------------------------------------

(use-package magit
  :bind
  ("C-x C-'" . magit-status))

(use-package evil-magit)

(use-package git-gutter-fringe
  :diminish git-gutter-mode
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
        neo-autorefresh nil)
  :config
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "r") 'neotree-refresh)
              (define-key evil-normal-state-local-map (kbd "c") 'neotree-change-root)
              (define-key evil-normal-state-local-map (kbd "C-c C-t") 'neotree-hidden-file-toggle))))


(use-package avy
  :init
  (setq avy-keys '(?u ?h ?e ?t ?o ?n ?a ?s ?i ?d))
  (global-set-key (kbd "C-c C-'") 'avy-goto-char))


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



(provide 'init-packages)
