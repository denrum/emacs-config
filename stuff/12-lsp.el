;;; 12-lsp --- lsp mode for emacs
;;; Commentary:
;; Set up lsp for Emacs
;;; Code:

(use-package eglot
  :ensure t
  :hook ((clojure-mode . eglot-ensure)
		 (csharp-mode . eglot-ensure)
		 (go-mode . eglot-ensure)
		 (rust-mode . eglot-ensure)
		 (sql-mode . eglot-ensure))
  :config
  (setq eglot-sync-connect 1)

  (add-to-list 'display-buffer-alist
               '("\\*sqls\\*"
                 (display-buffer-reuse-window display-buffer-at-bottom)
                 (reusable-frames . visible)
                 (window-height . 0.3)))
  
  (add-to-list 'eglot-server-programs
			   ;;'(csharp-mode . ("/home/denis/Public/omnisharp/OmniSharp" "-lsp")))
			   ;;'(csharp-mode . ("csharp-ls")))
			   ;;'(csharp-mode . ("/home/denis/.vscode/extensions/ms-dotnettools.csharp-2.59.14-linux-x64/.roslyn/Microsoft.CodeAnalysis.LanguageServer" "--logLevel=Information" "--extensionLogDirectory=/tmp/")))
			   '(csharp-mode . ("/home/denis/Projects/dotnet/omnisharp-roslyn/bin/Debug/OmniSharp.Stdio.Driver/net6.0/publish/OmniSharp" "-lsp")))
  
  ;; 			   '(csharp-mode . ("fsautocomplete" "-l" "/var/log/fsautocomplete.log"
  ;; 								:initializationOptions (:AutomaticWorkspaceInit t))))
  ;; ;;'(csharp-mode . ("csharp-ls")))
  
  (defclass eglot-sqls (eglot-lsp-server) () :documentation "SQL's Language Server")
  (add-to-list 'eglot-server-programs
			   '(sql-mode . (eglot-sqls "sqls")))
  ;; (cl-defmethod eglot-execute-command
  ;;   ((server eglot-sqls) (command (eql executeQuery)) arguments)
  ;;   "For executeQuery."
  ;;   ;; (ignore-errors
  ;;     (let* ((beg (eglot--pos-to-lsp-position (if (use-region-p) (region-beginning) (point-min))))
  ;;           (end (eglot--pos-to-lsp-position (if (use-region-p) (region-end) (point-max))))
  ;;           (res (jsonrpc-request server :workspace/executeCommand
  ;;                                 `(:command ,(format "%s" command) :arguments ,arguments
  ;;                                            :timeout 0.5 :range (:start ,beg :end ,end))))
  ;;           (buffer (generate-new-buffer "*sqls*")))
  ;;       (with-current-buffer buffer
  ;;         (eglot--apply-text-edits `[
  ;;                                    (:range
  ;;                                     (:start
  ;;                                      (:line 0 :character 0)
  ;;                                      :end
  ;;                                      (:line 0 :character 0))
  ;;                                      :newText ,res)
  ;;                                     ]
  ;;                                    )
  ;;         (org-mode))
  ;;         (pop-to-buffer buffer))
  ;;         )
  ;; (cl-defmethod eglot-execute-command
  ;;   ((server eglot-sqls) (_cmd (eql switchDatabase)) arguments)
  ;;   "For switchDatabase."
  ;;   (let* ((res (jsonrpc-request server :workspace/executeCommand
  ;;                                `(:command "showDatabases" :arguments ,arguments :timeout 0.5)))
  ;;          (menu-items (split-string res "\n"))
  ;;          (menu `("Eglot code actions:" ("dummy" ,@menu-items)))
  ;;          (db (if (listp last-nonmenu-event)
  ;;                      (x-popup-menu last-nonmenu-event menu)
  ;;                    (completing-read "[eglot] Pick an database: "
  ;;                                                 menu-items nil t
  ;;                                                 nil nil (car menu-items))
  ;;                                ))
  ;;          )
  ;;     (jsonrpc-request server :workspace/executeCommand
  ;;                      `(:command "switchDatabase" :arguments [,db] :timeout 0.5))
  ;;   ))


   )

;;'(csharp-mode . ("csharp-ls"))))

;; (use-package eglot-booster
;;   :ensure t
;;   :after eglot
;;   :vc (:url "https://github.com/jdtsmith/eglot-booster/" :rev :newest)
;;   :config
;;   (setq eglot-booster-io-only t)
;;   (eglot-booster-mode))

(setq eglot-connect-timeout 300)
;;(setq eglot-events-buffer-config (list :size 0 :format 'full))



(require 'cl-generic)
(require 'cl-lib)
(require 'seq)
(require 'eglot)

(defvar my/eglot-lens-debounce 0.001)
(defvar my/eglot-lens--refresh-timer nil)

(cl-defstruct lens
  command
  range)

(defvar my/eglot-codelens-overlays nil
  "Codelens overlays in the current file.")

(cl-defmethod eglot-client-capabilities :around (_server)
  "Let the language SERVER know that we support codelenses."
  (let ((base (cl-call-next-method)))
    (setf (cl-getf
           (cl-getf base :workspace)
           :codeLens)
          '(:refreshSupport t))
    (message "%s" base)
    base))

(defun eglot-lens--setup-hooks ()
  "Setup the hooks to be used for any buffer managed by eglot."
  (eglot-delayed-lens-update)
  (add-hook 'eglot--document-changed-hook #'eglot-delayed-lens-update nil t))

(defun my/eglot-lens-overlays ()
  "Clear all the overlays used for codelenses."
  (interactive)
  (dolist (overlay my/eglot-codelens-overlays)
    (delete-overlay overlay))
  (setq my/eglot-codelens-overlays nil))


(defun eglot-delayed-lens-update ()
  "Update lenses after a small delay to ensure the server is up to date."
  (setq my/eglot-lens--refresh-timer
        (run-with-timer my/eglot-lens-debounce
                        nil
                        #'my/eglot-force-refresh-codelens)))

(defun my/eglot-get-current-lens ()
  "Inspect the current overlays at point and attempt to execute it."
  (interactive)
  (message "%s" (cl-loop for i in (overlays-at (point))
                         when (overlay-get i 'my/eglot-lens-overlay)
                         collect (overlay-get i 'my/eglot-lens-overlay))))

(defun my/eglot-apply-code-lenses ()
  "Request and display codelenses using eglot"
  (interactive)
  (save-excursion
    (let ((code-lenses
           ;; request code lenses from the server
           (jsonrpc-request (eglot--current-server-or-lose)
                            :textDocument/codeLens
                            (list :textDocument (eglot--TextDocumentIdentifier)))))
      (seq-map (lambda (lens)
                 (my/make-overlay-for-lens
                  (make-lens
                   :command
                   (or (cl-getf lens :command)
                       ;; Resolve the command incase none was originally provided
                       (let ((tmp (jsonrpc-request (eglot--current-server-or-lose)
                                                   :codeLens/resolve
                                                   lens)))
                         (message "%s" tmp)
                         (cl-getf tmp
                                  :command)))
                   :range (cl-getf lens :range))))
               code-lenses))))

(defun my/eglot-force-refresh-codelens ()
  "Force request and redisplay codelenses."
  (interactive)
  (when (eglot-current-server)
    (or (my/eglot-lens-overlays) (my/eglot-apply-code-lenses))))

(defun my/eglot-execute-lens (lens)
  "Execute a specific code LENS."
  (eglot-execute (eglot--current-server-or-lose)
                 (lens-command lens))
  (my/eglot-force-refresh-codelens))

(defun my/make-overlay-for-lens (lens)
  "Insert overlays for each corresponding LENS."
  (let* ((start-line (cl-getf
                      (cl-getf (lens-range lens)
                               :start)
                      :line))
         (end-line (cl-getf
                    (cl-getf (lens-range lens)
                             :end)
                    :line))
         (ol (make-overlay (progn (goto-char (point-min))
                                  (forward-line start-line)
                                  (pos-bol))
                           (pos-eol))))
    (overlay-put ol 'before-string
                 (concat
                  (propertize (cl-getf (lens-command lens) :title)
                              'face 'eglot-parameter-hint-face
                              'pointer 'hand
                              'mouse-face 'highlight
                              'keymap (let ((map (make-sparse-keymap)))
                                        (define-key map [mouse-1]
                                                    (lambda () (interactive)
                                                      (my/eglot-execute-lens lens)))
                                        map))
                  "\n"))
    (overlay-put ol 'my/eglot-lens-overlay lens)
    (push ol my/eglot-codelens-overlays)))

(define-minor-mode eglot-lens-mode
  "Minor mode for displaying codeLenses with eglot"
  :global t
  (cond (eglot-lens-mode (add-hook 'eglot-managed-mode-hook #'eglot-lens--setup-hooks)
                         (cl-defmethod eglot-handle-notification
                           (_server (_method (eql workspace/codeLens/refresh))
                                    &allow-other-keys)
                           (my/eglot-force-refresh-codelens)))
        (t (remove-hook 'eglot-managed-mode-hook #'eglot-lens--setup-hooks t))))

(provide '12-lsp)
;;; 12-lsp.el ends here
