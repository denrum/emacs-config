;;;; 18-go --- go for emacs
;;;; Commentary:
;;;; Set up go for Emacs
;; Code:

(use-package go-mode
  :ensure t)

(setq-default tab-width 4)

(add-hook 'go-mode-hook 'lsp-deferred)
;; (add-hook 'go-mode-hook #'flycheck-mode)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(provide '16-go)
;;; 18-go.el ends here
