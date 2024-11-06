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
 '(custom-safe-themes
   '("34cf3305b35e3a8132a0b1bdf2c67623bc2cb05b125f8d7d26bd51fd16d547ec"
	 "a9eeab09d61fef94084a95f82557e147d9630fbbb82a837f971f83e66e21e5ad"
	 default))
 '(package-selected-packages
   '(cider counsel dap-mode dape dirvish docker docker-compose-mode
		   dockerfile-mode doom-modeline doom-themes eglot-booster
		   evil-escape flycheck general gnuplot go-mode
		   highlight-indentation indent-bars magit marginalia pgmacs
		   restclient rust-mode sharper slime-company smartparens
		   spacious-padding treemacs-all-the-icons treemacs-evil
		   treemacs-icons-dired treemacs-nerd-icons
		   treemacs-projectile vertico web-mode))
 '(package-vc-selected-packages
   '((eglot-booster :url "https://github.com/blahgeek/emacs-lsp-booster")
	 (pg :vc-backend Git :url "https://github.com/emarsden/pg-el/"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t :background "#2E3440")))
 '(header-line ((t :box (:line-width 4 :color "#292e39" :style nil))))
 '(header-line-highlight ((t :box (:color "#ECEFF4"))))
 '(keycast-key ((t)))
 '(line-number ((t :background "#2E3440")))
 '(mode-line ((t :box (:line-width 6 :color "#292e39" :style nil))))
 '(mode-line-active ((t :box (:line-width 6 :color "#292e39" :style nil))))
 '(mode-line-highlight ((t :box (:color "#ECEFF4"))))
 '(mode-line-inactive ((t :box (:line-width 6 :color "#292e39" :style nil))))
 '(tab-bar-tab ((t :box (:line-width 4 :color "#2E3440" :style nil))))
 '(tab-bar-tab-inactive ((t :box (:line-width 4 :color "#272C36" :style nil))))
 '(tab-line-tab ((t)))
 '(tab-line-tab-active ((t)))
 '(tab-line-tab-inactive ((t)))
 '(vertical-border ((t :background "#2E3440" :foreground "#2E3440")))
 '(window-divider ((t (:background "#2E3440" :foreground "#2E3440"))))
 '(window-divider-first-pixel ((t (:background "#2E3440" :foreground "#2E3440"))))
 '(window-divider-last-pixel ((t (:background "#2E3440" :foreground "#2E3440")))))
