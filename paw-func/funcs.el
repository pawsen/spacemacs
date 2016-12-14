(defun my-insert-coding (&optional arg)
  "Insert coding in the top of the script."
  (interactive)
  (save-excursion ; save current buffer and point.
    (goto-char 1) ; goto top of document
  ;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Specifying-File-Variables.html
    (insert "-*- coding: utf-8 -*-\n")
    (goto-char 1)
    ;; insert comment - because some comments needs to be terminated, I use
    ;; (comment-region) instead of (comment-insert-comment-function). See also
    ;; (comment-dwim)
    (let ((start (line-beginning-position))
          (end (line-end-position)))
      (comment-region start end))
    (end-of-line)
    ))


(defun my-insert-python ()
  "Insert coding and python in the top of the script."
  (interactive)
  (my-insert-coding)
  (save-excursion ; save current buffer and point.
    (goto-line 1) ; insert python exp after coding
    (insert "#!/usr/bin/env python3\n"))
  )


;; Code to toggle languages
(defun ispell-toggle-dictionary()
  (interactive)
  ;; ispell-current-dictionary is not a valid call any more.
  (let* ((dic ispell-current-dictionary)
         (change (if (string= dic "danish") "english" "danish")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(defun align-regexp-repeated (start stop regexp)
  "Like align-regexp, but repeated for multiple columns. See
http://www.emacswiki.org/emacs/AlignCommands"
  (interactive "r\nsAlign regexp: ")
  (let ((spacing 1)
        (old-buffer-size (buffer-size)))
    ;; If our align regexp is just spaces, then we don't need any
    ;; extra spacing.
    (when (string-match regexp " ")
      (setq spacing 0))
    (align-regexp start stop
                  ;; add space at beginning of regexp
                  (concat "\\([[:space:]]*\\)" regexp)
                  1 spacing t)
    ;; modify stop because align-regexp will add/remove characters
    (align-regexp start (+ stop (- (buffer-size) old-buffer-size))
                  ;; add space at end of regexp
                  (concat regexp "\\([[:space:]]*\\)")
                  1 spacing t)))
