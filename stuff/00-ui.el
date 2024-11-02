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
;; (menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq scroll-step 1)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq truncate-lines t)
(setq pixel-scroll-mode t)

(setq gc-cons-threshold 100000000)

(setq read-process-output-max (* 1024 1024))

(setq compilation-scroll-output t)

;; (use-package gcmh
;;   :ensure t
;;   :demand
;;   :hook
;;   (focus-out-hook . gcmh-idle-garbage-collect)

;;   :custom
;;   (gcmh-idle-delay 10)
;;   (gcmh-high-cons-threshold 104857600)

;;   :config
;;   (gcmh-mode +1))

;;; Setup

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)
  :config (setq all-the-icons-scale-factor 2.0))

;; (use-package vertico-posframe
;;   :ensure t)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;;(load-theme 'doom-flatwhite t)
  (load-theme 'doom-one-light)
  ;;(load-theme 'doom-one t)
  ;;(load-theme 'doom-nord t)
  ;;(load-theme 'doom-opera-light t)
  ;;(load-theme 'doom-nord-light t)
  ;;(set-face-attribute 'default nil :family "Iosevka" :height 130)
  ;; (set-face-attribute 'default nil :family "Ubuntu Mono" :height 120)
  ;; (set-face-attribute 'default nil :family "Berkeley Mono" :height 130)
  ;; (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font Mono" :height 110)
  (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font Mono" :height 110)
  ;;(setq default-text-properties '(line-spacing 0.0 line-height 1.2))
  ;;(set-face-attribute 'default nil :family "Monaspace Krypton" :height 120))
  ;; (set-face-attribute 'default nil :family "SpaceMono Nerd Font" :height 120))
  ;;(set-face-attribute 'default nil :family "monospace" :height 120))
)

(use-package spacious-padding
  :ensure t
  :after (doom-themes)
  :init (spacious-padding-mode 1))

(add-hook 'dired-after-readin-hook 'hl-line-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook '(lambda () (setq truncate-lines t word-wrap nil)))
(add-hook 'treemacs-mode-hook '(lambda () (setq truncate-lines t word-wrap nil)))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package indent-bars
  :ensure t
  :hook ((csharp-mode) . indent-bars-mode)
  :custom (indent-bars-width-frac 0.1))

(provide '00-ui)

;;; 00-ui.el ends here
