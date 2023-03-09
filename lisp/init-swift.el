;; -*- lexical-binding: t; -*-
(use-package swift-mode
  :defer t
  :custom
  (swift-mode:basic-offset my/indentation-size))

(use-package swift-format
  :load-path "submodules/swift-format"
  :after swift-mode
  :hook
  (swift-mode . (lambda ()
                  (add-hook 'before-save-hook 'swift-format-buffer nil t))))


(provide 'init-swift)
