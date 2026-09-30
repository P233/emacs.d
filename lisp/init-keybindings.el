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
   "C-/" 'undo-only
   "C-=" 'undo-redo
   "C-<return>" 'open-newline-above
   "M-<return>" 'open-newline-below
   "M-S" 'my/screaming-snake-case-word

   ;; Search
   "<f1>" 'counsel-rg
   "<f2>" 'counsel-git

   ;; File tree
   "<f3>" 'treemacs-select-window

   ;; VSCode Integration
   "<f12>" 'my/open-in-vscode)

  ;; Mnemonic groups: b Buffers, c Code, f Files, p Project, / Search, w Windows.
  ;; Prefer clear mnemonics; use Dvorak home-row keys when equally meaningful.
  ;; Dvorak home row: a o e u i | d h t n s.
  ;; SPC in Normal/Visual; C-SPC also works in Insert/Emacs state.
  (general-create-definer my/leader-keys
    :states '(normal visual insert emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  ;; After a buffer/diagnostic navigation command, repeat with home-row keys.
  ;; Only Normal state enters this temporary map; Esc or any other key exits.
  ;; Other keys keep their usual action (for example, i starts inserting).
  (defvar-keymap my/buffer-navigation-map
    "t" #'next-buffer
    "n" #'previous-buffer
    "<escape>" #'evil-force-normal-state
    "ESC" #'evil-force-normal-state)

  (defvar-keymap my/diagnostic-navigation-map
    "t" #'flymake-goto-next-error
    "n" #'flymake-goto-prev-error
    "<escape>" #'evil-force-normal-state
    "ESC" #'evil-force-normal-state)

  (defun my/repeat-navigation (map hint)
    "Run the last key's command in MAP, then show HINT for Normal-state repeats."
    (let ((normal (evil-normal-state-p))
          (command (lookup-key map (vector last-command-event))))
      (unless (and (commandp command) (not (eq command 'evil-force-normal-state)))
        (user-error "Use a navigation key from its leader menu"))
      (call-interactively command)
      (when (and normal (evil-normal-state-p) (not (minibufferp)))
        (let* (exit
               ;; A repeated move can land in an Insert/Emacs-state buffer.
               ;; Exit before the next key is looked up, not in pre-command-hook.
               (check-state (lambda ()
                              (unless (and (evil-normal-state-p) (not (minibufferp)))
                                (funcall exit)))))
          (setq exit
                (set-transient-map
                 map
                 (lambda ()
                   (and this-command
                        (not (eq this-command 'evil-force-normal-state))
                        (eq this-command (lookup-key map (this-command-keys-vector)))))
                 (lambda () (remove-hook 'post-command-hook check-state))
                 hint))
          (add-hook 'post-command-hook check-state)))))

  (evil-define-command my/navigate-buffers ()
    "Move between buffers with t/n; repeat until Esc or another key."
    :repeat nil
    (interactive)
    (my/repeat-navigation my/buffer-navigation-map
                          "Buffers: t next, n previous; Esc exits"))

  (evil-define-command my/navigate-diagnostics ()
    "Move between diagnostics with t/n; repeat until Esc or another key."
    :repeat nil
    (interactive)
    (my/repeat-navigation my/diagnostic-navigation-map
                          "Diagnostics: t next, n previous; Esc exits"))

  (my/leader-keys
    "SPC"  '(counsel-M-x :which-key "M-x")
    ;; s = Save: frequent enough for a direct entry; also available under Files.
    "s"    '(save-buffer :which-key "Save file")
    "m"    '(magit-status :which-key "Magit status")

    ;; a = Avy / text actions.  M-]/M-[ expand/contract selection.
    ;; w = Word; i = In-line; e = End of line.
    ;; c/d/o = copy/delete/duplicate;
    ;; uppercase C/D/O/M applies to a region instead of a line.
    "a"   '(:ignore t :which-key "Avy / text actions")
    "a a" '(avy-goto-char-timer :which-key "Jump to characters")
    "a w" '(avy-goto-word-1 :which-key "Jump to word")
    "a i" '(avy-goto-char-in-line :which-key "Jump within line")
    "a e" '(avy-goto-end-of-line :which-key "Jump to line end")
    "a c" '(avy-kill-ring-save-whole-line :which-key "Copy line")
    "a d" '(avy-kill-whole-line :which-key "Delete line")
    "a o" '(avy-copy-line :which-key "Duplicate line")
    "a m" '(avy-move-line :which-key "Move line")
    "a C" '(avy-kill-ring-save-region :which-key "Copy region")
    "a D" '(avy-kill-region :which-key "Delete region")
    "a O" '(avy-copy-region :which-key "Duplicate region")
    "a M" '(avy-move-region :which-key "Move region")
    "a y" '(counsel-yank-pop :which-key "Yank / clipboard history")
    ;; r = Reorder: less frequent sorting actions share one submenu.
    "a r"   '(:ignore t :which-key "Reorder / sort")
    "a r l" '(sort-lines :which-key "Sort lines")
    "a r n" '(sort-numeric-fields :which-key "Sort numeric")
    "a r f" '(sort-fields :which-key "Sort fields")
    "a r r" '(reverse-region :which-key "Reverse region")
    "a r d" '(delete-duplicate-lines :which-key "Delete duplicates")

    ;; b = Buffers: selection, switching and closing all live here.
    ;; b = choose Buffer; a = All; d/D = close current/choose another to close.
    ;; t/n = next/previous, matching the diagnostic group.
    "b"   '(:ignore t :which-key "Buffers")
    "b b" '(ivy-switch-buffer :which-key "Choose buffer")
    "b a" '(ibuffer :which-key "All buffers / manage")
    "b d" '(kill-current-buffer :which-key "Close current buffer")
    "b D" '(kill-buffer :which-key "Choose buffer to close")
    "b t" '(my/navigate-buffers :which-key "Next buffer (repeat t/n)")
    "b n" '(my/navigate-buffers :which-key "Previous buffer (repeat t/n)")
    "b s" '(my/switch-to-previous-buffer :which-key "Switch to previous buffer")

    ;; c = Code: symbols, formatting and language-server actions.
    "c"   '(:ignore t :which-key "Code")
    "c d" '(xref-find-definitions :which-key "Find definition")
    "c r" '(xref-find-references :which-key "Find references")
    "c h" '(xref-go-back :which-key "Go back")
    "c s" '(xref-go-forward :which-key "Go forward")
    "c n" '(eglot-rename :which-key "Rename symbol")
    "c a" '(eglot-code-actions :which-key "Code actions")
    ;; i = Index (Imenu symbols); c = Columns (regexp alignment).
    ;; ; = Comment, matching the JSX Jedi menu.
    "c i" '(counsel-imenu :which-key "Index / symbols in file")
    "c c" '(align-regexp :which-key "Align columns (regexp)")
    "c f" '(my/format-buffer :which-key "Format buffer")
    "c ;" '(evilnc-comment-or-uncomment-lines :which-key "Comment lines")
    "c w" '(whitespace-cleanup :which-key "Whitespace cleanup")

    ;; d = Diagnostics; b/p = Buffer/Project scope.
    ;; t/n = next/previous, matching buffer navigation.
    "d"   '(:ignore t :which-key "Diagnostics")
    "d b" '(flymake-show-buffer-diagnostics :which-key "Buffer diagnostics")
    "d p" '(flymake-show-project-diagnostics :which-key "Project diagnostics")
    "d t" '(my/navigate-diagnostics :which-key "Next diagnostic (repeat t/n)")
    "d n" '(my/navigate-diagnostics :which-key "Previous diagnostic (repeat t/n)")

    ;; f = Files: open/save files, associated files, and the file tree.
    ;; s/S = save current/choose modified files to save.
    "f"   '(:ignore t :which-key "Files")
    "f f" '(counsel-find-file :which-key "Open file")
    "f r" '(counsel-recentf :which-key "Recent files")
    "f s" '(save-buffer :which-key "Save file")
    "f S" '(save-some-buffers :which-key "Save modified files")
    "f t" '(treemacs :which-key "Toggle file tree")

    ;; p = Project: switch projects, open their files, and search their text.
    "p"   '(:ignore t :which-key "Project")
    "p p" '(project-switch-project :which-key "Switch project")
    "p f" '(project-find-file :which-key "Project file")
    "p s" '(my/counsel-rg-at-point :which-key "Search project at point")

    ;; g = Git; SPC m remains a direct shortcut to status.
    "g"   '(:ignore t :which-key "Git")
    "g b" '(magit-blame :which-key "Blame")
    "g t" '(git-timemachine :which-key "Time machine")
    "g m" '(vc-msg-show :which-key "Show message")
    "g s" '(magit-status :which-key "Status")

    ;; h = Help.
    "h"   '(:ignore t :which-key "Help")
    "h f" '(counsel-describe-function :which-key "Describe function")
    "h k" '(describe-key :which-key "Describe key")
    "h v" '(counsel-describe-variable :which-key "Describe variable")
    "h m" '(describe-mode :which-key "Mode help")
    "h b" '(describe-bindings :which-key "Bindings in this buffer")

    ;; / = Search, as in Evil; keep s free for Save.  Project search is p s.
    "/"   '(:ignore t :which-key "Search / replace")
    "/ s" '(swiper-thing-at-point :which-key "Search buffer at point")
    "/ r" '(vr/replace :which-key "Visual replace")

    ;; w = Windows: layout actions; Shift+arrows navigate directly via Windmove.
    ;; r/b = place the new window to the Right/Below.
    "w"   '(:ignore t :which-key "Windows")
    "w r" '(my/split-window-right :which-key "Split right")
    "w b" '(my/split-window-below :which-key "Split below")
    "w d" '(delete-window :which-key "Close window")
    "w o" '(delete-other-windows :which-key "Keep only this window")
    ;; u/U = Undo/redo layout.
    "w u" '(winner-undo :which-key "Undo window layout")
    "w U" '(winner-redo :which-key "Redo window layout")
    "w =" '(balance-windows :which-key "Balance windows")

    ;; t = Toggle.
    "t"   '(:ignore t :which-key "Toggle")
    "t t" '(toggle-truncate-lines :which-key "Truncate lines")
    "t l" '(display-line-numbers-mode :which-key "Line numbers")
    "t f" '(hs-toggle-hiding :which-key "Fold / unfold code")
    "t r" '(rainbow-mode :which-key "Rainbow mode"))

  ;; Evil Normal State Bindings.  u already undoes by default.
  (general-define-key
   :states 'normal
   "s" 'avy-goto-char-2
   "U" 'evil-redo
   "/" 'swiper)

  ;; gc = Comment operator (gcc for a line, gc + motion, or a Visual selection).
  ;; Keep Evil's comma for reverse character search and Visual = for indentation.
  (general-define-key
   :states '(normal visual)
   "g c" 'evilnc-comment-operator)

  ;; JSX Jedi Bindings
  (defun my/jsx-jedi-empty-and-insert ()
    "Empty node content and enter Insert state in the same undo step."
    (interactive)
    (when (jsx-jedi-empty)
      (unless (eq evil-want-fine-undo t)
        (evil-start-undo-step t))
      (evil-insert 1)))

  (defun my/jsx-jedi-zap-and-insert ()
    "Zap to the content's end and enter Insert state in the same undo step."
    (interactive)
    (when (jsx-jedi-zap)
      (unless (eq evil-want-fine-undo t)
        (evil-start-undo-step t))
      (evil-insert 1)))

  (defun my/jsx-jedi-add-attribute-and-insert ()
    "Add a JSX attribute and edit its value in the same undo step."
    (interactive)
    (when (jsx-jedi-add-attribute)
      (unless (eq evil-want-fine-undo t)
        (evil-start-undo-step t))
      (evil-insert 1)))

  ;; e = Edit: structural JSX Jedi actions, only while its minor mode is active.
  ;; C-c e mirrors SPC e in Insert/Emacs state; C-SPC e remains available.
  ;; c/d/o = copy/delete/duplicate, matching Avy; h/n = opening/closing tag.
  ;; H = Hoist keeps the less frequent action off the unshifted home row.
  (my/leader-keys
   :keymaps 'jsx-jedi-mode-map
   :non-normal-prefix "C-c"
   "e"   '(:ignore t :which-key "Edit / JSX Jedi")
   "e d" '("Delete node" . jsx-jedi-kill)
   "e e" '("Empty and edit" . my/jsx-jedi-empty-and-insert)
   "e s" '("Substitute content" . jsx-jedi-substitute)
   "e z" '("Zap and edit" . my/jsx-jedi-zap-and-insert)
   "e c" '("Copy node" . jsx-jedi-copy)
   "e o" '("Duplicate node" . jsx-jedi-duplicate)
   "e m" '("Mark node" . jsx-jedi-mark)
   "e ;" '("Toggle node comment" . jsx-jedi-comment-uncomment)
   "e g" '("Jump within node" . jsx-jedi-avy-word)
   "e H" '("Hoist tag" . jsx-jedi-hoist-tag)
   "e u" '("Unwrap tag" . jsx-jedi-unwrap-tag)
   "e w" '("Wrap tag" . jsx-jedi-wrap-tag)
   "e h" '("Opening tag" . jsx-jedi-move-to-opening-tag)
   "e n" '("Closing tag" . jsx-jedi-move-to-closing-tag)
   "e r" '("Rename tag" . jsx-jedi-rename-tag)
   "e t" '("Toggle self-closing tag" . jsx-jedi-toggle-self-closing-tag)
   "e a" '("Add attribute and edit" . my/jsx-jedi-add-attribute-and-insert))

  ;; Package specific bindings
  ;; Option = Super on macOS.  t/n = next/previous on Dvorak's home row.
  ;; These bindings are local to completion menus; Meta history keys stay intact.
  (general-define-key
   :keymaps 'ivy-minibuffer-map
   "s-t" 'ivy-next-line
   "s-n" 'ivy-previous-line
   "TAB" 'ivy-partial
   "RET" 'ivy-alt-done)

  (general-define-key
   :keymaps 'corfu-map
   "s-t" 'corfu-next
   "s-n" 'corfu-previous)

  ;; In a help view, both Esc and the existing q dismiss the view.
  ;; Visual-state Esc still cancels the selection first.
  (general-define-key
   :states 'normal
   :keymaps 'help-mode-map
   "<escape>" 'quit-window)

  (general-define-key
   :keymaps 'dired-mode-map
   "RET" 'dired-find-alternate-file)

  (general-define-key
   :keymaps 'evil-emacs-state-map
   "<escape>" 'evil-exit-emacs-state)

  (general-define-key
   :keymaps 'treemacs-mode-map
   "<f3>" 'treemacs-select-window)

  ;; a = Associated file; only present in the relevant source/style modes.
  (my/leader-keys
   :keymaps '(js-ts-mode-map tsx-ts-mode-map typescript-ts-mode-map)
   "f a" '("Associated SCSS file" . my/open-or-create-associated-scss-file))

  (my/leader-keys
   :keymaps 'scss-mode-map
   "f a" '("Associated TSX / JSX file" . my/open-associated-tsx-jsx-file)))


(provide 'init-keybindings)
