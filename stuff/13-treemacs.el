;;; 13-lsp --- treemacs for emacs
;;; Commentary:
;; Set up treemacs for Emacs
;;; Code:

(use-package treemacs
  :ensure t)

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-all-the-icons
  :after (treemacs)
  :ensure t)

;;(treemacs-load-all-the-icons-with-workaround-font "Hermit")
;;(setq treemacs-indentation '(20 px))

;;(treemacs-resize-icons 50)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

;; (set-face-attribute 'treemacs-file-face nil :foreground "#555555")
;; (set-face-attribute 'treemacs-file-face nil :height 100)
;; (set-face-attribute 'treemacs-directory-face nil :height 100)
;; (set-face-attribute 'treemacs-directory-collapsed-face nil :height 100)
;; (set-face-attribute 'treemacs-file-face nil :family "Berkeley Mono")

(provide '13-treemacs)
;;; 13-treemacs.el ends here
