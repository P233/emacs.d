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


;; JSX helper functions
(defun jsx/kill-region-and-goto-start (start end)
  "Kill the region between START and END, and move the point to START."
  (kill-region start end)
  (goto-char start))

(defun jsx/find-comment-block-bounds (node)
  "Get the bounds of the comment block containing NODE.
Return a cons cell (START . END) representing the bounds."
  (let ((start-node node)
        (end-node node))
    (while (string= (treesit-node-type (treesit-node-prev-sibling start-node)) "comment")
      (setq start-node (treesit-node-prev-sibling start-node)))
    (while (and end-node (string= (treesit-node-type (treesit-node-next-sibling end-node)) "comment"))
      (setq end-node (treesit-node-next-sibling end-node)))
    (cons (treesit-node-start start-node) (treesit-node-end end-node))))

(defun jsx/kill-by-node-type ()
  "[Experimental] Kill the node or region based on the node type at point."
  (interactive)
  (let* ((node (treesit-node-at (point)))
         (node-text (treesit-node-text node t)))
    (pcase node-text
      ((or "." ":" ";" "<" "</" ">" "(" ")" "[" "]" "{" "}")
       (call-interactively 'backward-kill-word))
      ((or "'" "\"" "`")
       (let* ((parent-node (treesit-node-parent node))
              (start (1+ (treesit-node-start parent-node)))
              (end (1- (treesit-node-end parent-node))))
         (jsx/kill-region-and-goto-start start end)))
      (","
       (when-let* ((prev-node (treesit-node-prev-sibling node))
                   (start (treesit-node-start prev-node))
                   (end (treesit-node-end node))
                   (space-prefix (string= (buffer-substring-no-properties (1- start) start) " ")))
         (jsx/kill-region-and-goto-start (if space-prefix (1- start) start) end)))
      (_ (kill-region (treesit-node-start node) (treesit-node-end node))))))

(defun jsx/kill-block ()
  "Kill the JSX element, import, expression, function, or variable declaration containing the point."
  (interactive)
  (let* ((node (treesit-node-at (point)))
         (parent (treesit-parent-until node (lambda (n)
                                              (member (treesit-node-type n)
                                                      '("import_statement"
                                                        "expression_statement"
                                                        "function_declaration"
                                                        "lexical_declaration"
                                                        "type_alias_declaration"
                                                        "jsx_element"
                                                        "jsx_self_closing_element")))))
         (start (treesit-node-start parent))
         (end (treesit-node-end parent)))
    (kill-region start end)
    (delete-blank-lines)
    (indent-for-tab-command)))

(defun jsx/copy-block ()
  "Copy the import, expression, function, or variable declaration containing the point."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (parent (treesit-parent-until node (lambda (n)
                                                   (member (treesit-node-type n)
                                                           '("import_statement"
                                                             "expression_statement"
                                                             "function_declaration"
                                                             "lexical_declaration"
                                                             "type_alias_declaration"
                                                             "jsx_element"
                                                             "jsx_self_closing_element")))))
              (start (treesit-node-start parent))
              (end (treesit-node-end parent)))
    (kill-ring-save start end)
    (pulse-momentary-highlight-region start end)))

(defun jsx/duplicate-block ()
  "Duplicate the JSX element (self-closing or normal), function, or variable declaration containing the point."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (element (treesit-parent-until node (lambda (n)
                                                    (member (treesit-node-type n)
                                                            '("function_declaration"
                                                              "lexical_declaration"
                                                              "jsx_element"
                                                              "jsx_self_closing_element")))))
              (element-text (treesit-node-text element t))
              (end (treesit-node-end element)))
    (goto-char end)
    (newline)
    (insert element-text)
    (indent-region end (point))))

(defun jsx/select-block ()
  "Select the JSX element, import, expression, function, or variable declaration containing the point."
  (interactive)
  (let ((node (treesit-node-at (point))))
    (if (string= (treesit-node-type node) "comment")
        (when-let* ((bounds (jsx/find-comment-block-bounds node))
                    (start (car bounds))
                    (end (cdr bounds)))
          (goto-char start)
          (set-mark end)
          (activate-mark))
      (when-let* ((parent (treesit-parent-until node (lambda (n)
                                                       (member (treesit-node-type n)
                                                               '("import_statement"
                                                                 "expression_statement"
                                                                 "function_declaration"
                                                                 "lexical_declaration"
                                                                 "type_alias_declaration"
                                                                 "jsx_element"
                                                                 "jsx_self_closing_element")))))
                  (start (treesit-node-start parent))
                  (end (treesit-node-end parent)))
        (goto-char start)
        (set-mark end)
        (activate-mark)))))

(defun jsx/comment-uncomment-block ()
  "[Experimental] Comment or uncomment the JSX element, import, expression, function, or variable declaration containing the point."
  (interactive)
  (let* ((node (treesit-node-at (point)))
         (is-node-comment (string= (treesit-node-type node) "comment"))
         (is-parent-jsx-expression (string= (treesit-node-type (treesit-node-parent node)) "jsx_expression"))
         (is-normal-comment (and is-node-comment
                                 (not is-parent-jsx-expression)))
         (is-jsx-comment (and is-parent-jsx-expression
                              (or is-node-comment
                                  (string= (treesit-node-type (treesit-node-prev-sibling node)) "comment")
                                  (string= (treesit-node-type (treesit-node-next-sibling node)) "comment")))))
    (cond
     (is-normal-comment
      (let* ((bounds (jsx/find-comment-block-bounds node))
             (start (car bounds))
             (end (cdr bounds)))
        (uncomment-region start end)))
     (is-jsx-comment
      (let* ((comment (treesit-parent-until node (lambda (n)
                                                   (string= (treesit-node-type n) "jsx_expression")) t))
             (comment-text (treesit-node-text comment t))
             (uncomment-text (replace-regexp-in-string "{/\\*[[:space:]]*" "" (replace-regexp-in-string "[[:space:]]*\\*/}" "" comment-text)))
             (start (treesit-node-start comment))
             (end (treesit-node-end comment)))
        (delete-region start end)
        (insert uncomment-text)
        (goto-char start)))
     ((not (or is-normal-comment is-jsx-comment))
      (when-let* ((parent (treesit-parent-until node (lambda (n)
                                                       (member (treesit-node-type n)
                                                               '("import_statement"
                                                                 "expression_statement"
                                                                 "function_declaration"
                                                                 "lexical_declaration"
                                                                 "type_alias_declaration"
                                                                 "jsx_element"
                                                                 "jsx_self_closing_element")))))
                  (start (treesit-node-start parent))
                  (end (treesit-node-end parent)))
        (if (member (treesit-node-type parent) '("jsx_element" "jsx_self_closing_element"))
            (let ((comment-text (concat "{/* " (treesit-node-text parent t) " */}"))
                  (start (treesit-node-start parent))
                  (end (treesit-node-end parent)))
              (kill-region start end)
              (insert comment-text))
          (comment-region start end)))))))

(defun jsx/delete-until ()
  "Delete up to the end of the parent closing."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (parent (treesit-parent-until node (lambda (n)
                                                   (member (treesit-node-type n)
                                                           '("array"
                                                             "array_pattern"
                                                             "string"
                                                             "arguments"
                                                             "named_imports"
                                                             "object_pattern"
                                                             "formal_parameters"
                                                             "jsx_expression"
                                                             "jsx_opening_element")))))
              (end (1- (treesit-node-end parent))))
    (delete-region (point) end)))

(defun jsx/empty-element-or-brackets ()
  "Empty the content of the JSX element containing the point."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (element (treesit-parent-until node (lambda (n)
                                                    (let ((node-type (treesit-node-type n)))
                                                      (if (string= node-type "jsx_expression")
                                                          (not (treesit-parent-until n (lambda (m)
                                                                                         (string= (treesit-node-type m) "jsx_attribute"))))
                                                        (member node-type
                                                                '("jsx_element"
                                                                  "array"
                                                                  "array_pattern"
                                                                  "arguments"
                                                                  "named_imports"
                                                                  "object_pattern"
                                                                  "formal_parameters")))))))
              (opening-node (treesit-node-child element 0))
              (closing-node (treesit-node-child element -1))
              (start (treesit-node-end opening-node))
              (end (treesit-node-start closing-node)))
    (jsx/kill-region-and-goto-start start end)))

(defun jsx/raise-element ()
  "Raise the JSX element containing the point."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (element (treesit-parent-until node (lambda (n)
                                                    (member (treesit-node-type n)
                                                            '("jsx_element"
                                                              "jsx_self_closing_element"
                                                              "jsx_expression")))))
              (element-text (treesit-node-text element t))
              (element-parent (treesit-parent-until element (lambda (n)
                                                              (string= (treesit-node-type n) "jsx_element"))))
              (start (treesit-node-start element-parent))
              (end (treesit-node-end element-parent)))
    (delete-region start end)
    (insert element-text)
    (indent-region start (point))))

(defun jsx/move-to-opening-tag ()
  "Move the point to the opening tag of the JSX element containing the point."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (element (treesit-parent-until node (lambda (n)
                                                    (string= (treesit-node-type n) "jsx_element"))))
              (opening-node (treesit-node-child element 0))
              (position (1- (treesit-node-end opening-node))))
    (goto-char position)))

(defun jsx/move-to-closing-tag ()
  "Move the point to the closing tag of the JSX element containing the point."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (element (treesit-parent-until node (lambda (n)
                                                    (string= (treesit-node-type n) "jsx_element"))))
              (closing-node (treesit-node-child element -1))
              (position (+ 2 (treesit-node-start closing-node))))
    (goto-char position)))

(defun jsx/kill-attribute ()
  "Kill the JSX attribute containing the point."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (attribute (treesit-parent-until node (lambda (n)
                                                      (string= (treesit-node-type n) "jsx_attribute"))))
              (start (treesit-node-start attribute))
              (end (treesit-node-end attribute)))
    (if (string= (buffer-substring-no-properties (1- start) start) " ")
        (kill-region (1- start) end)
      (kill-region start end))))

(defun jsx/copy-attribute ()
  "Copy the JSX attribute containing the point."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (attribute (treesit-parent-until node (lambda (n)
                                                      (string= (treesit-node-type n) "jsx_attribute"))))
              (start (treesit-node-start attribute))
              (end (treesit-node-end attribute)))
    (kill-ring-save start end)
    (pulse-momentary-highlight-region start end)))

(defun jsx/kill-attribute-value ()
  "Kill the value of the JSX attribute containing the point."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (attribute (treesit-parent-until node (lambda (n)
                                                      (string= (treesit-node-type n) "jsx_attribute"))))
              (value (treesit-node-child attribute -1)))
    (let ((start (1+ (treesit-node-start value)))
          (end (1- (treesit-node-end value))))
      (jsx/kill-region-and-goto-start start end))))

(defun jsx/move-to-prev-attribute ()
  "Move the point to the previous JSX attribute."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (element (if (member (treesit-node-text node t) '(">" "/>"))
                           node
                         (treesit-parent-until node (lambda (n)
                                                      (string= (treesit-node-type n) "jsx_attribute")))))
              (prev-element (treesit-node-prev-sibling element))
              (is-attribute (string= (treesit-node-type prev-element) "jsx_attribute")))
    (goto-char (treesit-node-start prev-element))))

(defun jsx/move-to-next-attribute ()
  "Move the point to the next JSX attribute."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (element (if (string= (treesit-node-type node) "identifier")
                           node
                         (treesit-parent-until node (lambda (n)
                                                      (string= (treesit-node-type n) "jsx_attribute")))))
              (next-element (treesit-node-next-sibling element))
              (is-attribute (string= (treesit-node-type next-element) "jsx_attribute")))
    (goto-char (treesit-node-start next-element))))

(defun jsx/declaration-to-if-statement ()
  "Convert the variable declaration at point to an if statement."
  (interactive)
  (when-let* ((node (treesit-node-at (point)))
              (parent (treesit-parent-until node (lambda (n)
                                                   (string= (treesit-node-type n) "lexical_declaration"))))
              (value (treesit-search-subtree parent (lambda (n)
                                                      (string= (treesit-node-type n) "call_expression"))))
              (value-text (treesit-node-text value t))
              (start (treesit-node-start parent))
              (end (treesit-node-end parent)))
    (delete-region start end)
    (insert (format "if (%s) {\n\n}" value-text))
    (indent-region start (point))
    (forward-line -1)
    (indent-for-tab-command)))

;; Keybindings
(add-hook 'tsx-ts-mode-hook (lambda ()
                              (define-key tsx-ts-mode-map (kbd "C-<backspace>") 'jsx/kill-by-node-type)
                              (define-key tsx-ts-mode-map (kbd "C-c C-k") 'jsx/kill-block)
                              (define-key tsx-ts-mode-map (kbd "C-c C-w") 'jsx/copy-block)
                              (define-key tsx-ts-mode-map (kbd "C-c C-x") 'jsx/duplicate-block)
                              (define-key tsx-ts-mode-map (kbd "C-c C-SPC") 'jsx/select-block)
                              (define-key tsx-ts-mode-map (kbd "C-c C-u") 'jsx/delete-until)
                              (define-key tsx-ts-mode-map (kbd "C-c C-e") 'jsx/empty-element-or-brackets)
                              (define-key tsx-ts-mode-map (kbd "C-c C-;") 'jsx/comment-uncomment-block)
                              (define-key tsx-ts-mode-map (kbd "C-c C-t C-r") 'jsx/raise-element)
                              (define-key tsx-ts-mode-map (kbd "C-c C-t C-p") 'jsx/move-to-opening-tag)
                              (define-key tsx-ts-mode-map (kbd "C-c C-t C-n") 'jsx/move-to-closing-tag)
                              (define-key tsx-ts-mode-map (kbd "C-c C-a C-k") 'jsx/kill-attribute)
                              (define-key tsx-ts-mode-map (kbd "C-c C-a C-w") 'jsx/copy-attribute)
                              (define-key tsx-ts-mode-map (kbd "C-c C-a C-v") 'jsx/kill-attribute-value)
                              (define-key tsx-ts-mode-map (kbd "C-c C-a C-p") 'jsx/move-to-prev-attribute)
                              (define-key tsx-ts-mode-map (kbd "C-c C-a C-n") 'jsx/move-to-next-attribute)
                              (define-key tsx-ts-mode-map (kbd "C-c C-s") 'my/open-or-create-associated-scss-file)))

(add-hook 'scss-mode-hook (lambda ()
                            (define-key scss-mode-map (kbd "C-c C-s") 'my/open-associated-tsx-jsx-file)))


(provide 'init-web)
