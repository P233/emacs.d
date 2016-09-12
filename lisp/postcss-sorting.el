;;; postcss-sorting.el --- Format CSS with postcss-sorting and stylefmt

;; Author: Peiwen Lu <hi@peiwen.lu>
;; Version: 0.1
;; URL: https://github.com/P233/emacs-postcss-sorting

;;; Commentary:

;; Code are heavily borrowed from the following two packages:
;; - web-beautify.el (https://github.com/yasuyk/web-beautify)
;; - cssfmt.el (https://github.com/KeenS/cssfmt.el)

;;; Code:

(defconst postcss-sorting-program "postcss"
  "Executable to use for formatting CSS.")

(defvar postcss-sorting-config-file "~/.postcssrc.json"
  "Use ~/.postcssrc.json for default sorting config.")

(defvar postcss-sorting-syntax-plugin "postcss-scss"
  "Use postcss-scss plugin for default syntax.")


(defun postcss-sorting-command-not-found-message ()
  "Construct a message about postcss program not found."
  (format
   "postcss-cli is not found. Make sure postcss-cli, stylefmt, postcss-sorting%s are all installed globally by npm."
   (if postcss-sorting-syntax-plugin (format ", and %s" postcss-sorting-syntax-plugin) "")))

(defun postcss-sorting-format-error-message (buffer-name)
  "Construct a format error message with BUFFER-NAME."
  (format
   "Could not apply postcss-sorting. See %s to for details."
   buffer-name))


(defun postcss-sorting-get-config-arg ()
  "Construct the config arg with postcss-sorting-config-file."
  (if postcss-sorting-config-file (concat "-c " postcss-sorting-config-file) ""))

(defun postcss-sorting-get-syntax-arg ()
  "Construct the syntax arg with postcss-sorting-syntax-plugin."
  (if postcss-sorting-syntax-plugin (concat "-s " postcss-sorting-syntax-plugin) ""))

(defun postcss-sorting-get-shell-command ()
  "Construct the shell command for postcss-sorting."
  (mapconcat 'identity (list postcss-sorting-program
                             "-u postcss-sorting"
                             (postcss-sorting-get-config-arg)
                             (postcss-sorting-get-syntax-arg)) " "))


(defun postcss-sorting-sort-region (beginning end)
  "Sort CSS properties in BEGINNING .. END region."
  ;; Check that postcss-cli is installed.
  (if (executable-find postcss-sorting-program)
      (let* ((output-buffer-name "*PostCSS Sorting*")
             (output-buffer (get-buffer-create output-buffer-name))
             ;; Stash the previous point/window positions so they can be
             ;; reclaimed after the buffer is replaced. Otherwise there is a
             ;; disturbing "jump" to vertically-center point after being
             ;; momentarily bounced to the top of the file.
             (previous-point (point))
             (previous-window-start (window-start))
             (shell-command (postcss-sorting-get-shell-command)))
        ;; Run the command.
        (if (zerop (shell-command-on-region beginning end shell-command (current-buffer) t output-buffer t))
            (progn
              ;; Reclaim position for a smooth transition.
              (goto-char previous-point)
              (set-window-start nil previous-window-start)
              (message "Applied postcss-sorting.")
              (kill-buffer output-buffer))
          ;; Unfortunately an error causes the buffer to be replaced with
          ;; emptiness... so undo that. Kind of an ugly hack. But a
          ;; properly-configured web-beautify shouldn't encounter this much, if
          ;; ever.
          (undo)
          (message (postcss-sorting-format-error-message output-buffer-name))))
    (message (postcss-sorting-command-not-found-message))))

(defun postcss-sorting-sort-buffer ()
  "Sort CSS properties in current buffer."
  (postcss-sorting-sort-region (point-min) (point-max)))


(defun postcss-sorting-stylefmt-buffer ()
  "Format code styles in current buffer with stylefmt."
  (save-excursion
    (call-process "stylefmt" nil nil nil (buffer-file-name (current-buffer)))
    (revert-buffer t t t)))


(defun postcss-sorting ()
  "Sort region if active, otherwise sort and format current buffer."
  (interactive)
  (if (use-region-p)
      (postcss-sorting-sort-region (region-beginning) (region-end))
    (progn
      (postcss-sorting-sort-buffer)
      (postcss-sorting-stylefmt-buffer))))



(provide 'postcss-sorting)

;;; postcss-sorting.el ends here
