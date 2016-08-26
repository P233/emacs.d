;;----------------------------------------------------------------------------
;; Buffer
;;----------------------------------------------------------------------------

;; Switch to preivous buffer
;; http://emacsredux.com/blog/2013/04/28/switch-to-previous-buffer/
(defun my-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(global-set-key (kbd "C-c b") 'my-switch-to-previous-buffer)


;;----------------------------------------------------------------------------
;; Editing
;;----------------------------------------------------------------------------

;; VI open line
;; http://stackoverflow.com/questions/2173324/emacs-equivalents-of-vims-dd-o-o
(defun my-open-line-above ()
  "Insert a newline above the current line and put point at beginning."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

(defun my-open-line-below ()
  "Insert a newline below the current line and put point at beginning."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))

(global-set-key (kbd "<C-return>")  'my-open-line-above)
(global-set-key (kbd "M-RET")       'my-open-line-below)


;; Backward kill line
(defun my-backward-kill-line (arg)
  (interactive "p")
  (kill-line (- 1 arg)))
(global-set-key (kbd "M-DEL") 'my-backward-kill-line)



(provide 'init-my-functions)
