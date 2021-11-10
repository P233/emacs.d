;; -*- lexical-binding: t; -*-
;; https://emacs-china.org/t/topic/945/2
(defun my/split-window-below ()
  "Split window with another buffer."
  (interactive)
  (select-window (split-window-below))
  (switch-to-buffer (other-buffer)))

(defun my/split-window-right ()
  "Split window with another buffer."
  (interactive)
  (select-window (split-window-right))
  (switch-to-buffer (other-buffer)))

;; http://emacsredux.com/blog/2013/04/28/switch-to-previous-buffer/
(defun my/switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; http://stackoverflow.com/questions/2173324/emacs-equivalents-of-vims-dd-o-o
(defun my/open-line-above ()
  "Insert a newline above the current line and put point at beginning."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

(defun my/open-line-below ()
  "Insert a newline below the current line and put point at beginning."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))

(defun my/backward-kill-line (arg)
  (interactive "p")
  (kill-line (- 1 arg)))

;; http://stackoverflow.com/questions/25188206/how-do-you-write-an-emacs-lisp-function-to-replace-a-word-at-point
(defun my/screaming-snake-case-word ()
  "Convert a camelCase word at point to SCREAMING_SNAKE_CASE."
  (interactive)
  (let* ((bounds
          (if (use-region-p)
              (cons (region-beginning) (region-end))
            (bounds-of-thing-at-point 'symbol)))
         (text (buffer-substring-no-properties (car bounds) (cdr bounds))))
    (when bounds
      (delete-region (car bounds) (cdr bounds))
      (insert (let ((case-fold-search nil))
                (upcase (replace-regexp-in-string "\\([A-Z]\\)" "_\\1" text t)))))))


(global-set-key (kbd "C-x 2") 'my/split-window-below)
(global-set-key (kbd "C-x 3") 'my/split-window-right)
(global-set-key (kbd "C-c b") 'my/switch-to-previous-buffer)
(global-set-key (kbd "<C-return>") 'my/open-line-above)
(global-set-key (kbd "M-RET") 'my/open-line-below)
(global-set-key (kbd "M-DEL") 'my/backward-kill-line)
(global-set-key (kbd "M-S") 'my/screaming-snake-case-word)


(provide 'init-my-functions)
