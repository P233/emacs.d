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
;; Completion
;;----------------------------------------------------------------------------

(use-package company
  :init
  (setq company-idle-delay 0
        company-echo-delay 0
        company-show-numbers t
        company-minimum-prefix-length 2
        company-dabbrev-downcase nil
        ;; company-auto-complete t
        ;; company-auto-complete-chars '(?\()
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


(use-package yasnippet
  :init
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode t))


;;----------------------------------------------------------------------------
;; Evil
;;----------------------------------------------------------------------------

;; Evil-mode
(use-package evil
  :init
  (setq evil-shift-width global-indentation-size
        evil-want-C-i-jump nil
        evil-emacs-state-cursor 'bar)
  (evil-mode)

  :config
  ;; status bar colour
  (add-hook 'post-command-hook
            (lambda ()
              (let ((color (cond ((evil-normal-state-p)  '("#6DB100"))
                                 ((evil-emacs-state-p)   '("#865C38"))
                                 ((evil-visual-state-p)  '("#C85700"))
                                 ((evil-replace-state-p) '("#D12043"))
                                 (t '("#865C38")))))
                (set-face-background 'mode-line (car color)))))

  ;; Replace evil insert state with Emacs state
  (defadvice evil-insert-state (around emacs-state-instead-of-insert-state activate)
    (evil-emacs-state))

  ;; evil-emacs state key bindings
  (define-key evil-normal-state-map  (kbd "M-.") nil)

  (define-key evil-emacs-state-map  [escape]    'evil-normal-state)
  (define-key evil-emacs-state-map  (kbd "C-o") 'evil-execute-in-normal-state)
  (define-key evil-emacs-state-map  (kbd "M-p") 'evil-complete-previous)
  (define-key evil-emacs-state-map  (kbd "M-n") 'evil-complete-next)
  (define-key evil-emacs-state-map  (kbd "M-P") 'evil-complete-previous-line)
  (define-key evil-emacs-state-map  (kbd "M-N") 'evil-complete-next-line)
  ;; company shortcut
  (define-key evil-emacs-state-map  (kbd "C-.") 'company-yasnippet)
  ;; yasnippet shortcut
  (define-key evil-emacs-state-map  (kbd "C-,") 'yas-expand)
  ;; align-regexp shortcut
  (define-key evil-visual-state-map (kbd "C-=") 'align-regexp)) ; end Evil


;; Evil-mode plugins
(use-package evil-leader
  ;; not works in *scratch* and *Messages*
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "f" 'find-file
    "g" 'counsel-git
    "b" 'switch-to-buffer
    "k" 'kill-buffer
    "s" 'save-buffer
    "x" 'kill-this-buffer
    "v" 'multi-web-mode
    "m" 'magit-status
    "u" 'undo-tree-visualize
    "t" 'neotree-toggle))

(use-package evil-nerd-commenter
  :config
  (evil-leader/set-key
    "cl" 'evilnc-comment-or-uncomment-lines
    "cp" 'evilnc-comment-or-uncomment-paragraphs))

(use-package evil-surround
  :init
  (global-evil-surround-mode))


;; VI open line
;; http://stackoverflow.com/questions/2173324/emacs-equivalents-of-vims-dd-o-o
(defun vi-open-line-above ()
  "Insert a newline above the current line and put point at beginning."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

(defun vi-open-line-below ()
  "Insert a newline below the current line and put point at beginning."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))

(global-set-key (kbd "<C-return>")  'vi-open-line-above)
(global-set-key (kbd "M-RET")       'vi-open-line-below)


;;----------------------------------------------------------------------------
;; Git
;;----------------------------------------------------------------------------

(use-package magit
  :bind
  ("C-x C-'" . magit-status))

(use-package git-gutter
  :init
  (global-git-gutter-mode t))

(use-package evil-magit)


;;----------------------------------------------------------------------------
;; Flycheck
;;----------------------------------------------------------------------------

(use-package flycheck
  :config
  (flycheck-add-mode 'javascript-eslint 'web-mode))


;;----------------------------------------------------------------------------
;; GGtags
;;----------------------------------------------------------------------------

;; brew install --HEAD ctags
;; brew install global --with-exuberant-ctags
;; (use-package ggtags)


;;----------------------------------------------------------------------------
;; Other Packages
;;----------------------------------------------------------------------------

(use-package smex)


(use-package avy
  :init
  (setq avy-keys '(?u ?h ?e ?t ?o ?n ?a ?s ?i ?d))
  (global-set-key (kbd "C-'") 'avy-goto-char-2))


(use-package pinyin-search
  :init
  (global-set-key (kbd "C-\"") 'pinyin-search))


(use-package neotree
  :config
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "r") 'neotree-refresh)
              (define-key evil-normal-state-local-map (kbd "c") 'neotree-change-root)
              (define-key evil-normal-state-local-map (kbd "C-c C-t") 'neotree-hidden-file-toggle))))


(use-package window-numbering
  :init
  (window-numbering-mode))


(use-package buffer-move
  :init
  ;; Resize window
  (global-set-key (kbd "<S-up>")      'shrink-window)
  (global-set-key (kbd "<S-down>")    'enlarge-window)
  (global-set-key (kbd "<S-left>")    'shrink-window-horizontally)
  (global-set-key (kbd "<S-right>")   'enlarge-window-horizontally)
  ;; Buffer-move
  (global-set-key (kbd "<C-S-up>")    'buf-move-up)
  (global-set-key (kbd "<C-S-down>")  'buf-move-down)
  (global-set-key (kbd "<C-S-left>")  'buf-move-left)
  (global-set-key (kbd "<C-S-right>") 'buf-move-right))


(use-package osx-dictionary)


(use-package browse-kill-ring)


(provide 'init-packages)
