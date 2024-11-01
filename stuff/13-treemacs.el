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

(use-package nerd-icons
  :ensure t)

(setq nerd-icons-font-family "Symbols Nerd Font Mono")

(require 'nerd-icons)
(require 'treemacs)

(defface treemacs-nerd-icons-root-face
  '((t (:inherit nerd-icons-dorange)))
  "Face used for the root icon in nerd-icons theme."
  :group 'treemacs-faces)

(defface treemacs-nerd-icons-file-face
  '((t (:inherit nerd-icons-orange)))
  "Face used for the directory and file icons in nerd-icons theme."
  :group 'treemacs-faces)

(defvar treemacs-nerd-icons-tab (propertize "\t" :face 'treemacs-nerd-icons-file-face))

;;(defvar treemacs-nerd-icons-space (propertize " " :font-family))

(treemacs-create-theme "nerd-icons"
                       :config
                       (progn
                         (dolist (item nerd-icons-extension-icon-alist)
                           (let* ((extension (car item))
                                  (func (cadr item))
                                  (args (append (list (cadr (cdr item))) '(:v-adjust -0.05 :height 1.0) (cdr (cddr item))))
                                  (icon (apply func args)))
                             (let* ((icon-pair (cons (format "%s%s" icon treemacs-nerd-icons-tab) (format "%s%s" icon treemacs-nerd-icons-tab)))
                                    (gui-icons (treemacs-theme->gui-icons treemacs--current-theme))
                                    (tui-icons (treemacs-theme->tui-icons treemacs--current-theme))
                                    (gui-icon  (car icon-pair))
                                    (tui-icon  (cdr icon-pair)))
                               (ht-set! gui-icons extension gui-icon)
                               (ht-set! tui-icons extension tui-icon))))

                         ;; directory and other icons
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-octicon "nf-oct-repo"   :face 'treemacs-nerd-icons-root-face) treemacs-nerd-icons-tab)
                                               :extensions (root-closed root-open)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-faicon "nf-fa-folder_open"  :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (dir-open)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-faicon "nf-fa-folder"  :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (dir-closed)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-faicon "nf-fa-folder_open"  :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (src-open)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-faicon "nf-fa-folder"  :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (src-closed)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-faicon "nf-fa-folder_open"  :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (build-open)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-faicon "nf-fa-folder"  :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (build-closed)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-faicon "nf-fa-folder_open"  :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (test-open)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-faicon "nf-fa-folder"  :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (test-closed)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-octicon "nf-oct-package"  :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (tag-open)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-octicon "nf-oct-package"  :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (tag-closed)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-octicon "nf-oct-tag"   :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (tag-leaf)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-octicon "nf-oct-flame"  :face 'nerd-icons-red) treemacs-nerd-icons-tab)
                                               :extensions (error)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-octicon "nf-oct-stop"  :face 'nerd-icons-yellow) treemacs-nerd-icons-tab)
                                               :extensions (warning)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-octicon "nf-oct-info"   :face 'nerd-icons-blue) treemacs-nerd-icons-tab)
                                               :extensions (info)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-mdicon "nf-md-mail"   :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (mail)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-octicon "nf-oct-bookmark"   :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (bookmark)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-mdicon "nf-md-monitor"   :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (screen)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-mdicon "nf-md-home"   :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (house)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-faicon "nf-fa-list"   :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (list)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-mdicon "nf-md-repeat"   :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (repeat)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-faicon "nf-fa-suitcase"   :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (suitcase)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-mdicon "nf-md-close"   :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (close)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-octicon "nf-oct-calendar"   :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (calendar)
                                               :fallback 'same-as-icon)
                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-faicon "nf-fa-briefcase"   :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (briefcase)
                                               :fallback 'same-as-icon)

                         (treemacs-create-icon :icon (format "%s%s" (nerd-icons-faicon "nf-fa-file_o" :face 'treemacs-nerd-icons-file-face) treemacs-nerd-icons-tab)
                                               :extensions (fallback)
                                               :fallback 'same-as-icon)))


(treemacs-load-theme "nerd-icons")

;;(treemacs-load-all-the-icons-with-workaround-font "Hermit")
;;(setq treemacs-indentation '(20 px))

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

;; (set-face-attribute 'treemacs-file-face nil :foreground "#555555")
;; (set-face-attribute 'treemacs-file-face nil :height 100)
;; (set-face-attribute 'treemacs-directory-face nil :height 100)
;; (set-face-attribute 'treemacs-directory-collapsed-face nil :height 100)
;; (set-face-attribute 'treemacs-file-face nil :family "Berkeley Mono")

;; (set-face-attribute 'treemacs-file-face nil :height 100)
;; (set-face-attribute 'treemacs-directory-face nil :height 100)
;; (set-face-attribute 'treemacs-git-modified-face nil :height 100)
;;(set-face-attribute 'treemacs-all-the-icons-root-face nil :height 120)
;;(set-face-attribute 'treemacs-all-the-icons-file-face nil :height 120)
;;(set-face-attribute 'treemacs-all-the-icons-file-face nil :height 50)

(set-face-attribute 'treemacs-nerd-icons-file-face nil :height 120)
;;(set-face-attribute 'treemacs-nerd-icons-root-face nil :height 150)

;;(treemacs-load-all-the-icons-with-workaround-font "JetBrainsMono Nerd Font Mono")

;;(treemacs-resize-icons 20)

(provide '13-treemacs)
;;; 13-treemacs.el ends here
