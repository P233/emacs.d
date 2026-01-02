(use-package hydra)

(defhydra my/hydra (:color blue :idle 0.5 :foreign-keys warn :hint nil)
  "
^Line^                    ^Region^
^----^--------------------^------^------------------
_c_: kill-ring-save       _C_: kill-ring-save
_d_: copy (duplicate)     _D_: copy (duplicate)
_k_: kill                 _K_: kill
_m_: move                 _M_: move
_e_: goto-end             ^ ^
"
  ("c" avy-kill-ring-save-whole-line)
  ("d" avy-copy-line)
  ("k" avy-kill-whole-line)
  ("m" avy-move-line)
  ("e" avy-goto-end-of-line)
  ("C" avy-kill-ring-save-region)
  ("D" avy-copy-region)
  ("K" avy-kill-region)
  ("M" avy-move-region)
  ("w" whitespace-cleanup "whitespace-cleanup")
  ("q" nil "quit"))

(global-set-key (kbd "C-c C-t") 'my/hydra/body)


(provide 'init-hydra)
