;; Import Emacs package manager
(require 'package)
;; Add largest package repository (Melpa)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
;; Initialize Emacs package manager
(package-initialize)

;; Pull package list on first Emacs start
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package -- convenient wrapper for managing packages
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Read and execute all .el files in .emacs.d/stuff
(let* ((stuff-dir (concat (file-name-directory load-file-name) "/stuff"))
       (load-it (lambda (f) (load-file (concat (file-name-as-directory stuff-dir) f)))))
  (mapc load-it (directory-files stuff-dir nil "\\.el$")))

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cider counsel dap-mode dape dirvish docker docker-compose-mode
		   dockerfile-mode doom-modeline doom-themes eglot-booster
		   evil-escape flycheck frameshot general gnuplot go-mode
		   highlight-indentation indent-bars lsp-ui magit marginalia
		   modus-themes nyan-mode ob-restclient pgmacs restclient
		   rust-mode sharper slime-company smartparens
		   spacious-padding tao-theme treemacs-all-the-icons
		   treemacs-evil treemacs-icons-dired treemacs-nerd-icons
		   treemacs-projectile vertico web-mode))
 '(package-vc-selected-packages
   '((eglot-booster :url "https://github.com/blahgeek/emacs-lsp-booster")
	 (pg :vc-backend Git :url "https://github.com/emarsden/pg-el/"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bold ((t nil)))
 '(fringe ((t :background "#ffffff")))
 '(header-line ((t :box (:line-width 4 :color "#f2f2f2" :style nil))))
 '(header-line-highlight ((t :box (:color "#000000"))))
 '(keycast-key ((t)))
 '(line-number ((t :background "#ffffff")))
 '(mode-line ((t :box (:line-width 6 :color "#c8c8c8" :style nil))))
 '(mode-line-active ((t :box (:line-width 6 :color "#c8c8c8" :style nil))))
 '(mode-line-highlight ((t :box (:color "#000000"))))
 '(mode-line-inactive ((t :box (:line-width 6 :color "#e6e6e6" :style nil))))
 '(tab-bar-tab ((t :box (:line-width 4 :color "#ffffff" :style nil))))
 '(tab-bar-tab-inactive ((t :box (:line-width 4 :color "#c2c2c2" :style nil))))
 '(tab-line-tab ((t)))
 '(tab-line-tab-active ((t)))
 '(tab-line-tab-inactive ((t)))
 '(treemacs-git-modified-face ((t (:inherit warning :weight normal))))
 '(vertical-border ((t :background "#ffffff" :foreground "#ffffff")))
 '(window-divider ((t (:background "#ffffff" :foreground "#ffffff"))))
 '(window-divider-first-pixel ((t (:background "#ffffff" :foreground "#ffffff"))))
 '(window-divider-last-pixel ((t (:background "#ffffff" :foreground "#ffffff")))))
