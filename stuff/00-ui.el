;;; 00-ui.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Evgeny Mukha
;;
;; Author: Evgeny Mukha <https://github.com/ghrp>
;; Maintainer: Evgeny Mukha <profunctorlense@gmail.com>
;; Created: February 11, 2022
;; Modified: February 11, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/ghrp/00-ui
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

;;; Invaluable UI stuff
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq scroll-step 1)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq truncate-lines t)

;;; Setup

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)
  
  )

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-day t)
  (set-face-attribute 'default nil :family "Iosevka Nerd Font Mono" :height 120))

;; (use-package tao-theme
;;   :ensure t
;;   :init
;;   (setq tao-theme-use-sepia nil)
;;   (setq tao-theme-use-boxes nil)
;;   :config
;;   (load-theme 'tao-yang t)
;;   (set-face-attribute 'default nil :family "Iosevka Nerd Font Mono" :height 140))

(provide '00-ui)
;;; 00-ui.el ends here

(defun xah-insert-random-uuid ()
  "Insert a UUID.
This commands calls “uuidgen” on MacOS, Linux, and calls PowelShell on Microsoft Windows.
URL `http://xahlee.info/emacs/emacs/elisp_generate_uuid.html'
Version 2020-06-04"
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (shell-command "pwsh.exe -Command [guid]::NewGuid().toString()" t))
   ((string-equal system-type "darwin") ; Mac
    (shell-command "uuidgen" t))
   ((string-equal system-type "gnu/linux")
    (insert (substring (shell-command-to-string "uuidgen") 0 36)))
   (t
    ;; code here by Christopher Wellons, 2011-11-18.
    ;; and editted Hideki Saito further to generate all valid variants for "N" in xxxxxxxx-xxxx-Mxxx-Nxxx-xxxxxxxxxxxx format.
    (let ((myStr (md5 (format "%s%s%s%s%s%s%s%s%s%s"
                              (user-uid)
                              (emacs-pid)
                              (system-name)
                              (user-full-name)
                              (current-time)
                              (emacs-uptime)
                              (garbage-collect)
                              (buffer-string)
                              (random)
                              (recent-keys)))))
      (insert (format "%s-%s-4%s-%s%s-%s"
                      (substring myStr 0 8)
                      (substring myStr 8 12)
                      (substring myStr 13 16)
                      (format "%x" (+ 8 (random 4)))
                      (substring myStr 17 20)
                      (substring myStr 20 32)))))))
