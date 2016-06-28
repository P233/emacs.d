(use-package markdown-mode
  :mode
  ("README\\.md\\'" . gfm-mode)
  ("\\.md\\'" . markdown-mode)
  :init
  (setq markdown-command "multimarkdown")
  :config
  ;; brew install aspell --with-lang-en
  (add-hook 'markdown-mode-hook 'turn-on-flyspell))


(use-package ghost-blog
  :init
  (setq ghost-blog-url ""
        ghost-blog-bearer-token ""))


(provide 'init-ghost)
