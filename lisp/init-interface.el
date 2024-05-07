;; -*- lexical-binding: t; -*-
(add-to-list 'default-frame-alist '(font . "PragmataPro Mono 18"))
(set-fontset-font "fontset-default" 'han "Noto Serif SC Medium")

(use-package ef-themes
  :config
  (defun my/apply-theme (appearance)
    (mapc #'disable-theme custom-enabled-themes)
    (pcase appearance
      ('dark (load-theme 'ef-winter :no-confirm))
      ('light (load-theme 'ef-summer :no-confirm)))
    (set-face-bold-p 'bold nil))
  (add-hook 'ns-system-appearance-change-functions #'my/apply-theme))

(use-package doom-modeline
  :custom
  (doom-modeline-icon nil)
  (doom-modeline-height 24)
  (doom-modeline-minor-modes t)
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  :hook
  (after-init . doom-modeline-mode))

(use-package minions
  :after doom-modeline
  :config
  (minions-mode t))

(use-package rainbow-mode
  :defer t)

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package neotree
  :custom
  (neo-theme 'arrow)
  (neo-smart-open t)
  (neo-autorefresh nil)
  (neo-mode-line-type 'none)
  (neo-window-position 'right)
  (neo-default-system-application "open")
  (neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "node_modules"))
  :custom-face
  (neo-dir-link-face ((t (:inherit font-lock-builtin-face))))
  (neo-expand-btn-face ((t (:inherit font-lock-builtin-face))))
  :bind
  (("C-t"     . neotree-toggle)
   ("C-c t"   . neotree-show)
   ("C-c C-o" . neotree-open-file-in-system-application)))

(use-package popper
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "\\*Backtrace\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          help-mode
          compilation-mode))
  (popper-mode)
  (popper-echo-mode))


;; https://emacs-china.org/t/topic/945/2
(defun my/split-window-below ()
  "Split window with another buffer."
  (interactive)
  (select-window (split-window-below))
  (switch-to-buffer (other-buffer)))
(global-set-key (kbd "C-x 2") 'my/split-window-below)

(defun my/split-window-right ()
  "Split window with another buffer."
  (interactive)
  (select-window (split-window-right))
  (switch-to-buffer (other-buffer)))
(global-set-key (kbd "C-x 3") 'my/split-window-right)

;; http://emacsredux.com/blog/2013/04/28/switch-to-previous-buffer/
(defun my/switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(global-set-key (kbd "C-c b") 'my/switch-to-previous-buffer)


(provide 'init-interface)
