;;; 21-dape --- debugger
;;; Commentary:
;; Set up debugger
;;; Code:

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
  (setq dape-cwd-fn 'projectile-project-root)
  ;;(setq dape-cwd-fn 'sharper--nearest-project-dir)

  (add-to-list 'dape-configs `(netcoredbg
     modes (csharp-mode csharp-ts-mode)
     ensure dape-ensure-command
     command "netcoredbg"
     command-args ["--interpreter=vscode"]
     :request "launch"
     :cwd sharper--nearest-project-dir
     :program find-current-file-project-dll
	 :stopAtEntry nil))

  ;; (add-to-list 'dape-configs `(dlv
  ;;    modes (go-mode go-ts-mode)
  ;;    ensure dape-ensure-command
  ;;    command "dlv"
  ;;    command-args ["test" "neltom.com/system/locations" "--listen" "127.0.0.1::autoport" "--allow-non-terminal-interactive=true"]
  ;; 	 command-cwd dape-command-cwd
  ;; 	 port :autoport
  ;; 	 command-insert-stderr t
  ;;    :request "launch"
  ;; 	 :type "debug"
  ;;    :cwd "."
  ;;    :program "."
  ;; 	 :stopAtEntry nil))
  )

;;(setq dape-debug t)

(require 'gotest)

(defun my/dape-debug-go-test ()
  "Запуск отладки текущего Go-теста с dape-mode."
  (interactive)
  (let ((test-package (go-test--gb-find-package))
		(test-name (go-test--get-current-test))) ; Получить имя теста под курсором
	(message "Current test: %s in %s" test-name test-package)
	(message "Current file testing data: %s" (go-test--get-current-file-testing-data))
    (dape
     `(:name "Debug Go Test"
       :type "debug"
       :request "launch"
       :mode "test"
	   :cwd "."
       :program "." ;;,(expand-file-name (buffer-file-name)) ; Путь к текущему файлу
       :args ["run" ,(concat "^" test-name "$")] ; Запуск конкретного теста
       command "dlv" ;;,(executable-find "dlv") ; Путь к dlv (автоматически ищется в PATH)
	   command-cwd ,test-package
       command-insert-stderr t
	   command-args ("dap" "--listen" "localhost::autoport")
	   port :autoport
     ))))

(defun my/dape-debug-go-main ()
  "Запуск отладки текущего Go-теста с dape-mode."
  (interactive)
  (let ((test-package (go-test--gb-find-package)))
	(message "Current packet: %s" test-package)
	;;(message "Current file testing data: %s" (go-test--get-current-file-testing-data))
    (dape
     `(:name "Debug Go Main"
       :type "debug"
       :request "launch"
       :mode "debug"
	   :cwd "."
       :program "." ;;,(expand-file-name (buffer-file-name)) ; Путь к текущему файлу
       :args ["run" test-package] ; Запуск конкретного теста
       command "dlv" ;;,(executable-find "dlv") ; Путь к dlv (автоматически ищется в PATH)
	   command-cwd ,test-package
       command-insert-stderr t
	   command-args ("dap" "--listen" "localhost::autoport")
	   port :autoport
     ))))


(bind-key "C-c t d" 'my/dape-debug-go-test go-ts-mode-map)

;; Enable repeat mode for more ergonomic `dape' use
(use-package repeat
  :config
  (repeat-mode))

(provide '21-dape)
;;; 21-dape.el ends here
