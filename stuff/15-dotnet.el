;;; 15-dotnet --- dotnet for emacs
;;; Commentary:
;; Set up dotnet for Emacs
;;; Code:


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

(add-to-list 'auto-mode-alist '("\\.csproj" . nxml-mode))

(use-package sharper
  :ensure t
  :vc (:url "https://github.com/sebasmonia/sharper" :rev :newest)
  :bind
  ("C-c n" . sharper-main-transient))

(require 'sharper)

(require 'xml)

(defun read-xml-file (file)
  "Read xml FILE to temp buffer."
  (with-temp-buffer
    (insert-file-contents file)
    (libxml-parse-xml-region (point-min) (point-max))))

(require 'dom)

(defun find-tag-value (xml tag)
  "Find the value of the first occurrence of TAG in the XML/HTML tree XML."
  (car (cddr (car (dom-by-tag xml tag)))))

(defun find-current-file-project-dll ()
  "Find dll name of current file project."
  (let* ((csproj (file-relative-name (car (file-expand-wildcards (file-name-concat (sharper--nearest-project-dir) "*.csproj")))))
		 (dir (file-name-directory csproj))
		 (xml-data (read-xml-file csproj))
		 (assembly-name (find-tag-value xml-data 'AssemblyName))
		 (assembly-file-name (if assembly-name
								 (concat assembly-name ".dll")
							   (concat (file-name-base csproj) ".dll"))))
	(file-relative-name
	 (file-relative-name
	  (car
	   (file-expand-wildcards
		(file-name-concat dir "bin" "Debug" "*" assembly-file-name)))))))

(require 'cl-lib)

(defvar nunit-test-methodfunc-template "dotnet test --filter %e --logger \"trx;LogFileName=%f\"" "Template for \"dotnet test\" invocations to run the \"current test\".")

(defun nunit-run-test-at-point (&optional _transient-params)
  "Run \"dotnet test\", ignore TRANSIENT-PARAMS, setup call via `sharper--current-test'."
  (interactive
   (list (transient-args 'sharper-transient-test)))
  ;;(transient-set)
  (if sharper--current-test
      (let* ((temp-file (make-temp-file "dotnet"))
			 (default-directory (car sharper--current-test))
             (command (sharper--strformat nunit-test-methodfunc-template
                                          ?e (shell-quote-argument (cdr sharper--current-test))
										  ?f temp-file)))
        (sharper--log-command "Testing method/function at point" command)
        (compile command))
    ;; go back to the main menu if sharper--current-test is not set
    (sharper-main-transient)))


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
     :program find-current-file-project-dll
	 :stopAtEntry nil)))

;; Enable repeat mode for more ergonomic `dape' use
(use-package repeat
  :config
  (repeat-mode))

(use-package dockerfile-mode
  :ensure t)

(use-package docker
  :ensure t)

(provide '15-dotnet)
;;; 15-dotnet.el ends here
