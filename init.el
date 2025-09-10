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
