;; -*- lexical-binding: t -*-
(use-package guix :ensure t)
(use-package envrc :ensure t :hook (after-init . envrc-global-mode))
(use-package flycheck :ensure t)

;; TODO learn how to use
(use-package realgud :ensure t)

;; nice markers for indents
;(use-package indent-bars
;  :load-path "~/.cache/emacs/indent-bars"
;  :hook ((python-mode c++-mode c-mode) . indent-bars-mode))

;; https://code.whatever.social/exchange/emacs/questions/71302/reducing-straight-el-bloat
(setopt package-vc-selected-packages
	'((indent-bars :url "https://github.com/jdtsmith/indent-bars")))
(add-hook 'c++-mode-hook 'indent-bars-mode)
(add-hook 'c-mode-hook 'indent-bars-mode)
(add-hook 'python-mode-hook 'indent-bars-mode)

;; https://wiki.gentoo.org/wiki/User:Schievel/emacs-as-an-ebuild-IDE#ebuild-mode
;; emerge -a app-emacs/ebuild-mode
;; emerge -a app-emacs/ebuild-run-mode
;; emerge -a app-emacs/company-ebuild
;; emerge -a app-emacs/emacs-ebuild-snippets
;; emerge -a app-emacs/nxml-gentoo-schemas

;; assorted modes
(use-package platformio-mode :ensure t)
(use-package fish-mode :ensure t)
(use-package lua-mode :ensure t)
(use-package eglot-java :ensure t
  :config (setq eglot-java-run-main-jvm-args '("--enable-preview")))

;; https://github.com/emacs-languagetool/eglot-ltex
(use-package eglot-ltex 
  ;:hook (text-mode . (lambda () (require 'eglot-ltex) (eglot-ensure)))
  :load-path "~/.cache/emacs/eglot-ltex"
  :init (setq eglot-ltex-server-path "/usr/bin/ltex-ls")
        (setq eglot-ltex-communication-channel 'tcp))         ; 'stdio or 'tcp

;(use-package lsp-ltex :ensure t
;  :hook (text-mode . (lambda () (require 'lsp-ltex) (lsp)))  ; or lsp-deferred
;  :init (setq lsp-ltex-version "15.2.0"))  ; make sure you have set this, see below

(use-package gdb-mi
  :load-path "~/.cache/emacs/emacs-gdb/"
  :init (fmakunbound 'gdb) (fmakunbound 'gdb-enable-debug))


;; lisp goodies
(use-package sly :ensure t
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl")
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
	   ("C-c e e" . consult-flymake) ;; FIXME, dupe keybind
           ("C-c e f" . eglot-format)))
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(scheme-mode . ("guile-lsp-server")))
  (add-to-list 'eglot-server-programs
	       '(arduino-mode . ("arduino-language-server" "-cli" "arduino-cli" "-clangd" "clangd")))
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
(add-hook 'java-mode-hook 'eglot-java-mode)
(add-hook 'arduino-mode-hook 'eglot-ensure)
(add-hook 'arduino-mode-hook 'turn-on-pio)

(add-hook 'scheme-mode-hook 'comment-auto-fill)
(add-hook 'c++-mode-hook 'comment-auto-fill)
(add-hook 'c-mode-hook 'comment-auto-fill)
(add-hook 'python-mode-hook 'comment-auto-fill)
(add-hook 'latex-mode-hook 'comment-auto-fill)
(add-hook 'sh-mode-hook 'comment-auto-fill)
(add-hook 'bash-ts-mode-hook 'comment-auto-fill)
(add-hook 'arduino-mode-hook 'comment-auto-fill)

(add-hook 'compilation-mode-hook 'visual-line-mode)
(add-hook 'comint-mode-hook 'visual-line-mode)
(dolist (mode '(compilation-mode-hook
		eat-mode-hook
		comint-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(add-hook 'compilation-filter-hook 'colorize-compilation-buffer) ;; ansi sequences

(add-hook 'prog-mode-hook #'eos/add-watchwords) ;; highlight custom keywords

(add-to-list 'auto-mode-alist '("\\.ino\\'" . arduino-mode))
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))
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
;(add-hook 'scheme-mode-hook 'yas-minor-mode) ;; check if scheme has snippets elsewhere
(add-hook 'latex-mode-hook 'yas-minor-mode)
(add-hook 'lua-mode-hook 'yas-minor-mode)
(add-hook 'lisp-mode-hook 'yas-minor-mode)
(add-hook 'sh-mode-hook 'yas-minor-mode)
(add-hook 'conf-unix-mode-hook 'yas-minor-mode)
(add-hook 'conf-desktop-mode-hook 'yas-minor-mode)
(add-hook 'fish-mode-hook 'yas-minor-mode)
(add-hook 'yaml-mode-hook 'yas-minor-mode)
(add-hook 'm4-mode-hook 'yas-minor-mode)

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
