(with-eval-after-load 'comint

      ;; save comint history.
      ;; comint is the shell that runs the inferior python interpreter.
      (defun comint-write-history-on-exit (process event)
        "Write comint history of PROCESS when EVENT happened to a file
specified in buffer local var
'comint-input-ring-file-name' (defined in
turn-on-comint-history)."
        (comint-write-input-ring)
        (let ((buf (process-buffer process)))
          (when (buffer-live-p buf)
            (with-current-buffer buf
              (insert (format "\nProcess %s %s" process event))))))

      (defun turn-on-comint-history ()
        "Setup comint history.

When comint process started set buffer local var
'comint-input-ring-file-name', so that a file name is specified
to write and read from comint history.

That 'comint-input-ring-file-name' is buffer local is determined
by the 4th argument to 'add-hook' below.  And localness is
important, because otherwise 'comint-write-input-ring' will find
mentioned var nil."

        (let ((process (get-buffer-process (current-buffer))))
          (when process
            (setq comint-input-ring-file-name
                  (format "~/.emacs.d/.cache/inferior-%s-history"
                          (process-name process)))
            (comint-read-input-ring)
            (set-process-sentinel process
                                  #'comint-write-history-on-exit))))


      ;; When Emacs itself is killed, kill-buffer-hook is not run on individual
      ;;buffers. We can circumvent this problem by adding a hook to kill-emacs-hook
      ;;that traverses the list of all buffers and writes the input ring (if it is
      ;;available) of each buffer to a file.
      (defun mapc-buffers (fn)
        (mapc (lambda (buffer)
                (with-current-buffer buffer
                  (funcall fn)))
              (buffer-list)))

      (defun comint-write-input-ring-all-buffers ()
        (mapc-buffers 'comint-write-input-ring))



  )
