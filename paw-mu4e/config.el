(setq
 ;; set mu4e as default mail client
 mail-user-agent 'mu4e-user-agent
 ;; root mail directory - can't be switched
 ;; with context, can only be set once
 mu4e-maildir "~/.mail"
 mu4e-attachments-dir "~/Downloads/Attachments"
 ;; update command
 ;;mu4e-get-mail-command "mbsync -q -a"

 mu4e-get-mail-command "mbsync -q personal:INBOX gmail:INBOX"
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
 ;; for mbsync
 mu4e-change-filenames-when-moving t
 ;; pick first context automatically on launch
 mu4e-context-policy               'pick-first
 ;; use current context for new mail
 mu4e-compose-context-policy       nil
 mu4e-confirm-quit                 nil)

;; mu4e context for each IMAP Account
(setq mu4e-contexts
      `(,(make-mu4e-context
          :name "gmail"
          :match-func (lambda(msg)
                        (when msg
                          (mu4e-message-contact-field-matches msg :to "@gmail.com")))
          :vars '(
                  ;; local directories, relative to mail root
                  (mu4e-sent-folder . "/gmail/[Gmail]/.Sent Mail")
                  (mu4e-drafts-folder . "/gmail/[Gmail]/.Drafts")
                  (mu4e-trash-folder . "/gmail/[Gmail]/.Trash")
                  (mu4e-refile-folder . "/gmail/[Gmail]/.All Mail")
                  ;; account details
                  (user-mail-address . "@gmail.com")
                  (user-full-name . "")
                  (mu4e-user-mail-address-list . ( "@gmail.com" ))
                  ;; gmail saves every outgoing message automatically
                  (mu4e-sent-messages-behavior . delete)
                  (mu4e-maildir-shortcuts . (("/gmail/Inbox" . ?j)
                                             ("/gmail/[Gmail]/.All Mail" . ?a)
                                             ("/gmail/[Gmail]/.Trash" . ?t)
                                             ("/gmail/[Gmail]/.Drafts" . ?d)))
                  ;; outbound mail server
                  (smtpmail-smtp-server . "smtp.gmail.com")
                  ;; outbound mail port
                  (smtpmail-smtp-service . 465)
                  ;; use ssl
                  (smtpmail-stream-type . ssl)
                  ;; the All Mail folder has a copy of every other folder's contents,
                  ;; and duplicates search results, which is confusing
                  (mue4e-headers-skip-duplicates . t)))))
