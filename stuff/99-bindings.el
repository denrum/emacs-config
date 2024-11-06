(general-create-definer leader-def
  :states 'motion
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "M-SPC")

(general-create-definer prog-def
  :prefix "C-c")

(prog-def
  "a" '(eglot-code-actions :which-key "code actions")
  "r" '(eglot-rename :which-key "reaname")
  "o" '(eglot-code-action-organize-imports :which-key "organize imports")
  "h" '(eldoc :which-key "doc"))

(leader-def
  "f" '(:ignore t :which-key "file")
  "f f" '(counsel-find-file :which-key "find file")
  "f s" '(save-buffer :which-key "save file"))

(leader-def
  "/" 'counsel-rg)

(leader-def
  "k" '(:ignore t :which-key "sexp")
  "k w" '(sp-wrap-round :which-key "wrap ()")
  "k [" '(sp-wrap-square :which-key "wrap []")
  "k {" '(sp-wrap-square :which-key "wrap {}")
  "k ," '(sp-forward-barf-sexp :which-key "<-)")
  "k ." '(sp-forward-slurp-sexp :which-key ")->")
  "k <" '(sp-backward-barf-sexp :which-key "<-(")
  "k >" '(sp-forward-barf-sexp :which-key "(->")
  "k d" '(sp-kill-sexp :which-key "delete sexp")
  "k r" '(sp-raise-sexp :which-key "raise sexp")
  "k y" '(sp-copy-sexp :which-key "copy sexp"))

(leader-def
  "w" '(:ignore t :which-key "window")
  "w v" '(evil-window-vsplit :which-key "split vertically")
  "w s" '(evil-window-split :which-key "split horizontally")
  "w k" '(evil-window-up :which-key "focus ↑")
  "w h" '(evil-window-left :which-key "focus ←")
  "w j" '(evil-window-down :which-key "focus ↓")
  "w l" '(evil-window-right :which-key "focus →")
  "w d" '(delete-window :which-key "delete window"))

(general-define-key
 :keymaps 'ivy-mode-map
 "C-j" 'ivy-next-line
 "C-k" 'ivy-previous-line)

(leader-def
  :keymaps 'emacs-lisp-mode-map
  "m" '(:ignore t :which-key "emacs lisp")
  "m e" '(:ignore t :which-key "eval")
  "m e e" 'eval-last-sexp
  "m e d" 'eval-defun
  "m e b" 'eval-buffer)

(leader-def
  :keymaps 'clojure-mode-map
  "m" '(:ignore t :which-key "clojure")
  "m e" '(:ignore t :which-key "eval")
  "m e e" 'cider-eval-end-of-sexp
  "m e d" 'cider-eval-defun-at-point
  "m c"   'cider-connect-clj
  "m e b" 'cider-eval-buffer
  "m r n" 'cider-repl-set-ns
  "m r r" 'lsp-rename
  "m g g" 'evil-goto-definition
  "m r r" 'lsp-rename
  "m t r" 'cider-test-run-test
  "m t n" 'cider-test-run-ns-tests
  "m d d" 'cider-doc)

(leader-def
  :keymaps 'lisp-mode-map
  "m" '(:ignore t :which-key "common-lisp")
  "m e" '(:ignore t :which-key "eval")
  "m e e" 'slime-eval-last-expression
  "m e d" 'slime-eval-defun
  "m c"   'slime-connect
  "m s"   'slime
  "m e b" 'slime-eval-buffer
  ;;"m r n" 'cider-repl-set-ns
  "m r r" 'lsp-rename
  "m g g" 'evil-goto-definition
  "m r r" 'lsp-rename
  ;;"m t r" 'cider-test-run-test
  ;;"m t n" 'cider-test-run-ns-tests
  "m d d" 'slime-documentation
  "c c" 'slime-fuzzy-completion-in-place)

(leader-def
  :keymaps 'csharp-mode
  "m g g" 'evil-goto-definition)

(leader-def
  "g d" 'xref-find-definitions
  "g b" 'xref-go-back
  "g f" 'xref-go-forward
  "g i" 'eglot-find-implementation)

(leader-def
  "b" '(:ignore t :which-key "buffer")
  "b b" '(ivy-switch-buffer :which-key "switch buffer")
  "b l" '(evil-switch-to-windows-last-buffer :which-key "last buffer")
  "b d" 'kill-current-buffer)

(leader-def
  "c" '(:ignore t :which-key "code")
  "c a" 'eglot-code-actions
  "c l" 'comment-or-uncomment-region
  "c f b" 'eglot-format-buffer
  "c f r" 'eglot-format
  "c w s" 'word-to-underscore
  "c r" 'eglot-rename)

(general-define-key
 "<escape>" 'keyboard-escape-quit)

(leader-def
  ;;"p" 'projectile-command-map
  "p" '(:ignore t :which-key "project")
  "p f" '(projectile-find-file :which-key "find file in project")
  "p g" '(projectile-grep :which-key "grep in project")
  "p a" '(projectile-toggle-between-implementation-and-test :which-key "impl <-> test")
  "p p" '(projectile-switch-project :which-key "switch project"))

(leader-def
  "o" '(:ignore t :which-key "open")
  "o p" 'treemacs
  "o t" 'terminal-frame)

(leader-def
  "SPC" '(execute-extended-command :which-key "M-x"))

(setq which-key-idle-delay 0.5)
(setq which-key-idle-secondary-delay 0)
