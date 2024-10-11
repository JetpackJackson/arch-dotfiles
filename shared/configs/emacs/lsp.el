;; -*- lexical-binding: t -*-
(use-package guix :ensure t)
(use-package envrc :ensure t :hook (after-init . envrc-global-mode))

;; nice markers for indents
(use-package indent-bars :ensure t ;:demand t
  :hook ((c++-mode c-mode python-mode) . indent-bars-mode))

;; assorted modes
(use-package platformio-mode :ensure t)
(use-package fish-mode :ensure t)
(use-package lua-mode :ensure t)
(use-package rust-mode :ensure t)
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))
(use-package cargo-mode :ensure t
  :hook ((rust-mode) . cargo-minor-mode))
(use-package geiser-guile :ensure t)
(use-package eglot-java :ensure t
  :config (setq eglot-java-run-main-jvm-args '("--enable-preview"))
  :hook (((java-mode) . 'eglot-java-mode)))

;; https://github.com/emacs-languagetool/eglot-ltex
(use-package eglot-ltex 
  ;:hook (text-mode . (lambda () (require 'eglot-ltex) (eglot-ensure)))
  :load-path "~/.cache/emacs/eglot-ltex"
  :init (setq eglot-ltex-server-path "/usr/bin/ltex-ls")
        (setq eglot-ltex-communication-channel 'tcp))         ; 'stdio or 'tcp

;; lisp goodies
(use-package sly :ensure t
  :config
  (setq sly-lisp-host "127.0.0.1")
  (setq inferior-lisp-program "sbcl")
  :bind (:map
	 sly-mode-map
	 ("C-c e f" . sly-eval-defun)))

(use-package eglot :ensure t
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
	       '(arduino-mode . ("arduino-language-server" "-cli" "arduino-cli" "-clangd" "clangd")))
  (add-to-list 'eglot-server-programs
	       '(sh-mode . ("bash-language-server" "start")))
  (add-to-list 'eglot-server-programs
	       '(bash-ts-mode . ("bash-language-server" "start"))))

(add-hook 'arduino-mode-hook 'turn-on-pio)
(add-hook 'prog-mode-hook #'comment-auto-fill)
(add-hook 'prog-mode-hook #'eos/add-watchwords) ;; highlight custom keywords
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer) ;; ansi sequences
(dolist (mode '(compilation-mode-hook
		eat-mode-hook
		comint-mode-hook))
  (add-hook mode (lambda ()
		   (display-line-numbers-mode 0)
		   (visual-line-mode))))

(add-to-list 'auto-mode-alist '("\\.ino\\'" . arduino-mode))
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))
(setq eglot-autoshutdown t)

;; change autocomplete method based on emacs version
(defun jet/use-corfu ()
  ;;(use-package corfu-terminal :ensure t :demand t :init (corfu-terminal-mode))
  (use-package corfu :ensure t :init (global-corfu-mode)
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
  (use-package company :ensure t :init (global-company-mode) (setq company-idle-delay 0) (setq company-minimum-prefix-length 2))
  (with-eval-after-load 'company
    (define-key company-active-map
		(kbd "TAB")
		#'company-complete-common-or-cycle)
    (define-key company-active-map
		(kbd "<backtab>")
		(lambda ()
                  (interactive)
                  (company-complete-common-or-cycle -1)))))

(if (version= emacs-version "30.0.60")
    (jet/use-corfu)
  (jet/use-company))

;; snippets
(use-package yasnippet :ensure t :config (use-package yasnippet-snippets :ensure t) (yas-reload-all)
  :hook ((c++-mode c-mode python-mode latex-mode lua-mode lisp-mode sh-mode conf-unix-mode conf-desktop-mode fish-mode yaml-mode m4-mode rust-mode) . yas-minor-mode))
;(add-hook 'scheme-mode-hook 'yas-minor-mode) ;; check if scheme has snippets elsewhere

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
