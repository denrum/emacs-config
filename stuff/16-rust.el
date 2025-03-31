;;;; 16-dotnet --- rust for emacs
;;;; Commentary:
;;;; Set up rust for Emacs
;;; Code:

;;(use-package eglot
;;  :ensure t)

(use-package rust-mode
  :ensure t
  :config (setq rust-format-on-save t))

(use-package dockerfile-mode
  :ensure t)

(use-package docker
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package docker-compose-mode
  :ensure t)

(provide '16-rust)
;;; 16-rust.el ends here
