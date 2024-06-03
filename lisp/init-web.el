;; -*- lexical-binding: t; -*-
(setq js-indent-level 2
      css-indent-offset 2)

(use-package deno-bridge
  :straight (:type git :host github :repo "manateelazycat/deno-bridge")
  :init
  (use-package websocket))

(use-package emmet2-mode
  :straight (:type git :host github :repo "p233/emmet2-mode" :files (:defaults "*.ts" "src" "data"))
  :after deno-bridge
  :hook
  ((css-mode tsx-ts-mode web-mode) . emmet2-mode))

(use-package jsx-jedi
  :straight (:type git :host github :repo "p233/jsx-jedi"))

(use-package web-mode
  :defer t
  :custom
  (web-mode-enable-auto-indentation nil)
  (web-mode-block-padding 0)
  (web-mode-css-indent-offset 2)
  (web-mode-markup-indent-offset 2)
  (web-mode-attr-indent-offset 2)
  (web-mode-attr-value-indent-offset 2)
  (web-mode-style-padding 2)
  (web-mode-script-padding 2)
  (web-mode-enable-current-element-highlight t)
  :custom-face
  (web-mode-html-tag-face ((t (:inherit font-lock-function-name-face :foreground unspecified))))
  (web-mode-html-attr-name-face ((t (:inherit font-lock-type-face :foreground unspecified))))
  (web-mode-current-element-highlight-face ((t (:background "#3f6faf")))))

(use-package prettier-js
  :hook
  ((css-mode js-ts-mode typescript-ts-mode tsx-ts-mode json-ts-mode web-mode) . prettier-js-mode))

(use-package restclient)


;; Jump to associated file
(defun my/open-or-create-associated-scss-file ()
  "Open or create the associated .module.scss file for the current .tsx or .jsx file."
  (interactive)
  (let* ((file-name (buffer-file-name))
         (file-dir (file-name-directory file-name))
         (file-base-name (file-name-base file-name))
         (scss-file (concat file-dir file-base-name ".module.scss")))
    (if (file-exists-p scss-file)
        (find-file scss-file)
      (let ((buffer (create-file-buffer scss-file)))
        (switch-to-buffer buffer)
        (write-file scss-file)))))

(defun my/open-associated-tsx-jsx-file ()
  "Open the associated .tsx or .jsx file for the current .scss file."
  (interactive)
  (let* ((file-name (buffer-file-name))
         (file-dir (file-name-directory file-name))
         (file-base-name (file-name-base file-name))
         (base-name (if (string-match "\\(.+\\)\\.module$" file-base-name)
                        (match-string 1 file-base-name)
                      file-base-name))
         (tsx-file (concat file-dir base-name ".tsx"))
         (jsx-file (concat file-dir base-name ".jsx")))
    (cond
     ((file-exists-p tsx-file)
      (find-file tsx-file))
     ((file-exists-p jsx-file)
      (find-file jsx-file))
     (t
      (message "No associated .tsx or .jsx file found.")))))

(add-hook 'tsx-ts-mode-hook (lambda ()
                              (define-key tsx-ts-mode-map (kbd "C-c C-s") 'my/open-or-create-associated-scss-file)))

(add-hook 'scss-mode-hook (lambda ()
                            (define-key scss-mode-map (kbd "C-c C-s") 'my/open-associated-tsx-jsx-file)))


(provide 'init-web)
