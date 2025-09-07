;;; package: --- Summary -*- lexical-binding: t; -*-
;;; Commentary:
;; Set up org mode
;;; Code:

(use-package plantuml-mode
  :ensure t)

(setq org-plantuml-jar-path (expand-file-name "/home/denis/Projects/arch/plantuml-mit-1.2025.2.jar"))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t) (emacs-lisp . t) (sql .t)))

(use-package org-modern
  :ensure t
  :hook
  (org-mode . org-modern-mode))

(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)


(defun my-org-extract-and-show-json ()
  "Извлечь JSON из текущей ячейки таблицы и показать с форматированием"
  (interactive)
  (when (org-at-table-p)
    (let* ((element (org-element-at-point))
           (table (org-element-lineage element '(table) t))
           (value (org-table-get (org-table-current-line)
                                (org-table-current-column))))
      (if (and value (string-match-p "[{\\[]" value)) ; Проверка на JSON
          (my-show-formatted-json value)
        (message "Current cell doesn't contain JSON data")))))

(defun my-show-formatted-json (json-string)
  "Показать отформатированный JSON в отдельном буфере"
  (let ((json-buffer (get-buffer-create "*Formatted JSON*")))
    (with-current-buffer json-buffer
      (erase-buffer)
      (insert (my-beautify-json json-string))
      (when (fboundp 'json-mode)
        (json-mode))
      (goto-char (point-min)))
    (display-buffer json-buffer '(display-buffer-pop-up-window . nil))))

(defun my-beautify-json (json-str)
  "Украсить JSON строку"
  (condition-case err
      (let* ((json-object (json-read-from-string json-str))
             (temp-buffer (generate-new-buffer " *json-temp*")))
        (with-current-buffer temp-buffer
          (insert (json-encode json-object))
          (json-pretty-print-buffer)
          (let ((result (buffer-string)))
            (kill-buffer temp-buffer)
            result)))
    (error
     (kill-buffer temp-buffer)
     (format "Error parsing JSON: %s\nOriginal: %s"
             (error-message-string err) json-str))))

(defun my-org-auto-format-json-at-point ()
  "Автоматически форматировать JSON при наведении курсора"
  (interactive)
  (when (org-at-table-p)
    (let ((cell-content (org-table-get-field)))
      (when (and cell-content
                 (or (string-prefix-p "{" cell-content)
                     (string-prefix-p "[" cell-content)))
        (my-show-formatted-json cell-content)))))

;; Автоматический запуск при переходе по таблице
(add-hook 'org-table-follow-field-hook 'my-org-auto-format-json-at-point)

(provide '23-org)
;;; 23-org.el ends here
