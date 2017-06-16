;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     bibtex
     (c-c++ :variables c-c++-enable-clang-support t)
     better-defaults
     emacs-lisp
     octave
     git
     helm
     html
     javascript
     latex
     lua
     markdown
     org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     php
     python
     shell-scripts
     spell-checking
     syntax-checking
     systemd
     (version-control :variables version-control-diff-tool 'diff-hl)

     mu4e


     ;; Personal config layers
     paw-python
     paw-func
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(helm-flycheck helm-ag multiple-cursors)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner nil
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '(bookmarks (recents . 10)
                                          (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes
   '(monokai zenburn spacemacs-dark spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 10
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize t
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header t
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state t
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'changed
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (setq-default
   require-final-newline t
   )

  ;; Backups
  backup-directory-alist `((".*" . ,temporary-file-directory))
  auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
  backup-by-copying t
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  make-backup-files nil

  ;; Shell
  ;; shell-default-term-shell "/bin/zsh"
  (add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
  (setq-default dotspacemacs-configuration-layers
                '((mu4e :variables
                        mu4e-installation-path "/usr/share/emacs/site-lisp")))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  (defun my-line-copy()
    "Copy the line that point is on and move to the beginning of the next line.
    Consecutive calls to this command append each line to the
    kill-ring."
    (interactive)
    (if (eq mark-active t)
        (progn (mark) (kill-ring-save (region-beginning) (region-end)) (message "my-copy-region"))
      (let ((beg (point)); (line-beginning-position 1)) ; copy whole line instead
            (end (line-beginning-position 2)))
        (if (eq last-command 'quick-copy-line)
            (kill-append (buffer-substring beg end) (< end beg))
          (kill-new (buffer-substring beg end))))
      (beginning-of-line 2)))
  (define-key evil-emacs-state-map (kbd "C-c d") 'my-line-copy)

  ;; Flycheck and clang arugments for syntax checking in C/C++
  (add-hook 'c++-mode-hook
            (lambda ()
              (setq flycheck-clang-language-standard "c++11")
              (setq company-clang-arguments '("-Weverything"))
              (setq company-c-headers-path-user '("../include" "./include" "." "../../include" "../inc" "../../inc"))
              ;;(setq company-c-headers-path-system '("C:/cygwin64/lib/gcc/x86_64-pc-cygwin/5.4.0/include/c++"))
              (setq flycheck-clang-include-path '("../include" "./include" "." "../../include" "../inc" "../../inc"))))
  (add-hook 'c-mode-hook
            (lambda ()
              (setq flycheck-clang-language-standard "gnu99")
              (setq company-clang-arguments '("-Weverything"))
              (setq company-c-headers-path-user '("../include" "./include" "." "../../include" "../inc" "../../inc"))
              ;;(setq company-c-headers-path-system '("C:/cygwin64/lib/gcc/x86_64-pc-cygwin/5.4.0/include"))
              (setq flycheck-clang-include-path '("../include" "./include" "." "../../include" "../inc" "../../inc"))))

  ;; Scroll compilation output to first error
  (setq compilation-scroll-output t)
  (setq compilation-scroll-output #'first-error)

  ;; Make the compilation window close automatically if no errors
  (setq compilation-finish-functions
        (lambda (buf str)
          (if (null (string-match ".*exited abnormally.*" str))
              (progn
                (run-at-time
                 "1 sec" nil 'delete-windows-on
                 (get-buffer-create "*compilation*"))
                (message "No Compilation Errors")))))

  ;; Stop python from complaining when opening a REPL
  (setq python-shell-prompt-detect-failure-warning nil)

  ;; No need for these in the modeline
  (spacemacs|diminish ggtags-mode)
  (spacemacs|diminish which-key-mode)
  (spacemacs|diminish helm-gtags-mode)
  (spacemacs|diminish spacemacs-whitespace-cleanup-mode)

  ;; Start all frames maximized
  (add-to-list 'default-frame-alist '(fullscreen . maximized))

  ;; Miscellaneous
  (add-hook 'text-mode-hook 'auto-fill-mode)
  (add-hook 'python-mode-hook 'auto-fill-mode)

  ;; (define-key evil-normal-state-map (kbd "C-j")
  (define-key evil-emacs-state-map (kbd "C-j")
    (lambda ()
      (interactive)
      (call-interactively 'spacemacs/evil-insert-line-below)
      (evil-next-line)
      (indent-according-to-mode)))

  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)

  ;; use helm for searching in history
  (define-key comint-mode-map (kbd "M-r") 'helm-comint-input-ring)

  ;; (add-hook 'text-mode-hook 'typo-mode)
  (add-hook 'makefile-mode-hook 'whitespace-mode)
  (remove-hook 'prog-mode-hook 'spacemacs//show-trailing-whitespace)

  (use-package helm-flycheck
    :defer t
    :init
    (spacemacs/set-leader-keys "ee" 'helm-flycheck))

  (when window-system (global-unset-key "\C-z"))
  (define-key evil-emacs-state-map (kbd "C-z") 'undo-tree-undo)
  (define-key evil-emacs-state-map (kbd "C-S-z") 'undo-tree-redo)


  ;; Open tags in another buffer
  (global-set-key (kbd "M-:") 'my-goto-tag-other-window)
  (global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
  ;; easy spell check
  (global-set-key (kbd "C-S-<f10>") 'ispell-word)
  (global-set-key (kbd "<f10>") 'flyspell-mode)
  (global-set-key (kbd "S-<f10>") 'ispell-toggle-dictionary)
  (global-set-key (kbd "C-<f10>") 'flyspell-check-previous-highlighted-word)
  (defun flyspell-check-next-highlighted-word ()
    "Custom function to spell check next highlighted word"
    (interactive)
    (flyspell-goto-next-error)
    (ispell-word)
    )
  (global-set-key (kbd "M-<f10>") 'flyspell-check-next-highlighted-word)
  (global-set-key [H-f10]  'flyspell-buffer)

  (global-set-key (kbd "C-*") 'mc/mark-all-symbols-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-symbol-like-this)
  (global-set-key (kbd "C->") 'mc/mark-next-symbol-like-this)
  ;; (global-evil-mc-mode)
  ;; (global-set-key (kbd "C-<") 'evil-mc-make-and-goto-prev-match)
  ;; (global-set-key (kbd "C->") 'evil-mc-make-and-goto-next-match)


  ;; Maybe needed
  ;; configure orgmode support in mu4e
  ;;(require 'org-mu4e)
  ;; when mail is sent, automatically convert org body to HTML
  ;;(setq org-mu4e-convert-to-html t)


  ;; mu4e tags support.
  ;; https://gist.github.com/lgatto/7091552
  (setq
   ;; https://cpbotha.net/2016/09/27/thunderbird-support-of-rfc-3676-formatflowed-is-half-broken/
   mu4e-compose-format-flowed t
   ;; set mu4e as default mail client
   mail-user-agent 'mu4e-user-agent
   ;; root mail directory - can't be switched
   ;; with context, can only be set once
   mu4e-maildir "~/.mail"
   mu4e-attachments-dir "~/Downloads/Attachments"
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
   ;; mu4e-maildir-shortcuTs '(("/Archive"     . ?a)
   ;;                          ("/INBOX"       . ?i)
   ;;                          ("/Sent"        . ?s))

   mu4e-view-show-images t
   mu4e-view-image-max-width 800
   mu4e-html2text-command "w3m -T text/html"
   ;; for mbsync
   mu4e-change-filenames-when-moving t
   mu4e-confirm-quit                 nil
   )

  ;; In mu4e, deleting [d] a file will not only move the file to the Trash, but
  ;; it will also set the trashed flag; thus servers are likely to delete them
  ;; automatically. The following binds the d key to just the move action.
  ;; (fset 'mu4e-move-to-trash "mt")
  ;; (define-key mu4e-headers-mode-map (kbd "d") 'mu4e-move-to-trash)
  ;; (define-key mu4e-view-mode-map (kbd "d") 'mu4e-move-to-trash)

  ;; use org structures and tables in message mode
  (add-hook 'message-mode-hook 'turn-on-orgtbl)
  (add-hook 'message-mode-hook 'turn-on-orgstruct++)
  (with-eval-after-load 'mu4e
    ;; mu4e context for each IMAP Account
    (setq
     ;; if nil: use current context for new mail
     mu4e-compose-context-policy 'ask-if-none
     ;; pick first context automatically on launch
     mu4e-context-policy 'pick-first
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
                 ;;(mu4e-inbox-folder . "/gmail/Inbox")
                 ;;(mu4e-sent-folder .  "/gmail/sent")
                 ;;(mu4e-trash-folder . "/gmail/trash")
                 ;; account details
                 (user-mail-address . "pawsen@gmail.com")
                 (user-full-name . "Paw")
                 (mu4e-user-mail-address-list . ( "pawsen@gmail.com" ))
                 ;;(mu4e-mu-home . "~/.mu-gmail")
                 ;; gmail saves every outgoing message automatically
                 (mu4e-sent-messages-behavior . delete)
                 (mu4e-maildir-shortcuts . (("/gmail.com/INBOX" . ?j)
                                        ;("/gmai/.All Mail" . ?a)
                                            ("/archive-gmail.com/Trash" . ?t)
                                            ("/gmail.com/Drafts" . ?d)))
                 ;; (mu4e-maildir-shortcuts . (("/gmail/Inbox" . ?j)
                 ;;                            ("/gmail/all" . ?a)
                 ;;                            ("/gmail/trash" . ?t)
                 ;;                            ("/gmail/drafts" . ?d)))
                 ;; outbound mail server
                 (smtpmail-smtp-server . "smtp.gmail.com")
                 (smtpmail-smtp-service . 465)
                 (smtpmail-stream-type . ssl)
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
                 ;; outbound mail server
                 (smtpmail-smtp-server . "smtp.student.dtu.dk")
                 (smtpmail-smtp-service . 465)
                 (smtpmail-stream-type . ssl)
                 ))))

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
    )


  (defun my/mu4e-org-compose ()
    "Switch to/from mu4e-compose-mode and org-mode"
    (interactive)
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
  ;;(global-set-key “\M-@” ‘my/mu4e-org-compose)
  (define-key evil-emacs-state-map (kbd "M-@") 'my/mu4e-org-compose)
  ;; dont include my Drafts in recent files
  (with-eval-after-load 'recentf-exclude
    (add-to-list 'recentf-exclude
                 '((expand-file-name "~/\\.mail/\\(.*\\)/Drafts/\\.*" )
                   "/tmp\\.*"
                   ))
    )

  )
;;)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   (quote
    (winum unfill pdf-tools tablist powerline spinner key-chord ivy org ht alert log4e gntp markdown-mode skewer-mode simple-httpd json-snatcher json-reformat multiple-cursors js2-mode hydra parent-mode projectile request helm-bibtex parsebib haml-mode gitignore-mode fringe-helper git-gutter+ git-gutter flyspell-correct pos-tip flycheck pkg-info epl flx magit magit-popup git-commit with-editor smartparens iedit anzu evil goto-chg undo-tree highlight php-mode diminish web-completion-data dash-functional tern company bind-map bind-key biblio biblio-core yasnippet packed auctex anaconda-mode pythonic f dash s helm avy helm-core async auto-complete popup package-build yapfify ws-butler window-numbering which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toc-org tagedit systemd spacemacs-theme spaceline smeargle slim-mode scss-mode sass-mode restart-emacs rainbow-delimiters quelpa pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements phpunit phpcbf php-extras php-auto-yasnippets persp-mode pcre2el paradox orgit org-ref org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree mwim mu4e-maildirs-extension mu4e-alert move-text monokai-theme mmm-mode markdown-toc magit-gitflow macrostep lua-mode lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode json-mode js2-refactor js-doc insert-shebang info+ indent-guide ido-vertical-mode hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flycheck helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md flyspell-correct-helm flycheck-pos-tip flx-ido fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu emmet-mode elisp-slime-nav dumb-jump drupal-mode disaster diff-hl define-word cython-mode company-web company-tern company-statistics company-shell company-c-headers company-auctex company-anaconda column-enforce-mode coffee-mode cmake-mode clean-aindent-mode clang-format auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile auctex-latexmk aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
