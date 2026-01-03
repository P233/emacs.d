;; -*- lexical-binding: t; -*-
(use-package general
  :config
  (general-evil-setup)

  ;; Global Keybindings
  (general-define-key
   :keymaps 'global

   ;; Mouse
   "C-<wheel-up>" 'ignore
   "C-<wheel-down>" 'ignore
   "C-M-<wheel-up>" 'ignore
   "C-M-<wheel-down>" 'ignore

   ;; Editing
   "M-]" 'expreg-expand
   "M-[" 'expreg-contract
   "C-/" 'undo-fu-only-undo
   "C-=" 'undo-fu-only-redo
   "C-c p" 'counsel-yank-pop
   "C-<return>" 'open-newline-above
   "M-<return>" 'open-newline-below
   "M-S" 'my/screaming-snake-case-word

   ;; Search
   "<f1>" 'counsel-rg
   "<f2>" 'counsel-git

   ;; Window & Project
   "<f3>" 'treemacs-select-window
   "<f4>" 'project-switch-project

   ;; VSCode Integration
   "<f12>" 'my/open-in-vscode)

  ;; Leader Keybindings
  (general-create-definer my/leader-keys
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (my/leader-keys
    "SPC"  '(counsel-M-x :which-key "M-x")
    "/"    '(my/swiper-thing-at-point :which-key "Swiper at point")
    "?"    '(my/counsel-rg-at-point :which-key "Search in project at point")
    "TAB"  '(my/switch-to-previous-buffer :which-key "Switch to previous buffer")
    "<f3>" '(treemacs :which-key "Toggle file tree")

    ;; Avy Actions
    "a"   '(:ignore t :which-key "Avy Actions")
    "a c" '(avy-kill-ring-save-whole-line :which-key "Copy line")
    "a d" '(avy-copy-line :which-key "Duplicate line")
    "a k" '(avy-kill-whole-line :which-key "Kill line")
    "a m" '(avy-move-line :which-key "Move line")
    "a e" '(avy-goto-end-of-line :which-key "Goto end")
    "a C" '(avy-kill-ring-save-region :which-key "Copy region")
    "a D" '(avy-copy-region :which-key "Duplicate region")
    "a K" '(avy-kill-region :which-key "Kill region")
    "a M" '(avy-move-region :which-key "Move region")

    ;; Buffer
    "b"   '(:ignore t :which-key "Buffer")
    "b b" '(ivy-switch-buffer :which-key "Switch buffer")
    "b k" '(kill-buffer :which-key "Kill buffer")
    "b n" '(next-buffer :which-key "Next buffer")
    "b p" '(previous-buffer :which-key "Previous buffer")

    ;; Code / LSP
    "c"   '(:ignore t :which-key "Code")
    "c d" '(xref-find-definitions :which-key "Find definition")
    "c r" '(xref-find-references :which-key "Find references")
    "c n" '(eglot-rename :which-key "Rename symbol")
    "c a" '(eglot-code-actions :which-key "Code actions")
    "c l" '(evilnc-comment-or-uncomment-lines :which-key "Comment lines")
    "c w" '(whitespace-cleanup :which-key "Whitespace cleanup")

    ;; Error
    "e"   '(:ignore t :which-key "Error")
    "e n" '(flymake-goto-next-error :which-key "Next error")
    "e p" '(flymake-goto-prev-error :which-key "Prev error")

    ;; File
    "f"   '(:ignore t :which-key "File")
    "f f" '(counsel-find-file :which-key "Find file")
    "f r" '(counsel-recentf :which-key "Recent files")
    "f s" '(save-buffer :which-key "Save file")
    ";"   '(save-buffer :which-key "Save file")

    ;; Git
    "g"   '(:ignore t :which-key "Git")
    "g b" '(magit-blame :which-key "Blame")
    "g t" '(git-timemachine :which-key "Time machine")
    "g m" '(vc-msg-show :which-key "Show message")
    "g s" '(magit-status :which-key "Status")
    "v"   '(magit-status :which-key "Magit status")

    ;; Help
    "h"   '(:ignore t :which-key "Help")
    "h f" '(counsel-describe-function :which-key "Describe function")
    "h k" '(describe-key :which-key "Describe key")
    "h v" '(counsel-describe-variable :which-key "Describe variable")

    ;; Jump
    "j"   '(:ignore t :which-key "Jump")
    "j l" '(avy-goto-char-in-line :which-key "Char in line")
    "j e" '(avy-goto-end-of-line :which-key "End of line")
    "j w" '(avy-goto-word-1 :which-key "Word")
    "j c" '(avy-goto-char-timer :which-key "Char timer")

    ;; Replace
    "r" '(vr/replace :which-key "Visual replace")

    ;; Sort
    "s"   '(:ignore t :which-key "Sort")
    "s l" '(sort-lines :which-key "Sort lines")
    "s n" '(sort-numeric-fields :which-key "Sort numeric")
    "s f" '(sort-fields :which-key "Sort fields")
    "s r" '(reverse-region :which-key "Reverse region")
    "s d" '(delete-duplicate-lines :which-key "Delete duplicates")

    ;; Window
    "w"   '(:ignore t :which-key "Window")
    "w v" '(my/split-window-right :which-key "Split vertical")
    "w h" '(my/split-window-below :which-key "Split horizontal")
    "w d" '(delete-window :which-key "Delete window")
    "w o" '(delete-other-windows :which-key "Delete other")
    "w b" '(evil-window-left :which-key "Window left")
    "w n" '(evil-window-down :which-key "Window down")
    "w p" '(evil-window-up :which-key "Window up")
    "w f" '(evil-window-right :which-key "Window right")
    "w =" '(balance-windows :which-key "Balance windows")

    ;; Toggle
    "t"   '(:ignore t :which-key "Toggle")
    "t t" '(toggle-truncate-lines :which-key "Truncate lines")
    "t l" '(display-line-numbers-mode :which-key "Line numbers")
    "t r" '(rainbow-mode :which-key "Rainbow mode"))

  ;; Evil Normal State Bindings
  (general-define-key
   :states 'normal
   "s" 'avy-goto-char-2
   "u" 'undo-fu-only-undo
   "U" 'undo-fu-only-redo
   "/" 'swiper)

  ;; Evil Visual State Bindings
  (general-define-key
   :states 'visual
   "=" 'align-regexp)

  ;; JSX Jedi Bindings
  (general-define-key
   :states 'normal
   :keymaps 'jsx-jedi-mode-map
   "," '(:ignore t :which-key "JSX Jedi")
   ", k" 'jsx-jedi-kill
   ", e" (lambda () (interactive) (when (jsx-jedi-empty) (evil-insert-state)))
   ", s" 'jsx-jedi-substitute
   ", z" (lambda () (interactive) (when (jsx-jedi-zap) (evil-insert-state)))
   ", y" 'jsx-jedi-copy
   ", d" 'jsx-jedi-duplicate
   ", m" 'jsx-jedi-mark
   ", ;" 'jsx-jedi-comment-uncomment
   ", j" 'jsx-jedi-avy-word
   ", h" 'jsx-jedi-hoist-tag
   ", u" 'jsx-jedi-unwrap-tag
   ", w" 'jsx-jedi-wrap-tag
   ", [" 'jsx-jedi-move-to-opening-tag
   ", ]" 'jsx-jedi-move-to-closing-tag
   ", r" 'jsx-jedi-rename-tag
   ", t" 'jsx-jedi-toggle-self-closing-tag
   ", a" (lambda () (interactive) (when (jsx-jedi-add-attribute) (evil-insert-state)))
   "\\" 'evil-repeat-find-char-reverse)

  ;; Package specific bindings
  (general-define-key
   :keymaps 'ivy-minibuffer-map
   "TAB" 'ivy-partial
   "RET" 'ivy-alt-done)

  (general-define-key
   :keymaps 'copilot-mode-map
   "C-e" 'my/copilot-complete
   "C-S-e" 'my/select-current-line)

  (general-define-key
   :keymaps 'dired-mode-map
   "RET" 'dired-find-alternate-file)

  (general-define-key
   :keymaps 'evil-emacs-state-map
   "<escape>" 'evil-exit-emacs-state)

  (general-define-key
   :keymaps 'treemacs-mode-map
   "<f3>" 'treemacs-select-window)

  (general-define-key
   :keymaps '(js-ts-mode-map tsx-ts-mode-map typescript-ts-mode-map)
   "C-c C-o" 'my/open-or-create-associated-scss-file)

  (general-define-key
   :keymaps 'scss-mode-map
   "C-c C-o" 'my/open-associated-tsx-jsx-file))


(provide 'init-keybindings)
