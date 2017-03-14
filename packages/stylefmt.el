;;; stylefmt.el --- Format CSS code with postcss-sorting and stylefmt

;; Author: Peiwen Lu <hi@peiwen.lu>
;; Version: 0.1
;; URL: https://github.com/P233/stylefmt.el

;;; Commentary:

;; Provides an interactive command `stylefmt' to sort CSS properties
;; with postcss-sorting and format code style with stylefmt
;; in current buffer.

;; Code are heavily borrowed from the following two packages:
;; - web-beautify.el (https://github.com/yasuyk/web-beautify)
;; - cssfmt.el (https://github.com/KeenS/cssfmt.el)

;;; Code:

(defconst stylefmt-sorting-program "postcss"
  "Executable to use for formatting CSS.")

(defvar stylefmt-sorting-config-file "~/.postcssrc.json"
  "Use ~/.postcssrc.json for default sorting config.")


(defun stylefmt-sorting-command-not-found-message ()
  "Construct a message about postcss-cli program not found."
  (message "postcss-cli is not found. Make sure postcss-cli, stylefmt, and postcss-sorting are all installed globally."))

(defun stylefmt-sorting-command-error-message (buffer-name)
  "Construct a message about postcss-cli program error with BUFFER-NAME."
  (format
   "Could not apply postcss-sorting. See %s to for details."
   buffer-name))


(defun stylefmt-sorting-get-config-arg ()
  "Construct the config arg with stylefmt-sorting-config-file."
  (if stylefmt-sorting-config-file (concat "-c " stylefmt-sorting-config-file) ""))

(defun stylefmt-sorting-get-shell-command ()
  "Construct the shell command for postcss-sorting."
  (mapconcat 'identity (list stylefmt-sorting-program
                             "-u postcss-sorting"
                             "-s postcss-scss"
                             (stylefmt-sorting-get-config-arg)) " "))


(defun stylefmt-sort-buffer ()
  "Sort CSS properties with postcss-sorting in current buffer."
  ;; Check that postcss-cli is installed.
  (interactive)
  (if (executable-find stylefmt-sorting-program)
      (let* ((output-buffer-name "*PostCSS Sorting*")
             (output-buffer (get-buffer-create output-buffer-name))
             ;; Stash the previous point/window positions so they can be
             ;; reclaimed after the buffer is replaced. Otherwise there is a
             ;; disturbing "jump" to vertically-center point after being
             ;; momentarily bounced to the top of the file.
             (previous-point (point))
             (previous-window-start (window-start))
             (shell-command (stylefmt-sorting-get-shell-command)))
        ;; Run the command.
        (if (zerop (shell-command-on-region (point-min) (point-max) shell-command (current-buffer) t output-buffer t))
            (progn
              ;; Reclaim position for a smooth transition.
              (goto-char previous-point)
              (set-window-start nil previous-window-start)
              (kill-buffer output-buffer)
              (save-buffer)
              (message "Applied postcss-sorting."))
          ;; Unfortunately an error causes the buffer to be replaced with
          ;; emptiness... so undo that. Kind of an ugly hack. But a
          ;; properly-configured web-beautify shouldn't encounter this much, if
          ;; ever.
          (undo)
          (message (stylefmt-sorting-command-error-message output-buffer-name))))
    (message (stylefmt-sorting-command-not-found-message))))


(defun stylefmt-format-buffer ()
  "Format code style with stylefmt in current buffer."
  (interactive)
  (save-excursion
    (call-process "stylefmt" nil nil nil (buffer-file-name (current-buffer)))
    (revert-buffer t t t)
    (save-buffer))
  (message "Applied stylefmt."))


;; (defun stylefmt-format-n-sort-buffer ()
;;   "Format, sort, and save current buffer."
;;   (interactive)
;;   (progn
;;     (stylefmt-format-buffer)
;;     (stylefmt-sort-buffer)))



(provide 'stylefmt)

;;; stylefmt.el ends here
