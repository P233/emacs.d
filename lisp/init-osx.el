(when (memq window-system '(mac ns))
  ;; OSX meta key
  (setq ns-alternate-modifier 'none
        ns-command-modifier 'meta)

  (use-package exec-path-from-shell
    :init
    (exec-path-from-shell-initialize)))


(provide 'init-osx)
