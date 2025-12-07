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

;; Запретить Custom изменять init.el
(setq enable-local-variables :safe)

;;; Invaluable UI stuff
(scroll-bar-mode 0)

;;(set-window-scroll-bars (minibuffer-window) nil nil)

(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq scroll-step 1)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq truncate-lines t)
(setq truncate-partial-width-windows nil)
(setq pixel-scroll-mode t)
(pixel-scroll-precision-mode t)

(setq gc-cons-threshold 100000000)

(setq read-process-output-max (* 1024 1024))

(setq compilation-scroll-output t)

(setq org-confirm-babel-evaluate nil)

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

;; (use-package monokai-pro-theme
;;   :ensure t
;;   :config
;;   (load-theme 'monokai-pro-classic t)
;;   (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font Mono" :height 110 :weight 'light))

;; (use-package modus-themes
;;   :ensure t
;;   :config
;;   (load-theme 'modus-operandi t)
;;   ;;(set-face-attribute 'default nil :family "FiraCode Nerd Font Mono" :height 120 :weight 'normal)
;;   ;;(set-face-attribute 'default nil :family "Iosevka Nerd Font Mono" :height 130)
;;   (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font Mono" :height 120 :weight 'light))

;; (use-package mindre-theme
;;     :ensure t
;;     :custom
;;     (mindre-use-more-bold nil)
;;     (mindre-use-faded-lisp-parens t)
;;     :config
;;     (load-theme 'mindre t)
;; 	(set-face-attribute 'default nil :family "Sarasa Mono CL Nerd Font" :height 120))

;; (use-package tao-theme
;;   :ensure t
;;   :config
;;   (load-theme 'tao-yang t)
;;   (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font Mono" :height 120))

(use-package spacious-padding
  :ensure t
  ;;:after doom-themes
  :init (spacious-padding-mode 1))

;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   ;;(load-theme 'doom-flatwhite t)
;;   ;;(load-theme 'doom-one-light)
;;   (load-theme 'doom-one t)
;;   ;;(load-theme 'doom-nord t)
;;   ;;(load-theme 'doom-tomorrow-day t)
;;   ;;(load-theme 'doom-opera-light t)
;;   ;;(load-theme 'doom-nord-light t)
;;   ;;(set-face-attribute 'default nil :family "Iosevka Nerd Font" :height 130)
;;   ;; (set-face-attribute 'default nil :family "Ubuntu Mono" :height 120)
;;   ;; (set-face-attribute 'default nil :family "Berkeley Mono" :height 120)
;;   ;; (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font Mono" :height 110)
;;   (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font Mono" :height 120)
;;   (doom-themes-org-config)
;;   (doom-themes-visual-bell-config) ;Моргаем строкой состояния вместо сигнала
;;   ;;(setq default-text-properties '(line-spacing 0.0 line-height 1.2))
;;   ;;(set-face-attribute 'default nil :family "Monaspace Krypton" :height 120))
;;   ;; (set-face-attribute 'default nil :family "SpaceMono Nerd Font" :height 120))
;;   ;;(set-face-attribute 'default nil :family "monospace" :height 120))
;; )
;
(use-package ef-themes
  :ensure t
  :config
  (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font Mono" :height 120)
  (load-theme 'ef-cyprus t))

;;(with-eval-after-load 'org
  ;;(doom-themes-org-config)
  ;;(doom-themes-visual-bell-config)
;;  )

;;(setq line-spacing 0)

(add-hook 'dired-after-readin-hook 'hl-line-mode)
(add-hook 'prog-mode-hook (lambda ()
							(setq display-line-numbers-width 4)
							(display-line-numbers-mode 1)))
(add-hook 'prog-mode-hook #'(lambda () (setq truncate-lines t word-wrap nil)))
(add-hook 'treemacs-mode-hook #'(lambda () (setq truncate-lines t word-wrap nil)))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-total-line-number t))

;; Nyan cat for scroll position
(use-package nyan-mode
  :ensure t
  :init (nyan-mode 1))

(use-package indent-bars
  :ensure t
  :hook ((csharp-mode) . indent-bars-mode)
  :custom (indent-bars-width-frac 0.1))

(use-package ultra-scroll
  :ensure t
  :vc (:url "https://github.com/jdtsmith/ultra-scroll" :rev :newest)
  ;:load-path "~/code/emacs/ultra-scroll" ; if you git clone'd instead of package-vc-install
  :init
  (setq scroll-conservatively 101 ; important!
        scroll-margin 0)
  :config
  (ultra-scroll-mode 1))

;;(fido-mode 1)
;;(fido-vertical-mode 1)
(setq completion-styles '(basic substring partial-completion flex))

(provide '00-ui)

;;; 00-ui.el ends here
