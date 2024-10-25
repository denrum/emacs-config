;; 19-cl --- cl for emacs
;;; Commentary:
;;; Set up Common Lisp for Emacs
;;; Code:

(use-package slime
  :ensure t)

(use-package slime-company
  :ensure t)

(require 'slime-autoloads)

(setq slime-autoloads '(".slime-autoloads.lisp"))

;; (use-package corfu
;;   :ensure t
;;   :init (global-corfu-mode))

(add-hook 'common-lisp-mode-hook 'lsp-deferred)

;; Configure SBCL as the Lisp program for SLIME.
(add-to-list 'exec-path "/usr/bin")
(setq inferior-lisp-program "sbcl")

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-slime))
(slime-setup '(slime-fancy slime-company))

;; (add-hook 'slime-mode-hook
;; 		  (lambda ()
;; 			(slime-eval
;; 			 `(swank:load-file ".slime-startup.lisp"))))

(provide '19-cl)
;;; 19-cl.el ends here
