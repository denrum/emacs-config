;;;; 16-dotnet --- rust for emacs
;;;; Commentary:
;;;; Set up rust for Emacs
;;;; Code:

(use-package eglot
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package docker
  :ensure t)

(provide '16-rust)
;;; 16-rust.el ends here
