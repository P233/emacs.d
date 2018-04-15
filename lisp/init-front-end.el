;;----------------------------------------------------------------------------
;; Markup
;;----------------------------------------------------------------------------

;; Web mode
(use-package web-mode
  :mode
  ("\\.html\\'" . web-mode)
  ("\\.js[x]?\\'" . web-mode)
  :init
  (setq web-mode-script-padding global-indentation-size
        web-mode-style-padding global-indentation-size
        web-mode-block-padding global-indentation-size
        web-mode-attr-indent-offset global-indentation-size
        web-mode-attr-value-indent-offset global-indentation-size
        web-mode-enable-current-element-highlight t
        web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))))


;; Markdown mode
(use-package markdown-mode
  :mode
  ("README\\.md\\'" . gfm-mode)
  ("\\.md\\'" . markdown-mode)
  :init
  (setq markdown-command "multimarkdown")
  :config
  (add-hook 'markdown-mode-hook 'turn-on-flyspell))


;; YAML mode
(use-package yaml-mode)


;; Emmet mode
(setq emmet-move-cursor-between-quotes t
      emmet-insert-flash-time 0.1)
(add-hook 'emmet-mode-hook
          (lambda ()
            (define-key emmet-mode-keymap (kbd "<C-return>") nil)))


;;----------------------------------------------------------------------------
;; SCSS
;;----------------------------------------------------------------------------

(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

(setq css-indent-offset global-indentation-size)

(use-package rainbow-mode)

(use-package postcss-sorting)

(add-hook 'css-mode-hook
          (lambda ()
            (setq-local company-backends '(company-files (company-css :with company-dabbrev company-dabbrev-code)))
            (local-set-key (kbd "C-x C-s") 'postcss-sorting-buffer)
            (rainbow-mode)
            (emmet-mode)))


;;----------------------------------------------------------------------------
;; JavaScript
;;----------------------------------------------------------------------------

(defun my-js-minor-modes ()
  "Shared minor modes for both js2-mode and web-mode (JSX)."
  ;; (flycheck-select-checker 'javascript-eslint)
  ;; (flycheck-mode)
  (prettier-js-mode)
  (tern-mode))


;; JS2 mode
(use-package js2-mode)


;; Tern mode
(use-package tern
  :init
  (setq tern-command '("tern" "--no-port-file")))

(use-package company-tern
  :config
  (add-to-list 'company-backends 'company-tern))


;; Prettier mode
(use-package prettier-js
  :init
  (setq prettier-js-args '(
                           "--print-width" "100"
                           "--trailing-comma" "all"
                           "--single-quote" "true")))


;; JSON mode
(use-package json-mode
  :init
  (setq js-indent-level global-indentation-size))


;; Add support for JSX
(add-hook 'web-mode-hook
          (lambda ()
            (emmet-mode)
            (when (equal web-mode-content-type "jsx")
              (setq-local emmet-expand-jsx-className? t)
              (setq-local web-mode-enable-auto-quoting nil)
              (my-js-minor-modes))))


;;----------------------------------------------------------------------------
;; end
;;----------------------------------------------------------------------------

(provide 'init-front-end)
