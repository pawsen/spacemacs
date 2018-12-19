
(setq paw-mu4e-packages
      '(
        (mu4e :location site)
        recentf
        ;; (org-mime :location site)
        ;; org
        ;;mu4e-maildirs-extension
        )
      )

(defun paw-mu4e/post-init-mu4e ()
  (use-package mu4e
    :init
    (progn
      (setq
       ;; https://cpbotha.net/2016/09/27/thunderbird-support-of-rfc-3676-formatflowed-is-half-broken/
       mu4e-compose-format-flowed t
       ;; set mu4e as default mail client
       mail-user-agent 'mu4e-user-agent
       mu4e-maildir "~/.mail"
       ;;mu4e-get-mail-command "mbsync -q -a"

       org-mu4e-convert-to-html t
       ;; update database every seven minutes
       mu4e-update-interval (* 60 7)
       ;; use smtpmail (bundled with emacs) for sending
       message-send-mail-function 'smtpmail-send-it
       ;; optionally log smtp output to a buffer
       smtpmail-debug-info t
       ;; close sent message buffers
       message-kill-buffer-on-exit t
       ;; customize list columns
       mu4e-headers-fields '((:flags . 4)
                             (:from . 20)
                             (:human-date . 10)
                             (:subject))
       mu4e-view-show-addresses t

       mu4e-view-show-images t
       mu4e-view-prefer-html t
       mu4e-use-fancy-chars t
       mu4e-view-image-max-width 800
       mu4e-html2text-command "iconv -c -t utf-8 | pandoc -f html -t plain"
       ;; for mbsync
       mu4e-change-filenames-when-moving t
       mu4e-confirm-quit nil

       ;; if nil: use current context for new mail
       mu4e-compose-context-policy 'ask-if-none
       ;; pick first context automatically on launch
       mu4e-context-policy 'pick-first
       mu4e-use-maildirs-extension 't
       ))
    :bind (("<f2>" . mu4e))
    :ensure f
    :config
    (progn
      ;; mu4e context for each IMAP Account
      (setq
       mu4e-contexts
       `(
         ,(make-mu4e-context
           :name "gmail"
           :match-func (lambda(msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg :to "pawsen@gmail.com")))
           :vars '(
                   ;;(mu4e-get-mail-command . "mbsync -q gmail.com:inbox")
                   (mu4e-get-mail-command . "mbsync -q gmail")
                   (mu4e-sent-folder . "/gmail/Sent")
                   (mu4e-drafts-folder . "/gmail/Drafts")
                   (mu4e-trash-folder . "/gmail/Trash")
                   ;;(mu4e-refile-folder . "/gmail/Archive")
                   ;; account details
                   (user-mail-address . "pawsen@gmail.com")
                   (user-full-name . "Paw Møller")
                   (mu4e-user-mail-address-list . ( "pawsen@gmail.com" ))
                   ;; gmail saves every outgoing message automatically
                   (mu4e-sent-messages-behavior . delete)
                   (mu4e-maildir-shortcuts . (("/gmail/Inbox" . ?j)
                                              ("/gmail/Liege" . ?l)
                                              ("/gmail/Trash" . ?t)
                                              ("/gmail/Drafts" . ?d)))
                   ;; outbound mail server
                   ;; need gnutls-bin package. ~/.authinfo have the content:
                   ;; machine imap.gmail.com login EMAIL@gmail.com password PASSWORD
                   (smtpmail-stream-type . starttls)
                   (smtpmail-default-smtp-server . "smtp.gmail.com")
                   (smtpmail-smtp-server . "smtp.gmail.com")
                   (smtpmail-smtp-service . 587)

                   ;; the All Mail folder has a copy of every other folder's
                   ;; contents, and duplicates search results, which is confusing
                   (mue4e-headers-skip-duplicates . t)
                   ))
         ,(make-mu4e-context
           :name "ulg"
           :match-func (lambda(msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg :to "pmoller@uliege.be")))
           :vars '(
                   (mu4e-sent-folder . "/ulg/Sent")
                   (mu4e-drafts-folder . "/ulg/Drafts")
                   (mu4e-trash-folder . "/ulg/Trash")
                   (user-mail-address . "pmoller@uliege.be")
                   (user-full-name . "Paw Møller")
                   (mu4e-user-mail-address-list . ("pmoller@uliege.be"))
                   (mu4e-get-mail-command . "mbsync -q ulg")
                   (mu4e-maildir-shortcuts . (("/ulg/Inbox" . ?j)
                                              ;;("/dtu/all" . ?a)
                                              ("/ulg/Trash" . ?t)
                                              ("/ulg/Drafts" . ?d)))
                   (smtpmail-stream-type . starttls)
                   (smtpmail-default-smtp-server . "smtp.ulg.ac.be")
                   (smtpmail-smtp-server . "smtp.ulg.ac.be")
                   (smtpmail-smtp-service . 587)
                   ))
         ))

      (define-key mu4e-main-mode-map "q" 'quit-window)
      (define-key mu4e-main-mode-map "Q" 'mu4e-quit)
      (define-key mu4e-view-mode-map (kbd "C-n") 'org-next-link)
      (define-key mu4e-view-mode-map (kbd "C-p") 'org-previous-link)
      (define-key mu4e-view-mode-map [home] 'beginning-of-visual-line)
      (define-key mu4e-view-mode-map [end] 'end-of-visual-line)

      ;; use org structures and tables in message mode
      (add-hook 'message-mode-hook 'turn-on-orgtbl)
      (add-hook 'message-mode-hook 'turn-on-orgstruct++)

      (add-hook 'mu4e-view-mode-hook #'visual-line-mode)
      (add-hook 'mu4e-compose-mode-hook 'flyspell-mode)
      (add-to-list 'mu4e-view-actions '("view in browser" . mu4e-action-view-in-browser))
      ;; C-c C-a	` attach a file (pro-tip: drag & drop works as well)
      ;; Check for supposed attachments prior to sending an email
      ;; Inspired by https://github.com/munen/emacs.d
      (defvar attachment-regexp "\\([Ww]e send\\|[Ii] send\\|[Jj]eg sender\\|[Vv]i sender\\|[Aa]ttach\\|[Vv]edhæft\\)")
      (defun check-for-attachment nil
        "Check if there is an attachment in the message if I claim it."
        (save-excursion
          (message-goto-body)
          (when (search-forward-regexp attachment-regexp nil t nil)
            (message-goto-body)
            (unless (or (search-forward "<#part" nil t nil)
                        (message-y-or-n-p
                         "No attachment. Send the message ?" nil nil))
              (error "No message sent")))))
      (add-hook 'message-send-hook 'check-for-attachment)

      (defun paw/mu4e-org-compose ()
        (interactive)
        "Switch to/from mu4e-compose-mode and org-mode"
        ;;(if (not (boundp ‘kdm/mu4e-org-html-opt-done))
        (let ((p (point)))
          (goto-char (point-min))
          (let ((case-fold-search t))
            (when (not (search-forward "#+OPTIONS: tex:imagemagick" nil t))
              (goto-char (point-max))
              (insert "\n#+OPTIONS: tex:imagemagick\n#+OPTIONS: toc:0\n")))
          (goto-char p))
        (if (eq 'mu4e-compose-mode (buffer-local-value 'major-mode (current-buffer)))
            (org~mu4e-mime-switch-headers-or-body)
          (mu4e-compose-mode)))
      ;;(define-key mu4e-compose-mode-map (kbd "M-@") 'paw/mu4e-org-compose)
      (define-key evil-emacs-state-map (kbd "M-@") 'paw/mu4e-org-compose)

      ); end of progn

    ); end of use package
  ); end of defun

;;  This could be useful for syncing of all mails instead of the inbox + labels
;; I now don't have an =INBOX= as such instead I've defined a few handy bookmarks
;; mu4e-bookmarks `(("\\\\Inbox" "Inbox" ?i)
;;                  ("flag:flagged" "Flagged messages" ?f)
;;                  (,(concat "flag:unread AND "
;;                            "NOT flag:trashed AND "
;;                            "NOT maildir:/[Gmail].Spam AND "
;;                            "NOT maildir:/[Gmail].Bin")
;;                   "Unread messages" ?u))

(defun paw-mu4e/port-init-org-mime()
   ;; Use helm for searching
  (use-package org-mime
    :defer t
    :config
    (progn
      (setq org-mime-library 'mml)
      (setq org-mime-export-options '(:section-numbers nil
                                      :with-author nil
                                      :with-toc nil))
      (defun htmlize-and-send ()
        "When in an org-mu4e-compose-org-mode message, htmlize and send it."
        (interactive)
        (when (member 'org~mu4e-mime-switch-headers-or-body post-command-hook)
          (org-mime-htmlize)
          (message-send-and-exit)))

      ;; (add-hook 'org-ctrl-c-ctrl-c-hook 'htmlize-and-send t)

      (defun mu4e-compose-org-mail ()
        (interactive)
        (mu4e-compose-new)
        (org-mu4e-compose-org-mode))
      ) ; end of progn
    )
  )

(defun paw-mu4e/post-init-recentf ()
  ;; dont include my Drafts in recent files
  ;; run M-x recentf-cleanup to make it work
  (use-package recentf
    :defer
    :config
    ;;(with-eval-after-load 'recentf-exclude
    (progn
    (add-to-list 'recentf-exclude
                 (recentf-expand-file-name "~/\\.mail/\\(.*\\)/Drafts/" ))
    (add-to-list 'recentf-exclude "/tmp/")
    ))
  )


;; In mu4e, deleting [d] a file will not only move the file to the Trash, but
;; it will also set the trashed flag; thus servers are likely to delete them
;; automatically. The following binds the d key to just the move action.
;; (fset 'mu4e-move-to-trash "mt")
;; (define-key mu4e-headers-mode-map (kbd "d") 'mu4e-move-to-trash)
;; (define-key mu4e-view-mode-map (kbd "d") 'mu4e-move-to-trash)


;; Add printing to list of actions:
;; See function  mu4e-action-view-as-pdf, L54 in mu4e-actions.el
;; This is just an example of some broken lines. Does not work
;; (add-to-list 'mu4e-view-actions
;;              `("Print" .
;;                ,(defun mu4e-action-print (msg)
;;                   "Print the message using muttprint."
;;                   (shell-command-to-string
;;                    (concat "cat "
;;                     (shell-quote-argument (mu4e-message-field msg :path)) " >> /home/paw/msg2.txt"))
;;                   ;(ps-print-buffer-with-faces (buffer-file-name (mu4e-action-view-as-pdf msg)))
;;                   (ps-spool-buffer-with-faces (mu4e-action-view-as-pdf msg))
;;                   ;(mu4e-view-pipe (mu4e-action-view-as-pdf msg))
;;                   ;;(mu4e-view-pipe ">> /home/paw/msg.txt")
;;                   )))
