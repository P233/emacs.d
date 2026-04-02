;; -*- lexical-binding: t; -*-
(setq js-indent-level 2
      css-indent-offset 2)

(add-to-list 'auto-mode-alist '("\\.[cm]ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.[cm]js\\'" . js-ts-mode))

(use-package jsx-jedi
  :straight (:type git :host github :repo "p233/jsx-jedi"))

(use-package web-mode
  :defer t
  :mode
  ("\\.html\\'" "\\.astro\\'" "\\.svelte\\'")
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

(use-package markdown-mode
  :defer t
  :mode
  ("\\.mdx?\\'" . gfm-mode))


;; Jump to associated file
(defun my/open-or-create-associated-scss-file ()
  "Open or create the associated .module.scss file for the current .tsx or .jsx file."
  (interactive)
  (let* ((scss-file (concat (file-name-sans-extension buffer-file-name) ".module.scss"))
         (existing-buffer (find-buffer-visiting scss-file)))
    (find-file scss-file)
    ;; Create only a new target; leave an existing buffer's unsaved edits alone.
    (unless (or existing-buffer (file-exists-p scss-file))
      (save-buffer))))

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


(defun my/hex-color-with-opacity (hex opacity)
  "Convert HEX color to 8-digit hex with OPACITY percentage.
HEX can be with or without leading #.
OPACITY is a number between 0-100.
Result will be inserted at point surrounded by double quotes."
  (interactive
   (list (read-string "Hex color (with or without #): ")
         (read-number "Opacity percentage (0-100): ")))
  (let* ((hex (if (string-prefix-p "#" hex) hex (concat "#" hex)))
         (hex (if (= (length hex) 4)
                  (concat "#"
                          (char-to-string (aref hex 1))
                          (char-to-string (aref hex 1))
                          (char-to-string (aref hex 2))
                          (char-to-string (aref hex 2))
                          (char-to-string (aref hex 3))
                          (char-to-string (aref hex 3)))
                hex))
         (alpha-dec (round (* (/ opacity 100.0) 255)))
         (alpha-hex (format "%02x" alpha-dec))
         (result (concat "\"" hex alpha-hex "\"")))
    (insert result)
    (concat hex alpha-hex)))


(provide 'init-web)
