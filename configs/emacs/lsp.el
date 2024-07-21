;; Adds LSP support. Note that you must have the respective LSP
;; server installed on your machine to use it with Eglot. e.g.
;; rust-analyzer to use Eglot with `rust-mode'.
(use-package eglot :ensure t)
;  :bind (("<space>-c m" . eglot-find-implementation)
;         ("<space>-c a" . eglot-code-action-quickfix)))
         ;("<SPC>-c-a" . eglot-code-action-quickfix)))
;(keymap-global-set "<SPC> a" . eglot-code-action-quickfix)

;; Adds intellisense-style code completion at point that works great
;; with LSP via Eglot. You'll likely want to configure this one to
;; match your editing preferences, there's no one-size-fits-all
;; solution.
(use-package corfu :ensure t :init (global-corfu-mode)
  :custom (corfu-auto t)
  ;; You may want to play with delay/prefix/styles to suit your preferences.
  (corfu-auto-delay 0)
  (corfu-auto-prefix 0)
  (completion-styles '(basic)))

(use-package company-c-headers)
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-c-headers-path-system "/usr/include/c++/14.1.1/")

(use-package yasnippet :ensure t ;:init (yas-global-mode)
  :config (use-package yasnippet-snippets :ensure t) (yas-reload-all))
(use-package flycheck :ensure t)

(use-package company :ensure t :config (global-company-mode)
;(use-package company :ensure t :config
  ;(setq company-idle-delay nil) (setq company-minimum-prefix-length 3))
  ;:config
  (setq company-idle-delay 0) (setq company-minimum-prefix-length 3))
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "n") #'company-select-next)
  (define-key company-active-map (kbd "p") #'company-select-previous)
  (define-key company-active-map (kbd "<tab>") #'company-indent-or-complete-common))
(add-hook 'c++-mode-hook 'yas-minor-mode)
(add-hook 'c-mode-hook 'yas-minor-mode)

(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'eglot-ensure)

(push 'company package-selected-packages)
(push 'company-c-headers package-selected-packages)
(push 'corfu package-selected-packages)
(push 'eglot package-selected-packages)
(push 'flycheck package-selected-packages)
(push 'yasnippet package-selected-packages)
(push 'yasnippet-snippets package-selected-packages)

(package-install-selected-packages)
