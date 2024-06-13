;;; 15-dotnet --- dotnet for emacs
;;; Commentary:
;; Set up dotnet for Emacs
;;; Code:

(use-package eglot
  :ensure t
  :config (add-to-list 'eglot-server-programs
		      '(csharp-mode . ("~/Public/omnisharp/OmniSharp" "-lsp"))))

;; (use-package csharp-mode
;;   :ensure t)

(use-package csproj-mode
  :ensure t)

(use-package sharper
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package docker
  :ensure t)

(provide '15-dotnet)
;;; 15-dotnet.el ends here
