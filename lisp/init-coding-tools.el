;; Enable subword-mode
(global-subword-mode t)


;; Hs mode
(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c h") 'hs-toggle-hiding)


;; Enable electric-pair-mode
(electric-pair-mode t)


;; Move Text mode
(use-package move-text
  :config
  (move-text-default-bindings))


;; Rainbow delimiters mode
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))


;; Company
(use-package company
  :custom
  (company-idle-delay 0)
  (company-echo-delay 0)
  (company-show-numbers t)
  (company-dabbrev-downcasbe nil)
  (company-selection-wrap-around t)
  (company-global-modes '(not org-mode))
  :config
  (global-company-mode)
  :bind
  (:map company-active-map ("C-n" . company-select-next))
  (:map company-active-map ("C-p" . company-select-previous)))

(use-package company-tabnine)

;; https://emacs-china.org/t/tabnine/9988/40
(defun company//sort-by-tabnine (candidates)
  (if (or (functionp company-backend)
          (not (and (listp company-backend) (memq 'company-tabnine company-backend))))
      candidates
    (let ((candidates-table (make-hash-table :test #'equal))
          candidates-1
          candidates-2)
      (dolist (candidate candidates)
        (if (eq (get-text-property 0 'company-backend candidate)
                'company-tabnine)
            (unless (gethash candidate candidates-table)
              (push candidate candidates-1))
          (push candidate candidates-2)
          (puthash candidate t candidates-table)))
      (setq candidates-1 (nreverse candidates-1))
      (setq candidates-2 (nreverse candidates-2))
      (nconc (seq-take candidates-1 2)
             (seq-take candidates-2 2)
             (seq-drop candidates-1 2)
             (seq-drop candidates-2 2)))))

(add-to-list 'company-transformers 'company//sort-by-tabnine t)


;; Jump to definition
(use-package dumb-jump
  :bind (("M-g g" . dumb-jump-go)
         ("M-g o" . dumb-jump-go-other-window)
         ("M-g b" . dumb-jump-back))
  :config (setq dumb-jump-selector 'ivy))


;; Goto last change
(use-package goto-last-change
  :bind (("C-`" . goto-last-change)))


;; Yasnippet
;; (use-package yasnippet
;;   :config
;;   (yas-global-mode t)
;;   (setq yas-snippet-dirs (expand-file-name "snippets" user-emacs-directory)))


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
  :custom
  (avy-keys '(?u ?h ?e ?t ?o ?n ?a ?s ?i ?d))
  :bind
  ("C-c '" . avy-goto-char)
  ("C-c l" . avy-goto-line))


;; Pinyin search
(use-package pinyin-search
  :bind
  ("C-c \"" . pinyin-search))



(provide 'init-coding-tools)
