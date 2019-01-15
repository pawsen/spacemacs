(use-package org-caldav
  ;; https://github.com/dengste/org-caldav
  :init
  (defvar org-caldav-sync-timer nil
    "Timer that `org-caldav-push-timer' used to reschedule itself, or nil.")
  (defun org-caldav-sync-with-delay (secs)
    (when org-caldav-sync-timer
      (cancel-timer org-caldav-sync-timer))
    (setq org-caldav-sync-timer
      (run-with-idle-timer
       (* 1 secs) nil 'org-caldav-sync)))
  (setq org-caldav-url "https://actual-url-to-your-caldav-server")
  (setq org-caldav-calendar-id "your-org-calendar-name")
  (setq org-caldav-inbox "~/your-inbox-file.org")
  (setq org-caldav-save-directory "~/Calendars")
  (setq org-caldav-files '("~/Master.org"))
  :config
  (setq org-icalendar-alarm-time 1)
  (setq org-icalendar-include-todo t)
  (setq org-icalendar-use-deadline '(event-if-todo event-if-not-todo todo-due))
  (setq org-icalendar-use-scheduled '(todo-start event-if-todo event-if-not-todo))
  (add-hook 'after-save-hook
        (lambda ()
          (when (eq major-mode 'org-mode)
        (org-caldav-sync-with-delay 30))))
  (add-hook 'kill-emacs-hook 'org-caldav-sync)
  :ensure t)
