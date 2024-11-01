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
   '("9f297216c88ca3f47e5f10f8bd884ab24ac5bc9d884f0f23589b0a46a608fe14"
	 default))
 '(package-selected-packages
   '(cider counsel dap-mode dape dirvish docker docker-compose-mode
		   dockerfile-mode doom-modeline doom-themes eglot-booster
		   evil-escape flycheck general go-mode highlight-indentation
		   indent-bars magit marginalia pgmacs restclient rust-mode
		   sharper slime-company smartparens spacious-padding
		   treemacs-all-the-icons treemacs-evil treemacs-icons-dired
		   treemacs-nerd-icons treemacs-projectile vertico web-mode))
 '(package-vc-selected-packages
   '((eglot-booster :url "https://github.com/blahgeek/emacs-lsp-booster")
	 (pg :vc-backend Git :url "https://github.com/emarsden/pg-el/"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t :background "#fafafa")))
 '(header-line ((t :box (:line-width 4 :color "#e7e7e7" :style nil))))
 '(header-line-highlight ((t :box (:color "#383a42"))))
 '(keycast-key ((t)))
 '(line-number ((t :background "#fafafa")))
 '(mode-line ((t :box (:line-width 6 :color "#e7e7e7" :style nil))))
 '(mode-line-active ((t :box (:line-width 6 :color "#e7e7e7" :style nil))))
 '(mode-line-highlight ((t :box (:color "#383a42"))))
 '(mode-line-inactive ((t :box (:line-width 6 :color "#e1e1e1" :style nil))))
 '(tab-bar-tab ((t :box (:line-width 4 :color "#fafafa" :style nil))))
 '(tab-bar-tab-inactive ((t :box (:line-width 4 :color "#f0f0f0" :style nil))))
 '(tab-line-tab ((t)))
 '(tab-line-tab-active ((t)))
 '(tab-line-tab-inactive ((t)))
 '(vertical-border ((t :background "#fafafa" :foreground "#fafafa")))
 '(window-divider ((t (:background "#fafafa" :foreground "#fafafa"))))
 '(window-divider-first-pixel ((t (:background "#fafafa" :foreground "#fafafa"))))
 '(window-divider-last-pixel ((t (:background "#fafafa" :foreground "#fafafa")))))
