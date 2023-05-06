(use-package cider
  :ensure t)

(defun cider-eval-end-of-sexp (arg)
  (interactive "P")
  (save-excursion
    (forward-char)
    (cider-eval-last-sexp arg)))
