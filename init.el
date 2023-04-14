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
   '("bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "dbade2e946597b9cda3e61978b5fcc14fa3afa2d3c4391d477bdaeff8f5638c5" "801a567c87755fe65d0484cb2bded31a4c5bb24fd1fe0ed11e6c02254017acb2" "a1e0f6bbe7cf2890412b46bff6641b893f5cc52dec9198ab2315adf1a329cb85" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" default))
 '(package-selected-packages
   '(color-theme-sanityinc-tomorrow dockerfile-mode docker sharper csharp-mode csproj-mode csproj eglot elgot dired treemacs all-the-icons lsp-mode company flycheck counsel cider tao-theme ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
