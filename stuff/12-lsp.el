;;; 12-lsp --- lsp mode for emacs
;;; Commentary:
;; Set up lsp for Emacs
;;; Code:

;; (use-package lsp-mode
;;   :ensure t
;;   :hook ((clojure-mode . lsp)
;; 		 (csharp-mode . lsp)
;; 		 (go-mode . lsp)))

(use-package eglot
  :ensure t
  :hook ((clojure-mode . eglot-ensure)
		 (csharp-mode . eglot-ensure)
		 (go-mode . eglot-ensure)
		 (rust-mode . eglot-ensure))
  :config (add-to-list 'eglot-server-programs
					   '(csharp-mode . ("/home/denis/Public/omnisharp/OmniSharp" "-lsp"))))
		      ;;'(csharp-mode . ("csharp-ls"))))

(use-package eglot-booster
  :ensure t
  :after eglot
  :vc (:url "https://github.com/jdtsmith/eglot-booster/" :rev :newest)
  :config (eglot-booster-mode))

(setq eglot-connect-timeout 300)
(setq eglot-events-buffer-config 0)
(setq eglot-events-buffer-size)

(provide '12-lsp)
;;; 12-lsp.el ends here
