;;; 15-dotnet --- dotnet for emacs
;;; Commentary:
;; Set up dotnet for Emacs
;;; Code:


;; (use-package lsp-mode
;;   :ensure t)
  ;; :config (add-to-list 'lsp-list
  ;; 		      '(csharp-mode . ("~/.local/bin/emacs-lsp-booster" "~/Public/omnisharp/OmniSharp" "-lsp"))))
  ;; 		      ;;'(csharp-mode . ("csharp-ls"))))

;; (use-package csharp-mode
;;   :ensure t)

;; (add-hook 'csharp-mode-hook 'lsp-deferred)

;; (use-package tree-sitter
;;   :ensure t)
;;   ;;:config (add-to-list 'tree-sitter-major-mode-language-alist '(csharp-mode . c_sharp)))

;; (use-package tree-sitter-langs
;;   :ensure t)

;; (use-package tree-sitter-indent
;;   :ensure t)

;; (use-package csproj-mode
;;   :ensure t
;;   :config
;;   (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-tree-sitter-mode)))

;; (use-package dap-mode
;;   :ensure t)

;; (use-package sharper
;;   :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package docker
  :ensure t)

;; ;; project-find-function supporting both C# and F#:

;; (defun dotnet-mode/find-sln-or-fsproj (dir-or-file)
;;   "Search for a solution or F# project file in any enclosing
;; folders relative to DIR-OR-FILE."
;;   (dotnet-mode-search-upwards (rx (0+ nonl) (or ".fsproj" ".sln" ".csproj") eol)
;;                               (file-name-directory dir-or-file)))

;; (defun dotnet-mode-search-upwards (regex dir)
;;   (when dir
;;     (or (car-safe (directory-files dir 'full regex))
;;         (dotnet-mode-search-upwards regex (dotnet-mode-parent-dir dir)))))

;; (defun dotnet-mode-parent-dir (dir)
;;   (let ((p (file-name-directory (directory-file-name dir))))
;;     (unless (equal p dir)
;;       p)))

;; ;; Make project.el aware of dotnet projects
;; (defun dotnet-mode-project-root (dir)
;;   (when-let (project-file (dotnet-mode/find-sln-or-fsproj dir))
;;     (cons 'dotnet (file-name-directory project-file))))

;; (cl-defmethod project-roots ((project (head dotnet)))
;;   (list (cdr project)))

;; (add-hook 'project-find-functions #'dotnet-mode-project-root)



(provide '15-dotnet)
;;; 15-dotnet.el ends here
