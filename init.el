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
   '("acfe7ff6aacb9432f124cde4e35d6d2b4bc52916411de73a6ccded9750c9fa97"
	 "b8bd60a23b9e2f08b0c437231ee84f2dacc70fdc4d5a0fb87229bb9926273fdd"
	 "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e"
	 default))
 '(package-selected-packages
   '(all-the-icons-nerd-fonts catppuccin-theme cider counsel dape dirvish
							  docker docker-compose-mode
							  dockerfile-mode doom-modeline
							  doom-themes eglot-booster evil-escape
							  flycheck frameshot general gnuplot
							  go-mode go-tag gotest
							  highlight-indentation indent-bars
							  js-ts-mode lsp-ui magit marginalia
							  mindre-theme modus-themes
							  monokai-pro-theme monokai-theme
							  nyan-mode ob-restclient ollama-buddy
							  pgmacs protobuf-mode rust-mode sharper
							  slime-company smartparens
							  spacious-padding tao-theme templ-ts-mode
							  treemacs-all-the-icons treemacs-evil
							  treemacs-icons-dired treemacs-nerd-icons
							  treemacs-projectile ultra-scroll vertico
							  web-mode which-key)))
