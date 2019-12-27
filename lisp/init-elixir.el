(use-package elixir-mode
  :hook
  (elixir-mode . (lambda ()
                   (add-hook 'before-save-hook 'elixir-format nil t))))


(use-package alchemist)



(provide 'init-elixir)
