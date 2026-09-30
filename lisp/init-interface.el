;; -*- lexical-binding: t; -*-
(add-to-list 'default-frame-alist '(font . "PragmataPro Mono 18"))
(set-fontset-font "fontset-default" 'han "Noto Serif SC Medium")

(pixel-scroll-precision-mode t)

(use-package ef-themes
  :config
  (defun my/apply-system-appearance (appearance)
    "Match the color theme and background opacity to macOS APPEARANCE."
    (let ((theme (if (eq appearance 'dark) 'ef-winter 'ef-summer))
          (opacity (if (eq appearance 'dark) 80 90)))
      (unless (memq theme custom-enabled-themes)
        (ef-themes-load-theme theme))
      (when (eq system-type 'darwin)
        (setf (alist-get 'alpha-background default-frame-alist) opacity)
        (dolist (frame (frame-list))
          (when (eq (window-system frame) 'ns)
            (set-frame-parameter frame 'alpha-background opacity))))))
  (when (boundp 'ns-system-appearance-change-functions)
    (add-hook 'ns-system-appearance-change-functions
              #'my/apply-system-appearance))
  (my/apply-system-appearance
   (if (boundp 'ns-system-appearance) ns-system-appearance 'light)))

(use-package doom-modeline
  :init
  (setq mode-line-collapse-minor-modes t
        mode-line-collapse-minor-modes-to " ≡")
  :custom
  (doom-modeline-icon nil)
  (doom-modeline-height 24)
  (doom-modeline-minor-modes t)
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  :hook
  (after-init . doom-modeline-mode))

(use-package rainbow-mode
  :defer t)

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package popper
  :init
  (setq popper-reference-buffers
        '("\\*Async Shell Command\\*"
          "\\*Backtrace\\*"
          "\\*Messages\\*"
          "Output\\*$"
          help-mode
          compilation-mode))
  (popper-mode)
  (popper-echo-mode))

(use-package treemacs
  :defer t
  :custom
  (treemacs-width 32)
  (treemacs-text-scale nil)
  (treemacs-no-png-images t)
  (treemacs-show-hidden-files nil)
  (treemacs-file-event-delay 1000)
  (treemacs-position 'right)
  :custom-face
  (treemacs-root-face ((t (:height 1.0 :weight bold))))
  :init
  (defun my/treemacs-ignore-files (name absolute-path)
    (and (member name '("cache" "dist" "node_modules"))
         (file-directory-p absolute-path)))
  :config
  (treemacs-project-follow-mode t)
  (setq treemacs--project-follow-delay 0.2)
  (add-to-list 'treemacs-ignored-file-predicates #'my/treemacs-ignore-files)
  :hook
  (treemacs-mode . (lambda ()
                     (setq mode-line-format nil))))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package winner
  :straight (:type built-in)
  :custom
  ;; The leader provides undo/redo; avoid adding another Control prefix.
  (winner-dont-bind-my-keys t)
  :config
  (winner-mode 1))

(windmove-default-keybindings)


;; https://emacs-china.org/t/topic/945/2
(defun my/split-window-below ()
  "Split window with another buffer."
  (interactive)
  (select-window (split-window-below))
  (switch-to-buffer (other-buffer)))

(defun my/split-window-right ()
  "Split window with another buffer."
  (interactive)
  (select-window (split-window-right))
  (switch-to-buffer (other-buffer)))


(provide 'init-interface)
