;; -*- lexical-binding: t -*-
(use-package guix :ensure t)
(use-package envrc :ensure t :hook (after-init . envrc-global-mode))
(use-package flycheck :ensure t)

;; nice markers for indents
(use-package indent-bars
  :load-path "~/.cache/emacs/indent-bars"
  :hook ((python-mode c++-mode c-mode) . indent-bars-mode))

;; arduino mode
(define-derived-mode arduino-mode c++-mode "Arduino")
(use-package platformio-mode :ensure t)
(defun turn-on-pio () (platformio-mode 1))
(with-eval-after-load 'platformio-mode
  (define-key platformio-mode-map (kbd "C-c r") #'platformio-build)
  (define-key platformio-mode-map (kbd "C-c u") #'platformio-upload))

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
(add-hook 'arduino-mode-hook 'turn-on-pio)
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

;; code indents
(setq c-default-style "k&r"
  c-basic-offset 4)
;; testing
(c-add-style "1tbs"
         '("java"
           (c-hanging-braces-alist
             (defun-open after)
             (class-open after)
             (inline-open after)
             (block-close . c-snug-do-while)
             (statement-cont)
             (substatement-open after)
             (brace-list-open)
             (brace-entry-open)
             (extern-lang-open after)
             (namespace-open after)
             (module-open after)
             (composition-open after)
             (inexpr-class-open after)
             (inexpr-class-close before)
             (arglist-cont-nonempty))
           (c-offsets-alist
             (access-label . -))))
(setq c-default-style "1tbs")
