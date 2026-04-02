;; -*- lexical-binding: t; -*-
(column-number-mode t)
(electric-pair-mode t)
(global-subword-mode t)
(editorconfig-mode t)
(global-so-long-mode 1)
(add-hook 'prog-mode-hook #'hs-minor-mode)

(use-package wgrep
  :defer t)

(use-package move-text
  :config
  (move-text-default-bindings))

(use-package visual-regexp)

(use-package expreg)

(use-package aggressive-indent
  :hook ((emacs-lisp-mode . (lambda ()
                              (aggressive-indent-mode 1)
                              (electric-indent-local-mode -1)))))

(use-package avy
  :custom
  (avy-keys '(?o ?e ?u ?h ?l ?r ?p ?a ?s ?d ?f ?g ?j ?k ?c ?v ?b ?w ?q))
  (avy-styles-alist '((avy-goto-char . de-bruijn))))

(use-package open-newline
  :straight (:type git :host github :repo "manateelazycat/open-newline"))


;; http://stackoverflow.com/questions/25188206/how-do-you-write-an-emacs-lisp-function-to-replace-a-word-at-point
(defun my/screaming-snake-case-word ()
  "Convert the active region or symbol at point to SCREAMING_SNAKE_CASE."
  (interactive)
  (let ((bounds
         (if (use-region-p)
             (cons (region-beginning) (region-end))
           (bounds-of-thing-at-point 'symbol))))
    (when bounds
      (let ((case-fold-search nil)
            (text (buffer-substring-no-properties (car bounds) (cdr bounds))))
        ;; Already-uppercase names such as MD5SUM must remain unchanged.
        (unless (string= text (upcase text))
          ;; Split acronyms from following words, then lower-to-upper boundaries.
          (setq text (replace-regexp-in-string
                      "\\([A-Z]+\\)\\([A-Z][a-z]\\)" "\\1_\\2" text t))
          (setq text (replace-regexp-in-string
                      "\\([a-z0-9]\\)\\([A-Z]\\)" "\\1_\\2" text t)))
        (delete-region (car bounds) (cdr bounds))
        (insert (upcase text))))))

;; http://emacsredux.com/blog/2013/04/28/switch-to-previous-buffer/
(defun my/switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))


(provide 'init-editing)
