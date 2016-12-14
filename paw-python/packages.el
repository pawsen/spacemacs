(setq paw-python-packages
      '(
        (python :location built-in)
        ))

(defun paw-python/post-init-python ()
  (define-key comint-mode-map (kbd "M-r") 'helm-comint-input-ring)
  (add-hook 'kill-emacs-hook 'comint-write-input-ring-all-buffers)

  ;;The history will be saved calling 'comint-send-eof' (usually C-c C-d).
  (add-hook 'inferior-python-mode-hook 'turn-on-comint-history)
  ;; save also with 'kill-this-buffer'
  (add-hook 'kill-buffer-hook 'comint-write-input-ring)

  )
