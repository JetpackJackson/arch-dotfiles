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
               '(scheme-mode . ("guile-lsp-server")))
  (add-to-list 'eglot-server-programs
	       '(arduino-mode . ("arduino-language-server" "-cli" "arduino-cli" "-clangd" "/usr/bin/clangd")))
  )
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

;; Returns the parent directory containing a .project.el file, if any,
;; to override the standard project.el detection logic when needed.
;(defun my-project-override (dir)
;  (let ((override (locate-dominating-file dir "manifest.scm")))
;  ;(let ((override (locate-dominating-file dir ".project.el")))
;    (if override
;      (cons 'vc override)
;      nil)))

;; project.el
(use-package project)
  ;; Cannot use :hook because 'project-find-functions does not end in -hook
  ;; Cannot use :init (must use :config) because otherwise
  ;; project-find-functions is not yet initialized.
;  :config
;  (add-hook 'project-find-functions #'my-project-override))

;; vertico
(use-package vertico :ensure t
  :custom
  (vertico-count 20) ;; Show more candidates
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init (vertico-mode))
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist :ensure t :init (savehist-mode))

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
(use-package company :ensure t :config (global-company-mode)
  (setq company-idle-delay 0) (setq company-minimum-prefix-length 2))
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
