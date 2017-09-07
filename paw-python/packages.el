(setq paw-python-packages
      '(
        (python :location built-in)
        realgud
        ))

(defun paw-python/post-init-python ()
  (use-package python
  :init
  :config
  (progn
    (define-key comint-mode-map (kbd "M-r") 'helm-comint-input-ring)
    (add-hook 'kill-emacs-hook 'comint-write-input-ring-all-buffers)
    (define-key python-mode-map (kbd "C-c h") 'pylookup-lookup)
    (define-key python-mode-map (kbd "C-c f") 'anaconda-mode-show-doc)

    (setq python-shell-interpreter "ipython3")

    ;;The history will be saved calling 'comint-send-eof' (usually C-c C-d).
    (add-hook 'inferior-python-mode-hook 'turn-on-comint-history)
    ;; save also with 'kill-this-buffer'
    (add-hook 'kill-buffer-hook 'comint-write-input-ring)
    )))

(defun paw-python/init-realgud()
  (use-package realgud
    :defer t
    :commands (realgud:pdb)
    :init
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'python-mode
        "dd" 'realgud:pdb
        "de" 'realgud:cmd-eval-dwim)
      (advice-add 'realgud-short-key-mode-setup
                  :before #'spacemacs//short-key-state)
      (evilified-state-evilify-map realgud:shortkey-mode-map
        :eval-after-load realgud
        :mode realgud-short-key-mode
        :bindings
        "s" 'realgud:cmd-next
        "i" 'realgud:cmd-step
        "b" 'realgud:cmd-break
        "B" 'realgud:cmd-clear
        "o" 'realgud:cmd-finish
        "c" 'realgud:cmd-continue
        "e" 'realgud:cmd-eval
        "r" 'realgud:cmd-restart
        "q" 'realgud:cmd-quit
        "S" 'realgud-window-cmd-undisturb-src))))
