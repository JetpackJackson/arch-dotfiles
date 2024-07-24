;; arduino mode
(define-derived-mode arduino-mode c++-mode "Arduino")

(use-package eglot :ensure t
    :bind (:map
           eglot-mode-map
           ("C-c c a" . eglot-code-actions)
           ("C-c c o" . eglot-code-actions-organize-imports)
           ("C-c c r" . eglot-rename)
           ("C-c c f" . eglot-format)))
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(scheme-mode . ("guile-lsp-server"))
	       ;(arduino-mode . ("arduino-language-server" "-cli" "arduino-cli" "-clangd" "/usr/bin/clangd"))
	       ))
(add-hook 'scheme-mode-hook 'eglot-ensure) ;; guile-lsp-server
(add-hook 'c++-mode-hook 'eglot-ensure) ;; clangd
(add-hook 'c-mode-hook 'eglot-ensure) ;; clangd
(add-hook 'python-mode-hook 'eglot-ensure) ;; pylsp
(add-hook 'latex-mode-hook 'eglot-ensure) ;; texlab
(add-to-list 'auto-mode-alist '("\\.ino\\'" . arduino-mode))
(setq eglot-autoshutdown t)

(use-package guix :ensure t)
(use-package envrc :ensure t
  :hook (after-init . envrc-global-mode))

;; vertico
(use-package vertico :ensure t
  :custom
  (vertico-count 20) ;; Show more candidates
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init (vertico-mode))
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist :ensure t :init (savehist-mode))

;; corfu
(use-package corfu-terminal :ensure t :demand t :init (corfu-terminal-mode))

;;;; Auto completion example
;;(use-package corfu
;;  :custom
;;  (corfu-auto t)          ;; Enable auto completion
;;  ;; (corfu-separator ?_) ;; Set to orderless separator, if not using space
;;  :bind
;;  ;; Another key binding can be used, such as S-SPC.
;;  (:map corfu-map ("S-SPC" . corfu-insert-separator))
;;  :init
;;  (global-corfu-mode))
;;(use-package orderless
;;  :custom
;;  ;; Configure a custom style dispatcher (see the Consult wiki)
;;  ;; (orderless-style-dispatchers '(+orderless-dispatch))
;;  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
;;  (completion-styles '(orderless basic))
;;  (completion-category-defaults nil)
;;  (completion-category-overrides '((file (styles partial-completion)))))



;;; Manual completion example
;(use-package corfu
;  :custom
;  (corfu-separator ?_) ;; Set to orderless separator, if not using space
;  :bind
;  ;; Configure SPC for separator insertion
;  (:map corfu-map ("SPC" . corfu-insert-separator))
;  :init
;  (global-corfu-mode))

;(use-package corfu
;  ;; TAB-and-Go customizations
;  :custom
;  (corfu-cycle t)           ;; Enable cycling for `corfu-next/previous'
;  (corfu-preselect 'prompt) ;; Always preselect the prompt
;
;  ;; Use TAB for cycling, default is `corfu-complete'.
;  :bind
;  (:map corfu-map
;        ("TAB" . corfu-next)
;        ([tab] . corfu-next)
;        ("S-TAB" . corfu-previous)
;        ([backtab] . corfu-previous))
;
;  :init
;  (global-corfu-mode))

;; corfu
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
                 (eq (current-local-map) read-passwd-map)))))

;; snippets
(use-package yasnippet :ensure t :config (use-package yasnippet-snippets :ensure t) (yas-reload-all))
(add-hook 'c++-mode-hook 'yas-minor-mode)
(add-hook 'c-mode-hook 'yas-minor-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)
;(add-hook 'scheme-mode-hook 'yas-minor-mode)
(add-hook 'latex-mode-hook 'yas-minor-mode)

;; flycheck
(use-package flycheck :ensure t)
