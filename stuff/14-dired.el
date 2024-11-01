;;; 14-dired --- dired for emacs
;;; Commentary:
;; Set up dired for Emacs
;;; Code:

;; (use-package dired
;;   :ensure t)

(setq delete-by-moving-to-trash t)

;; (use-package dirvish
;;   :init
;;   (dirvish-override-dired-mode)
;;   :config
;;   (setq dirvish-mode-line-format
;;         '(:left (sort symlink) :right (omit yank index)))
;;   (setq dirvish-mode-line-height 10)
;;   (setq dirvish-attributes
;;         '(nerd-icons file-time file-size collapse subtree-state vc-state git-msg))
;;   (setq dirvish-subtree-state-style 'nerd)
;;   (setq delete-by-moving-to-trash t)
;;   (setq dirvish-path-separators (list
;;                                  (format "  %s " (nerd-icons-codicon "nf-cod-home"))
;;                                  (format "  %s " (nerd-icons-codicon "nf-cod-root_folder"))
;;                                  (format " %s " (nerd-icons-faicon "nf-fa-angle_right"))))
;;   (setq dired-listing-switches
;;         "-l --almost-all --human-readable --group-directories-first --no-group")
;;   (dirvish-peek-mode) ; preview files in minibuffer
;;   (dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
;; )

(provide '14-dired)
;;; 14-dired.el ends here
