;;; 98-tools.el -- Tools
;;; Commentary:
;;; Code:

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

(defun to-underscore ()
  "To snake case."
  (interactive)
  (progn (replace-regexp "\\([A-Z]\\)" "_\\1" nil (region-beginning) (region-end))
		 (downcase-region (region-beginning) (region-end))))

(defun word-to-underscore ()
  "Word to snake case."
  (interactive)
  (save-excursion
	(let ((bounds (bounds-of-thing-at-point 'word)))
	  (replace-regexp "\\([A-Z]\\)" "_\\1" nil (1+ (car bounds)) (cdr bounds))
	  (downcase-region (car bounds) (cdr bounds)))))

;;; 98-tools.el ends here
