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

(provide '15-dotnet)
;;; 15-dotnet.el ends here
