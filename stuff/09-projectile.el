;; package -- Summary
;; 09-projectile
;;; Commentary:
;;; Code:

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (setq projectile-use-git-grep t))

(provide '09-projectile)
;;; 09-projectile.el ends here
