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
			   '(csharp-mode . ("/home/denis/Public/omnisharp/OmniSharp" "-lsp")))
  ;;'(csharp-mode . ("csharp-ls")))
  
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

(use-package eglot-booster
  :ensure t
  :after eglot
  :vc (:url "https://github.com/jdtsmith/eglot-booster/" :rev :newest)
  :config (eglot-booster-mode))

(setq eglot-connect-timeout 900)
(setq eglot-events-buffer-config (list :size 0 :format 'full))

(provide '12-lsp)
;;; 12-lsp.el ends here
