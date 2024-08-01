;; arduino mode
(define-derived-mode arduino-mode c++-mode "Arduino")

(use-package eglot :ensure t
    :bind (:map
           eglot-mode-map
           ("C-c e a" . eglot-code-actions)
           ("C-c e o" . eglot-code-actions-organize-imports)
           ("C-c e r" . eglot-rename)
           ("C-c e f" . eglot-format)))
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(scheme-mode . ("guile-lsp-server")))
  (add-to-list 'eglot-server-programs
	       '(arduino-mode . ("arduino-language-server" "-cli" "arduino-cli" "-clangd" "/usr/bin/clangd")))
  (add-to-list 'eglot-server-programs
	       '(sh-mode . ("bash-language-server" "start")))
  (add-to-list 'eglot-server-programs
	       '(bash-ts-mode . ("bash-language-server" "start"))))
(add-hook 'scheme-mode-hook 'eglot-ensure) ;; guile-lsp-server
(add-hook 'c++-mode-hook 'eglot-ensure) ;; clangd
(add-hook 'c-mode-hook 'eglot-ensure) ;; clangd
(add-hook 'python-mode-hook 'eglot-ensure) ;; pylsp
(add-hook 'latex-mode-hook 'eglot-ensure) ;; texlab
(add-hook 'sh-mode-hook 'eglot-ensure) ;; bash-language-server
(add-hook 'bash-ts-mode-hook 'eglot-ensure) ;; bash-language-server
(add-to-list 'auto-mode-alist '("\\.ino\\'" . arduino-mode))
(setq eglot-autoshutdown t)

;; corfu
;;(use-package corfu-terminal :ensure t :demand t :init (corfu-terminal-mode))
;;(use-package corfu :ensure t :init (global-corfu-mode)
;;  :custom (corfu-auto t) (corfu-preselect 'prompt)
;;  :bind (("<TAB>" . completion-at-point)))
;;;; Enable auto completion and configure quitting
;;(setq corfu-auto t
;;      corfu-quit-no-match 'separator) ;; or t
;;
;;;; corfu in the eshell
;;(add-hook 'eshell-mode-hook
;;          (lambda ()
;;            (setq-local corfu-auto nil)
;;            (corfu-mode)))
;;;; make corfu not mess with other stuff
;;(setq global-corfu-minibuffer
;;      (lambda ()
;;        (not (or (bound-and-true-p mct--active)
;;                 (bound-and-true-p vertico--input)
;;                 (eq (current-local-map) read-passwd-map)))))

(use-package company-c-headers)
;(add-to-list 'company-backends 'company-c-headers)
;(add-to-list 'company-c-headers-path-system "/usr/include/c++/14.1.1/")
(use-package company :ensure t :init (global-company-mode) (setq company-idle-delay 0) (setq company-minimum-prefix-length 2))
(with-eval-after-load 'company
  (define-key company-active-map
              (kbd "TAB")
              #'company-complete-common-or-cycle)
  (define-key company-active-map
              (kbd "<backtab>")
              (lambda ()
                (interactive)
                (company-complete-common-or-cycle -1))))

;; snippets
(use-package yasnippet :ensure t :config (use-package yasnippet-snippets :ensure t) (yas-reload-all))
(add-hook 'c++-mode-hook 'yas-minor-mode)
(add-hook 'c-mode-hook 'yas-minor-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)
;(add-hook 'scheme-mode-hook 'yas-minor-mode)
(add-hook 'latex-mode-hook 'yas-minor-mode)

;; flycheck
(use-package flycheck :ensure t)
