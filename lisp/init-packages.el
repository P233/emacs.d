;;----------------------------------------------------------------------------
;; Ivy
;;----------------------------------------------------------------------------

(use-package counsel
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
  :init
  (setq company-idle-delay 0
        company-echo-delay 0
        company-show-numbers t
        company-minimum-prefix-length 2
        company-dabbrev-downcase nil
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
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode t))


;;----------------------------------------------------------------------------
;; Magit
;;----------------------------------------------------------------------------

(use-package magit
  :bind
  ("C-x C-'" . magit-status))

(use-package git-gutter
  :init
  (global-git-gutter-mode t)
  :config
  (set-face-foreground 'git-gutter:modified "#d3869b")
  (set-face-foreground 'git-gutter:added "#b8bb26")
  (set-face-foreground 'git-gutter:deleted "#fb4934"))

(use-package git-timemachine)


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

  ;; Switching status bar colour
  (add-hook 'post-command-hook
            (lambda ()
              (let ((color (cond ((evil-normal-state-p)  '("#689d6a"))
                                 ((evil-emacs-state-p)   '("#076678"))
                                 ((evil-visual-state-p)  '("#d65d0e"))
                                 ((evil-replace-state-p) '("#cc241d"))
                                 (t '("#3c3836")))))
                (set-face-background 'mode-line (car color))))
            (set-face-foreground 'mode-line "#ebdbb2"))

  ;; Key bindings for evil-emacs state
  ;; ---------------------------------
  ;; unbind "M-."
  (define-key evil-normal-state-map  (kbd "M-.") nil)

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
  (define-key evil-visual-state-map (kbd "C-=") 'align-regexp))


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
    "f" 'find-file
    "g" 'counsel-git
    "h" 'hs-toggle-hiding
    "k" 'kill-buffer
    "m" 'magit-status
    "r" 'neotree-refresh
    "s" 'save-buffer
    "t" 'neotree-toggle
    "u" 'undo-tree-visualize
    "v" 'multi-web-mode
    "x" 'kill-this-buffer))

(use-package evil-nerd-commenter
  :config
  (evil-leader/set-key
    "cl" 'evilnc-comment-or-uncomment-lines
    "cp" 'evilnc-comment-or-uncomment-paragraphs))

(use-package evil-surround
  :config
  (global-evil-surround-mode))

(use-package evil-magit)


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
  (setq neo-smart-open t
        neo-window-position 'right)
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
  (global-set-key (kbd "C-'") 'avy-goto-char-2))


(use-package pinyin-search
  :init
  (global-set-key (kbd "C-\"") 'pinyin-search))


(use-package window-numbering
  :init
  (window-numbering-mode))


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


(use-package browse-kill-ring)


;; npm install -g js-beautify
(use-package web-beautify)


(use-package rainbow-mode)
(use-package rainbow-delimiters)



(provide 'init-packages)
