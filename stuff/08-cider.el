;; package -- Summary
;; 08-cider.el
;;; Commentary:
;;; Code:

(use-package cider
  :ensure t)

(defun cider-eval-end-of-sexp (arg)
  (interactive "P")
  (save-excursion
    (forward-char)
    (cider-eval-last-sexp arg)))

(provide '08-cider)
;;; 08-cider.el ends here
