;; -*- lexical-binding: t -*-
(use-package guix)
;(use-package geiser-guile)

(use-package indent-bars ;:demand t
  :hook ((c++-mode c-mode python-mode rust-mode arduino-mode) . indent-bars-mode))

(use-package arduino-mode :ensure nil
  :init
  (define-derived-mode arduino-mode c++-mode "Arduino")
  ;; can just use a Makefile with pio run
  ;; (use-package platformio-mode
  ;;   :hook ((arduino-mode) . platformio-mode))
  (add-to-list 'auto-mode-alist '("\\.ino\\'" . arduino-mode))
  (add-hook 'platformio-compilation-filter-hook 'colorize-compilation-buffer))

(use-package envrc :hook (after-init . envrc-global-mode))
(use-package fish-mode)
(use-package lua-mode)
(use-package rust-mode
  :hook ((rust-mode) . (lambda () (setq indent-tabs-mode nil))))
;(add-hook 'rust-mode-hook
;          (lambda () (setq indent-tabs-mode nil)))
;(use-package cargo-mode
;  :hook ((rust-mode) . cargo-minor-mode))
(use-package eglot-java
  :config (setq eglot-java-run-main-jvm-args '("--enable-preview"))
  :hook (((java-mode) . 'eglot-java-mode)))
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))

;; https://github.com/emacs-languagetool/eglot-ltex
(use-package eglot-ltex 
  :load-path "~/.cache/emacs/eglot-ltex"
  :init (setq eglot-ltex-server-path "/usr/bin/ltex-ls")
        (setq eglot-ltex-communication-channel 'tcp))

;; lisp goodies
(use-package sly
  :config
  (setq sly-lisp-host "127.0.0.1")
  (setq inferior-lisp-program "sbcl")
  :bind (:map
	 sly-mode-map
	 ("C-c e f" . sly-eval-defun)))

(use-package eglot
  :config (setq eglot-autoshutdown t)
  :bind (:map
           eglot-mode-map
           ("C-c e a" . eglot-code-actions)
           ("C-c e q" . eglot-code-action-quickfix)
           ("C-c e o" . eglot-code-actions-organize-imports)
           ("C-c e r" . eglot-rename)
	   ("C-c e e" . consult-flymake)
           ("C-c e f" . eglot-format))
    :hook (((c++-mode c-mode python-mode latex-mode sh-mode fish-mode bash-ts-mode arduino-mode scheme-mode rust-mode) . 'eglot-ensure)))
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(scheme-mode . ("guile-lsp-server")))
  (add-to-list 'eglot-server-programs
	       '(arduino-mode . ("arduino-language-server" "-cli" "arduino-cli --config-file /home/jet/.config/arduino15/arduino-cli.yaml" "-clangd" "clangd")))
  (add-to-list 'eglot-server-programs
	       '(sh-mode . ("bash-language-server" "start")))
  (add-to-list 'eglot-server-programs
	       '(bash-ts-mode . ("bash-language-server" "start"))))

(add-hook 'prog-mode-hook #'comment-auto-fill)
(add-hook 'prog-mode-hook #'eos/add-watchwords)
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
;; (dolist (mode '(ibuffer-mode-hook
;; 		docview-mode-hook))
;;   (add-hook mode (lambda ()
;; 		   (display-line-numbers-mode -1))))

(dolist (mode '(compilation-mode-hook
		eat-mode-hook
		comint-mode-hook))
  (add-hook mode (lambda ()
		   ;; (display-line-numbers-mode -1)
		   (visual-line-mode))))

;; change autocomplete method based on emacs version
(defun jet/use-corfu ()
  (use-package corfu :init (global-corfu-mode)
    :custom (corfu-auto t) (corfu-preselect 'prompt)
    :bind (("<TAB>" . completion-at-point)))
  ;; Enable auto completion and configure quitting
  (setq corfu-auto t
	corfu-quit-no-match 'separator) ;; or t
  
  ;; corfu in the eshell
  (add-hook 'eshell-mode-hook
            (lambda ()
              (setq-local corfu-auto nil)
              (corfu-mode)))
  ;; make corfu not mess with other stuff
  (setq global-corfu-minibuffer
	(lambda ()
          (not (or (bound-and-true-p mct--active)
                   (bound-and-true-p vertico--input)
                   (eq (current-local-map) read-passwd-map))))))

(defun jet/use-company ()
  (use-package company-c-headers)
  (use-package company :init (global-company-mode) (setq company-idle-delay 0) (setq company-minimum-prefix-length 2))
  (with-eval-after-load 'company
    (define-key company-active-map
		(kbd "TAB")
		#'company-complete-common-or-cycle)
    (define-key company-active-map
		(kbd "<backtab>")
		(lambda ()
                  (interactive)
                  (company-complete-common-or-cycle -1)))))

(if (version< emacs-version "30.0.60")
    (jet/use-company)
  (jet/use-corfu))

;; snippets
(use-package yasnippet :config (use-package yasnippet-snippets) (yas-reload-all)
  :hook ((c++-mode c-mode python-mode latex-mode lua-mode lisp-mode sh-mode conf-unix-mode conf-desktop-mode fish-mode yaml-mode m4-mode rust-mode) . yas-minor-mode))
;(add-hook 'scheme-mode-hook 'yas-minor-mode) ;; TODO check if scheme has snippets elsewhere

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
