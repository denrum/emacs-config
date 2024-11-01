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

;; (require 'dap-netcore)

;; (setq dap-netcore-download-url "https://github.com/Samsung/netcoredbg/releases/download/3.1.1-1042/netcoredbg-linux-amd64.tar.gz")

;; (add-hook 'dap-stopped-hook
;;           (lambda (arg) (call-interactively #'dap-hydra)))

(require 'xml)

(defun read-xml-file (file)
  "Read xml FILE to temp buffer."
  (with-temp-buffer
    (insert-file-contents file)
    (libxml-parse-xml-region (point-min) (point-max))))

(defun find-tag-value (xml tag)
  "Find the value of the first occurrence of TAG in the XML/HTML tree XML."
  (catch 'found
    (when (listp xml)
      (let ((tag-name (car xml)))
        (if (eq tag-name tag)
            (let ((children (cddr xml)))
              (dolist (child children)
                (when (stringp child)
                  (throw 'found child))))
          (dolist (child (cdr xml))
            (when (listp child)
              (let ((result (find-tag-value child tag)))
                (when result
                  (throw 'found result))))))))))


(use-package dape
  :ensure t
  ;;:preface
  ;; By default dape shares the same keybinding prefix as `gud'
  ;; If you do not want to use any prefix, set it to nil.
  ;; (setq dape-key-prefix "\C-x\C-a")

  ;;:hook
  ;; Save breakpoints on quit
  ;; ((kill-emacs . dape-breakpoint-save)
  ;; Load breakpoints on startup
  ;;  (after-init . dape-breakpoint-load))

  :config
  ;; Turn on global bindings for setting breakpoints with mouse
  (dape-breakpoint-global-mode)

  ;; Info buffers to the right
  (setq dape-buffer-window-arrangement 'right)

  ;; Info buffers like gud (gdb-mi)
  ;; (setq dape-buffer-window-arrangement 'gud)
  ;; (setq dape-info-hide-mode-line nil)

  ;; Pulse source line (performance hit)
  (add-hook 'dape-display-source-hook 'pulse-momentary-highlight-one-line)

  ;; Showing inlay hints
  (setq dape-inlay-hints t)

  ;; Save buffers on startup, useful for interpreted languages
  ;; (add-hook 'dape-start-hook (lambda () (save-some-buffers t t)))

  ;; Kill compile buffer on build success
  (add-hook 'dape-compile-hook 'kill-buffer)

  ;; Projectile users
  ;;(setq dape-cwd-fn 'projectile-project-root)
  ;;(setq dape-cwd-fn 'sharper--nearest-project-dir)

  (add-to-list 'dape-configs `(netcoredbg
     modes (csharp-mode csharp-ts-mode)
     ensure dape-ensure-command
     command "netcoredbg"
     command-args ["--interpreter=vscode"]
     :request "launch"
     :cwd sharper--nearest-project-dir
     :program (lambda ()
				(let* ((csproj (file-relative-name (car (file-expand-wildcards "*.csproj"))))
					  (xml-data (read-xml-file csproj))
					  (assembly-name (find-tag-value xml-data 'AssemblyName))
					  (assembly-file-name (concat assembly-name ".dll")))
				  (file-relative-name
				   (file-relative-name
					(car
					 (file-expand-wildcards
					  (file-name-concat "bin" "Debug" "*" assembly-file-name)))))))
	 :stopAtEntry nil))
  )

;; Enable repeat mode for more ergonomic `dape' use
(use-package repeat
  :config
  (repeat-mode))

;; (use-package web-mode
;;   :ensure t)

(use-package sharper
  :ensure t
  :vc (:url "https://github.com/sebasmonia/sharper" :rev :newest)
  :bind
  ("C-c n" . sharper-main-transient))


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
