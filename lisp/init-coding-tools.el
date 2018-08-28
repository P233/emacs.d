;; Hs mode
(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c h") 'hs-toggle-hiding)


;; Enable electric-pair-mode
(electric-pair-mode t)


;; Rainbow delimiters mode
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))


;; Company
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
  :bind
  (:map company-active-map ("C-n" . company-select-next))
  (:map company-active-map ("C-p" . company-select-previous)))


;; Yasnippet
(use-package yasnippet
  :config
  (yas-global-mode t)
  (setq yas-snippet-dirs (expand-file-name "snippets" user-emacs-directory)))


;; Expand region mode
(use-package expand-region
  :bind
  ("C-'" . er/expand-region)
  ("C-=" . er/contract-region))


;; Custome copy and cut key bindings
(global-set-key (kbd "C-,") 'kill-ring-save)
(global-set-key (kbd "C-.") 'kill-region)


;; Visual regexp replace
(use-package visual-regexp
  :bind
  ("C-c r" . vr/replace)
  ("C-c q" . vr/query-replace))


;; Popup kill ring
(use-package popup-kill-ring
  :bind
  ("C-c p" . popup-kill-ring))


;; Avy mode
(use-package avy
  :init
  (setq avy-keys '(?u ?h ?e ?t ?o ?n ?a ?s ?i ?d))
  :bind
  ("C-c '" . avy-goto-char)
  ("C-c l" . avy-goto-line))


;; Pinyin search
(use-package pinyin-search
  :bind
  ("C-c \"" . pinyin-search))



(provide 'init-coding-tools)
