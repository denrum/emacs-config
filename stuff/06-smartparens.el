;;; package -- Summary
;;; 06-smartparen.el -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:

(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  :hook ((clojure-mode emacs-lisp-mode) . smartparens-mode))

(provide '06-smartparens)
;;; 06-smartparens.el ends here
