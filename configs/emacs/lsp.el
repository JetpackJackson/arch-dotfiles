;; Adds LSP support. Note that you must have the respective LSP
;; server installed on your machine to use it with Eglot. e.g.
;; rust-analyzer to use Eglot with `rust-mode'.
(use-package eglot :ensure t)
;  :bind (("<space>-c m" . eglot-find-implementation)
;         ("<space>-c a" . eglot-code-action-quickfix)))
         ;("<SPC>-c-a" . eglot-code-action-quickfix)))
;(keymap-global-set "<SPC> a" . eglot-code-action-quickfix)

(use-package vertico
  :custom
  (vertico-count 20) ;; Show more candidates
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init (vertico-mode))
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))
(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;:custom
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Emacs 28 and newer: Hide commands in M-x which do not work in the current
  ;; mode.  Vertico commands are hidden in normal buffers. This setting is
  ;; useful beyond Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode))

;; Adds intellisense-style code completion at point that works great
;; with LSP via Eglot. You'll likely want to configure this one to
;; match your editing preferences, there's no one-size-fits-all
;; solution.
(use-package corfu :ensure t :init (global-corfu-mode)
  :custom (corfu-auto t)
  ;; You may want to play with delay/prefix/styles to suit your preferences.
  (corfu-auto-delay 0)
  :bind (("<TAB>" . completion-at-point)))
  ;(corfu-auto-prefix 0)
  ;(completion-styles '(basic)))

;; Enable auto completion and configure quitting
(setq corfu-auto t
      corfu-quit-no-match 'separator) ;; or t
(add-hook 'eshell-mode-hook
          (lambda ()
            (setq-local corfu-auto nil)
            (corfu-mode)))
; moved to other section
;(use-package emacs
;  :custom
;  ;; TAB cycle if there are only few candidates
;  (completion-cycle-threshold 3)
;
;  ;; Enable indentation+completion using the TAB key.
;  ;; `completion-at-point' is often bound to M-TAB.
;  (tab-always-indent 'complete))
(setq global-corfu-minibuffer
      (lambda ()
        (not (or (bound-and-true-p mct--active)
                 (bound-and-true-p vertico--input)
                 (eq (current-local-map) read-passwd-map)))))

;(use-package company-c-headers)
;(add-to-list 'company-backends 'company-c-headers)
;(add-to-list 'company-c-headers-path-system "/usr/include/c++/14.1.1/")

;(use-package company :ensure t :config (global-company-mode)
;  ;(setq company-idle-delay nil) (setq company-minimum-prefix-length 3))
;  ;:config
;  (setq company-idle-delay 0) (setq company-minimum-prefix-length 3))
;(with-eval-after-load 'company
;  (define-key company-active-map (kbd "M-n") nil)
;  (define-key company-active-map (kbd "M-p") nil)
;  (define-key company-active-map (kbd "n") #'company-select-next)
;  (define-key company-active-map (kbd "p") #'company-select-previous)
;  (define-key company-active-map (kbd "<tab>") #'company-indent-or-complete-common))

(use-package yasnippet :ensure t ;:init (yas-global-mode)
  :config (use-package yasnippet-snippets :ensure t) (yas-reload-all))
(use-package flycheck :ensure t)
(add-hook 'c++-mode-hook 'yas-minor-mode)
(add-hook 'c-mode-hook 'yas-minor-mode)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'eglot-ensure)

;(push 'company package-selected-packages)
;(push 'company-c-headers package-selected-packages)
(push 'vertico package-selected-packages)
(push 'savehist package-selected-packages)
(push 'emacs package-selected-packages)
(push 'corfu package-selected-packages)
(push 'eglot package-selected-packages)
(push 'flycheck package-selected-packages)
(push 'yasnippet package-selected-packages)
(push 'yasnippet-snippets package-selected-packages)

(package-install-selected-packages)
