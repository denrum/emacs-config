;; 20-db --- db for emacs
;;; Commentary:
;;; Set up database for Emacs
;;; Code:
;; Requires Emacs 29 and git

(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)))

(setq sql-postgres-program "/usr/lib/postgresql/16/bin/psql")


;; (use-package pg
;;   :vc (:url "https://github.com/emarsden/pg-el/" :rev :newest))

;; (use-package pgmacs
;;   :vc (:url "https://github.com/emarsden/pgmacs/" :rev :newest))

(provide '20-db)

;;; 20-db.el ends here

