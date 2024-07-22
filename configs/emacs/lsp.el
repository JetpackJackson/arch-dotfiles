;; Adds LSP support. Note that you must have the respective LSP
;; server installed on your machine to use it with Eglot. e.g.
;; rust-analyzer to use Eglot with `rust-mode'.
(use-package eglot :ensure t
    ;:hook (prog-mode . eglot-ensure)
    :bind (:map
           eglot-mode-map
           ("C-c c a" . eglot-code-actions)
           ("C-c c o" . eglot-code-actions-organize-imports)
           ("C-c c r" . eglot-rename)
           ("C-c c f" . eglot-format)))
(setq eglot-autoshutdown t)

(use-package vertico
  :custom
  (vertico-count 20) ;; Show more candidates
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init (vertico-mode))
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist :init (savehist-mode))

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
;
(use-package corfu :ensure t :init (global-corfu-mode)
  :custom (corfu-auto t) (corfu-preselect 'prompt)
  :bind (("<TAB>" . completion-at-point)))
;; Enable auto completion and configure quitting
(setq corfu-auto t
      corfu-quit-no-match 'separator) ;; or t


(add-hook 'eshell-mode-hook
          (lambda ()
            (setq-local corfu-auto nil)
            (corfu-mode)))
(setq global-corfu-minibuffer
      (lambda ()
        (not (or (bound-and-true-p mct--active)
                 (bound-and-true-p vertico--input)
                 (eq (current-local-map) read-passwd-map)))))

(use-package yasnippet :ensure t
  :config (use-package yasnippet-snippets :ensure t) (yas-reload-all))
(use-package flycheck :ensure t)
(add-hook 'c++-mode-hook 'yas-minor-mode)
(add-hook 'c-mode-hook 'yas-minor-mode)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'eglot-ensure)

(push 'vertico package-selected-packages)
(push 'savehist package-selected-packages)
(push 'emacs package-selected-packages)
(push 'corfu package-selected-packages)
(push 'corfu-terminal package-selected-packages)
(push 'orderless package-selected-packages)
(push 'eglot package-selected-packages)
(push 'flycheck package-selected-packages)
(push 'yasnippet package-selected-packages)
(push 'yasnippet-snippets package-selected-packages)

(package-install-selected-packages)
