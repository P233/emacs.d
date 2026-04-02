;; -*- lexical-binding: t; -*-
;; rust-analyzer formats through rustfmt, so no separate formatter package is needed
(defun my/rust-format-buffer ()
  "Format via eglot; a failed or timed-out request must not block saving."
  (with-demoted-errors "Rust format skipped: %S"
    (eglot-format-buffer)))

(defun my/rust-format-on-save ()
  (when (derived-mode-p 'rust-ts-mode)
    (if (eglot-managed-p)
        (add-hook 'before-save-hook #'my/rust-format-buffer nil t)
      (remove-hook 'before-save-hook #'my/rust-format-buffer t))))

(add-hook 'eglot-managed-mode-hook #'my/rust-format-on-save)


(provide 'init-rust)
