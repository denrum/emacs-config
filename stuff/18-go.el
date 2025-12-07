;; 18-go --- go for emacs
;;; Commentary:
;;; Set up go for Emacs
;;; Code:

(use-package go-mode
  :ensure t
  ;;:init (add-hook 'before-save-hook 'gofmt-before-save)
  ;;:hook (go-ts-mode . gofmt-before-save)
  :init (add-hook 'go-ts-mode-hook (lambda () (add-hook 'before-save-hook 'gofmt-before-save nil t)))
  :bind (("C-c c" . comment-or-uncomment-region)))

;; (add-hook 'go-ts-mode-hook
;; 		  (lambda ()
;; 			(add-hook 'before-save-hook 'gofmt-before-save)))

;; (add-hook 'go-mode-hook
;; 		  (lambda ()
;; 			(add-hook 'before-save-hook 'gofmt-before-save)))

(setq-default tab-width 4)
(setq-default go-ts-mode-indent-offset 4)

;; (add-hook 'go-mode-hook 'lsp-deferred)
;; (add-hook 'go-mode-hook #'flycheck-mode)

(use-package gotest
  :ensure t
  :after (go-mode go-ts-mode)
  :bind (:map go-ts-mode-map
              ("C-c t f" . go-test-current-file)
              ("C-c t t" . go-test-current-test)
              ("C-c t j" . go-test-current-project)
              ("C-c t b" . go-test-current-benchmark)
              ("C-c t c" . go-test-current-coverage)
              ("C-c t x" . go-run)))

(use-package go-tag
  :ensure t
  :bind (:map go-ts-mode-map
              ("C-c t a" . go-tag-add)
              ("C-c t r" . go-tag-remove))
  :init (setq go-tag-args (list "-transform" "camelcase")))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))


(use-package templ-ts-mode
  :ensure t)

(add-hook 'templ-ts-mode-hook
          (lambda ()
            (add-hook 'after-save-hook
                      (lambda ()
                        (when (string-match "\\.templ\\'" (buffer-file-name))
                          (let ((file (buffer-file-name)))
                          (shell-command (concat "templ fmt " (shell-quote-argument file)))
                          (revert-buffer t t t))) ; Автоматически перечитать
                      nil t))))

(use-package ellama
  :ensure t
  ;;:bind ("C-c e" . ellama)
  ;; send last message in chat buffer with C-c C-c
  :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
  :init
  ;; setup key bindings
  (setopt ellama-keymap-prefix "C-c e")
  ;; language you want ellama to translate to
  (setopt ellama-language "Русский")
  ;; could be llm-openai for example
  (require 'llm-ollama)
  (setopt ellama-provider
  	  (make-llm-ollama
  	   ;; this model should be pulled to use it
  	   ;; value should be the same as you print in terminal during pull
	   ;;  	   :chat-model "llama3:8b-instruct-q4_0"
  	   :chat-model "qwen2.5-coder:7b"
  	   :embedding-model "nomic-embed-text"
	   :port 11434
  	   :default-chat-non-standard-params '(("num_ctx" . 8192))))
  (setopt ellama-summarization-provider
  	  (make-llm-ollama
  	   :chat-model "qwen2.5:3b"
  	   :embedding-model "nomic-embed-text"
	   :port 11434
  	   :default-chat-non-standard-params '(("num_ctx" . 32768))))
  (setopt ellama-coding-provider
  	  (make-llm-ollama
  	   :chat-model "qwen2.5-coder:7b"
  	   :embedding-model "nomic-embed-text"
  	   :default-chat-non-standard-params '(("num_ctx" . 32768))))
  ;; Predefined llm providers for interactive switching.
  ;; You shouldn't add ollama providers here - it can be selected interactively
  ;; without it. It is just example.
  (setopt ellama-providers
  	  '(("zephyr" . (make-llm-ollama
  			 :chat-model "zephyr:7b-beta-q6_K"
			 :port 11434
  			 :embedding-model "zephyr:7b-beta-q6_K"))
  	    ("mistral" . (make-llm-ollama
  			  :chat-model "mistral:7b-instruct-v0.2-q6_K"
			  :port 11434
  			  :embedding-model "mistral:7b-instruct-v0.2-q6_K"))
  	    ("mixtral" . (make-llm-ollama
  			  :chat-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"
			  :port 11434
  			  :embedding-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"))))
  ;; Naming new sessions with llm
  (setopt ellama-naming-provider
  	  (make-llm-ollama
  	   :chat-model "llama3:8b-instruct-q4_0"
  	   :embedding-model "nomic-embed-text"
	   :port 11434
  	   :default-chat-non-standard-params '(("stop" . ("\n")))))
  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
  ;; Translation llm provider
  (setopt ellama-translation-provider
  	  (make-llm-ollama
  	   :chat-model "qwen2.5:7b"
  	   :embedding-model "nomic-embed-text"
	   :port 11434
  	   :default-chat-non-standard-params
  	   '(("num_ctx" . 32768))))
  (setopt ellama-extraction-provider (make-llm-ollama
  				      :chat-model "qwen2.5-coder:7b-instruct-q4_0"
  				      :embedding-model "nomic-embed-text"
					  :port 11434
  				      :default-chat-non-standard-params
  				      '(("num_ctx" . 32768))))
  ;; customize display buffer behaviour
  ;; see ~(info "(elisp) Buffer Display Action Functions")~
  (setopt ellama-chat-display-action-function #'display-buffer-full-frame)
  (setopt ellama-instant-display-action-function #'display-buffer-at-bottom)
  :config
  ;; show ellama context in header line in all buffers
  ;;(ellama-context-header-line-global-mode +1)
  ;; show ellama session id in header line in all buffers
  ;;(ellama-session-header-line-global-mode +1)
  ;; handle scrolling events
  (advice-add 'pixel-scroll-precision :before #'ellama-disable-scroll)
  (advice-add 'end-of-buffer :after #'ellama-enable-scroll))


(require 'ellama)

(setq ellama-autocomplete-provider
  	  (make-llm-ollama
  	   :chat-model "qwen2.5-coder:7b-instruct-q6_K"
	   ;;:chat-model "codegemma:2b-code-q4_0"
  	   ;;:embedding-model "nomic-embed-text"
  	   ;;:default-chat-non-standard-params '(("num_ctx" . 16384))
	   ))

(require 'projectile)

;;;###autoload
(defun my/code-complete ()
  "Complete selected code or code in current buffer."
  (interactive)
  (let* ((prefix (buffer-substring-no-properties (point-min) (point)))
	 (suffix (buffer-substring-no-properties (point) (point-max)))
	 (line (car (reverse (cl-remove-if (lambda (s)
					     (string-match-p (rx
							      line-start
							      (* (any space))
							      line-end)
							     s))
					   (string-lines prefix)))))
	 (word (car (reverse (string-split line " "))))
	 (project-folder (projectile-project-root))
	 (context-file-name (file-name-concat project-folder "llmcontext.org"))
	 (llmcontext (if (file-exists-p context-file-name)
					 (with-temp-buffer
					   (insert-file-contents context-file-name)
					   (buffer-string))
				   "")))
	;;	(message "Code completion suffix and prefix: %s %s" prefix suffix)
	(message "LLM context: %s" llmcontext)
    (ellama-stream
     (format
"<filename>%s</filename>
<|fim_prefix|>%s<|fim_suffix|>%s<|fim_middle|>"
      ;;"<|fim_begin|>%s<|fim_hode|>%s<|fim_end|>"
	  (buffer-name)
      prefix
	  suffix)
     :provider ellama-autocomplete-provider
	 :system   llmcontext
     :filter (lambda (s)
			   (message "Result: %s" s)
	       (string-trim
		(string-trim-left
		 (ellama--code-filter s))))
		 ;; (rx
		 ;;  (* (any space))
		 ;;  (or (literal text)
		 ;;      (literal line)
		 ;;      (literal word))))))
     :on-done #'ellama-fix-parens
     :point (point))))


;; (templ-ts--setup)
;;   (setq treesit-range-settings nil)
;;               (apply #'treesit-range-rules
;;                      templ-ts--range-rules))


(provide '18-go)
;;; 18-go.el ends here
