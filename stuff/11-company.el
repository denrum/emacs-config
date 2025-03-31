;;; package --- Summary
;;; Commentary:

;;; Code:
(use-package company
  :ensure t
  :hook ((emacs-lisp-mode clojure-mode lisp-mode csharp-mode go-mode) . company-mode)
  )

(setq company-show-quick-access t
      company-tooltip-align-annotations t
      company-idle-delay 0.2
      company-minimum-prefix-length 2
      company-tooltip-limit 20)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-capf))

(provide '11-company)
;;; 11-company.el ends here
