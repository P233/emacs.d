;;; postcss-sorting.el --- Format CSS coding styles by PostCSS Sorting

;; Copyright (C) 2016 Peiwen Lu <hi@peiwen.lu>

;; Author: Peiwen Lu <hi@peiwen.lu>
;; Version: 0.1
;; URL: https://github.com/P233/emacs-postcss-sorting

;;; Commentary:

;;; Code:

(defconst postcss-sorting-program "postcss"
  "Executable to use for formatting CSS.")

(defconst postcss-sorting-plugin-arg "-u postcss-sorting"
  "Use postcss-sorting plugin.")

(defvar postcss-sorting-config-file "~/.postcssrc.json"
  "Use ~/.postcssrc.json for default sorting config.")

(defvar postcss-sorting-syntax "postcss-scss"
  "Use postcss-scss plugin for default syntax.")


(defun postcss-sorting-command-not-found-message ()
  "Construct a message about PostCSS not found."
  (format
   "PostCSS is not found. Install it and the dependencies with: `npm install postcss-cli postcss-sorting %s -g`"
   postcss-sorting-syntax))

(defun postcss-sorting-format-error-message (buffer-name)
  "Construct a format error message with BUFFER-NAME."
  (format
   "Could not apply PostCSS. See %s to for details."
   buffer-name))

(defun postcss-sorting-get-config-arg ()
  "Construct the config arg with postcss-sorting-config-file."
  (if (> (length postcss-sorting-config-file) 0)
      (concat "-c " postcss-sorting-config-file)))

(defun postcss-sorting-get-syntax-arg ()
  "Construct the syntax arg with postcss-sorting-syntax."
  (if (> (length postcss-sorting-syntax) 0)
      (concat "-s " postcss-sorting-syntax)))

(defun postcss-sorting-get-shell-command ()
  "Join postcss-sorting-program with the constant postcss-sorting-args."
  (mapconcat 'identity (list postcss-sorting-program
                             postcss-sorting-plugin-arg
                             (postcss-sorting-get-config-arg)
                             (postcss-sorting-get-syntax-arg)) " "))


(defun postcss-sorting-format-region (beginning end)
  "Format each line in the BEGINNING .. END region."
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

(defun postcss-sorting-format-buffer ()
  "Format current buffer."
  (postcss-sorting-format-region (point-min) (point-max)))


(defun postcss-sorting ()
  "Format region if active, otherwise the current buffer."
  (interactive)
  (if (use-region-p)
      (postcss-sorting-format-region
       (region-beginning) (region-end))
    (postcss-sorting-format-buffer)))



(provide 'postcss-sorting)

;;; postcss-sorting.el ends here
