;; package -- Summary
;; 10-flycheck
;;; Commentary:
;;; Code:

(use-package flycheck
  :ensure t
  :hook ((emacs-lisp-mode clojure-mode) . flycheck-mode))

(provide '10-flycheck)

;;; 10-flycheck.el ends here
