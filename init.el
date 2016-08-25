;; (package-initialize)

;; Load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-use-package)


;; Emacs Settings
(require 'init-osx)
(require 'init-interface)
(require 'init-settings)
(require 'init-code-styles)


;; Install Pagkaces
(require 'init-packages)


;; Language Settings
(require 'init-markup)
(require 'init-css)
(require 'init-javascript)
(require 'init-elixir)

(require 'init-org)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rainbow-mode browse-kill-ring multi-web-mode evil-surround evil-nerd-commenter evil-leader web-beautify ggtags alchemist pinyin-search elixir-mode osx-dictionary company-quickhelp company-tern tern markdown-mode json-mode js2-mode yaml-mode emmet-mode web-mode buffer-move window-numbering neotree avy smex flycheck evil-magit git-gutter magit evil yasnippet company counsel nyan-mode linum-relative birds-of-paradise-plus-theme exec-path-from-shell use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(provide 'init)
