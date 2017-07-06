
(setq paw-mu4e-packages
      '((mu4e :location site)
        helm-mu
        recentf
        ;; org
        ;;mu4e-maildirs-extension
        )
      )

(defun paw-mu4e/post-init-mu4e ()
  (use-package mu4e
    :if (and (eq system-type 'gnu/linux) (null noninteractive))
    :init
    :bind (("<f2>" . mu4e))
    :ensure f
    :config
    (progn

      ;; Invoke built-in completion but ignore the initial input
      (defun paw/mu4e-completing-read (prompt collection &optional predicate require-match
                                             initial-input hist def inherit-input-method)
        (completing-read prompt collection predicate require-match nil hist def inherit-input-method))

      (setq
       ;; https://cpbotha.net/2016/09/27/thunderbird-support-of-rfc-3676-formatflowed-is-half-broken/
       mu4e-compose-format-flowed t
       ;; set mu4e as default mail client
       mail-user-agent 'mu4e-user-agent
       ;; root mail directory - can't be switched
       ;; with context, can only be set once
       mu4e-maildir "~/.mail"
       mu4e-attachments-dir "~/Downloads/"
       ;; update command
       ;;mu4e-get-mail-command "mbsync -q -a"

       org-mu4e-convert-to-html t
       ;; mu4e-get-mail-command "mbsync -q dtu:Inbox gmail:Inbox"
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
       mu4e-html2text-command "w3m -T text/html"
       ;; for mbsync
       mu4e-change-filenames-when-moving t
       mu4e-confirm-quit nil

       ;; Use helm completion (rather than ido) and ignore the initial completion
       ;; input
       mu4e-completing-read-function 'paw/mu4e-completing-read

       ;; if nil: use current context for new mail
       mu4e-compose-context-policy 'ask-if-none
       ;; pick first context automatically on launch
       mu4e-context-policy 'pick-first
       )

      ;; mu4e context for each IMAP Account
      (setq
       mu4e-contexts
       `(
         ,(make-mu4e-context
           :name "gmail.com"
           :match-func (lambda(msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg :to "pawsen@gmail.com")))
           :vars '(
                   ;;(mu4e-get-mail-command . "mbsync -q gmail.com:inbox")
                   (mu4e-get-mail-command . "mbsync -q gmail.com-inbox")
                   (mu4e-sent-folder . "/gmail.com/Sent")
                   (mu4e-drafts-folder . "/gmail.com/Drafts")
                   (mu4e-trash-folder . "/archive-gmail.com/Trash")
                   (mu4e-refile-folder . "/archive-gmail.com/Archive")
                   ;; account details
                   (user-mail-address . "pawsen@gmail.com")
                   (user-full-name . "Paw")
                   (mu4e-user-mail-address-list . ( "pawsen@gmail.com" ))
                   ;; gmail saves every outgoing message automatically
                   (mu4e-sent-messages-behavior . delete)
                   (mu4e-maildir-shortcuts . (("/gmail.com/INBOX" . ?j)
                                        ;("/gmai/.All Mail" . ?a)
                                              ("/archive-gmail.com/Trash" . ?t)
                                              ("/gmail.com/Drafts" . ?d)))
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
           :name "dtu"
           :match-func (lambda(msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg :to "s082705@student.dtu.dk")))
           :vars '(
                   (mu4e-sent-folder . "/dtu/Sent")
                   (mu4e-drafts-folder . "/dtu/Drafts")
                   (mu4e-trash-folder . "/dtu/Trash")
                   (user-mail-address . "s082705@student.dtu.dk")
                   (user-full-name . "Paw")
                   ;;(mu4e-mu-home . "~/.mu-dtu")
                   (mu4e-user-mail-address-list . ( "s082705@student.dtu.dk" ))
                   (mu4e-get-mail-command . "mbsync -q dtu:Inbox")
                   (mu4e-maildir-shortcuts . (("/dtu/Inbox" . ?j)
                                              ;;("/dtu/all" . ?a)
                                              ("/dtu/Trash" . ?t)
                                              ("/dtu/Drafts" . ?d)))
                   (smtpmail-stream-type . starttls)
                   (smtpmail-default-smtp-server . "smtp.office365.com")
                   (smtpmail-smtp-server . "smtp.office365.com")
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


(defun paw-mu4e/init-helm-mu()
   ;; Use helm for searching
  (use-package helm-mu
    :defer t
    :bind
    (("C-c m" . helm-mu-contacts))
    :config
    (define-key mu4e-main-mode-map "s" 'helm-mu)
    (define-key mu4e-headers-mode-map "s" 'helm-mu)
    (define-key mu4e-view-mode-map "s" 'helm-mu)
    )
)

(defun paw-mu4e/post-init-recentf ()
  ;; dont include my Drafts in recent files
  (use-package recentf
    :defer t
    :config
    ;;(with-eval-after-load 'recentf-exclude
    (add-to-list 'recentf-exclude
               '((expand-file-name "~/\\.mail/\\(.*\\)/Drafts/\\.*" )
                 "/tmp\\.*"
                 ))
    )
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
