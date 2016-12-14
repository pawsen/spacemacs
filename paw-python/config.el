;; ;; Don't use tab for yasnippets, use shift-tab.
;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)

(defvar python-fill-column 80
  "Fill column value for python buffers")


;; Make FlyCheck less pedantic(it uses flake8 as standard)
;; https://flake8.readthedocs.io/en/2.0/config.html
;; https://flake8.readthedocs.io/en/2.0/warnings.html#error-codes
;; The flake8 configuration file is the place where you setup the preferences
;; emacs ~/.config/flake8
;; [flake8]
;; ignore = E221,E501,E203,E202,E272,E251,E211,E222,E701
;; max-line-length = 160
;; exclude = tests/*
;; max-complexity = 10
