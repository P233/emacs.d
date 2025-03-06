(use-package hydra)


(defvar my/common-hydra-docstring
  "
^Line^                    ^Region^
^----^--------------------^------^------------------
_c_: kill-ring-save       _C_: kill-ring-save
_d_: copy (duplicate)     _D_: copy (duplicate)
_k_: kill                 _K_: kill
_m_: move                 _M_: move
_e_: goto-end             ^ ^\n")

(defvar my/common-hydra-heads
  '(("c" avy-kill-ring-save-whole-line)
    ("d" avy-copy-line)
    ("k" avy-kill-whole-line)
    ("m" avy-move-line)
    ("e" avy-goto-end-of-line)
    ("C" avy-kill-ring-save-region)
    ("D" avy-copy-region)
    ("K" avy-kill-region)
    ("M" avy-move-region)
    ("w" whitespace-cleanup "whitespace-cleanup")
    ("q" nil "quit")))


(defvar my/treesit-hydra-docstring
  "
^Line^                    ^Region^                  ^Treesit Fold^
^----^--------------------^------^------------------^------------^-----
_c_: kill-ring-save       _C_: kill-ring-save       _]_: open-all
_d_: copy (duplicate)     _D_: copy (duplicate)     _[_: close-all
_k_: kill                 _K_: kill                 _t_: toggle
_m_: move                 _M_: move                 ^ ^
_e_: goto-end             ^ ^                       ^ ^\n")

(defvar my/treesit-hydra-heads
  '(("]" treesit-fold-open-all)
    ("[" treesit-fold-close-all)
    ("t" treesit-fold-toggle)))


(defun my/call-hydra ()
  (interactive)
  (let* ((treesit-enabled-p (bound-and-true-p treesit-fold-mode))
         (heads (append my/common-hydra-heads (when treesit-enabled-p my/treesit-hydra-heads)))
         (docstring (if treesit-enabled-p my/treesit-hydra-docstring my/common-hydra-docstring)))
    (eval `(defhydra my/dynamic-hydra (:color blue :idle 0.5 :foreign-keys warn :hint nil)
             ,docstring
             ,@heads))
    (my/dynamic-hydra/body)))


(global-set-key (kbd "C-t") 'my/call-hydra)


(provide 'init-hydra)
