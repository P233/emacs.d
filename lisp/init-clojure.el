(use-package clojure-mode)

(defun cljs-node-repl ()
  (interactive)
  (run-clojure "lein trampoline run -m clojure.main repl.clj"))



(provide 'init-clojure)
