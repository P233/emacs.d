;;----------------------------------------------------------------------------
;; Window
;;----------------------------------------------------------------------------

;; https://emacs-china.org/t/topic/945/2
(defun my-split-window-below ()
  "Split window with another buffer."
  (interactive)
  (select-window (split-window-below))
  (switch-to-buffer (other-buffer)))

(defun my-split-window-right ()
  "Split window with another buffer."
  (interactive)
  (select-window (split-window-right))
  (switch-to-buffer (other-buffer)))

(global-set-key (kbd "C-x 2") 'my-split-window-below)
(global-set-key (kbd "C-x 3") 'my-split-window-right)


;; http://emacs.stackexchange.com/questions/3494/how-to-count-all-of-the-windows-in-a-frame
(defun count-unique-visible-buffers ()
  "Count how many buffers are currently being shown."
  (length (cl-delete-duplicates (mapcar #'window-buffer (window-list)))))

(defun my-switch-to-next-window ()
  "Switch to next window"
  (interactive)

  (defconst current-window-number (window-numbering-get-number))
  (defconst total-windows-number (count-unique-visible-buffers))

  (if (eq current-window-number total-windows-number)
   (select-window-by-number 1)
   (select-window-by-number (+ current-window-number 1))))

(defun my-switch-to-previous-window ()
  "Switch to previous window"
  (interactive)

  (defconst current-window-number (window-numbering-get-number))
  (defconst total-windows-number (count-unique-visible-buffers))

  (if (eq current-window-number 1)
   (select-window-by-number total-windows-number)
   (select-window-by-number (- current-window-number 1))))

(global-set-key (kbd "M-]") 'my-switch-to-next-window)
(global-set-key (kbd "M-[") 'my-switch-to-previous-window)


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
