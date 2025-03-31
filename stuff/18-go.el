;; 18-go --- go for emacs
;;; Commentary:
;;; Set up go for Emacs
;;; Code:

(use-package go-mode
  :ensure t
  :init (add-hook 'before-save-hook 'gofmt-before-save))

(setq-default tab-width 4)

;; (add-hook 'go-mode-hook 'lsp-deferred)
;; (add-hook 'go-mode-hook #'flycheck-mode)

(use-package gotest
  :ensure t
  :after go-mode
  :bind (:map go-mode-map
              ("C-c t f" . go-test-current-file)
              ("C-c t t" . go-test-current-test)
              ("C-c t j" . go-test-current-project)
              ("C-c t b" . go-test-current-benchmark)
              ("C-c t c" . go-test-current-coverage)
              ("C-c t x" . go-run)))

(use-package go-tag
  :ensure t
  :bind (:map go-mode-map
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

(use-package ollama-buddy
  :ensure t
  :bind ("C-c l" . ollama-buddy-menu))

;; (templ-ts--setup)
;;   (setq treesit-range-settings nil)
;;               (apply #'treesit-range-rules
;;                      templ-ts--range-rules))


(provide '16-go)
;;; 18-go.el ends here
