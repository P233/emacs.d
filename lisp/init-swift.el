;; -*- lexical-binding: t; -*-
(use-package swift-mode
  :defer t
  :custom
  (swift-mode:basic-offset my/indentation-size))

(use-package swift-format
  :straight (:type git :host github :repo "p233/swift-format.el")
  :after swift-mode
  :hook
  (swift-mode . (lambda ()
                  (add-hook 'before-save-hook 'swift-format-buffer nil t))))


(provide 'init-swift)
