;;; init.el --- Emacs configuration -*- lexical-binding: t -*-

;;; Commentary:

;; Save the contents of this file to ~/.config/emacs/init.el and
;; you're ready to boot up Emacs.

;; Hack this file! One of the best ways to get started with Emacs is
;; to look at other peoples' configurations and extract the pieces
;; that work for you. That's where this configuration started. I
;; encourage you to read through the code in this file and explore the
;; functions and variables using the built-in help system (details
;; below). Happy hacking!

;; "C-<chr>  means hold the CONTROL key while typing the character <chr>.
;; Thus, C-f would be: hold the CONTROL key and type f." (Emacs tutorial)
;;
;; - C-h t: Start the Emacs tutorial
;; - C-h o some-symbol: Describe symbol
;; - C-h C-q: Pull up the quick-help cheatsheet

;;; Code:

;; Performance tweaks for modern machines
;(setq gc-cons-threshold 100000000) ; 100 mb
;(setq read-process-output-max (* 1024 1024)) ; 1mb

;; Add unique buffer names in the minibuffer where there are many
;; identical files. This is super useful if you rely on folders for
;; organization and have lots of files with the same name,
;; e.g. foo/index.ts and bar/index.ts.

; https://www.reddit.com/r/emacs/comments/119mp95/emacs_can_be_heavy_but_still_blazingly_fast/
;(setq use-package-always-defer t)


(require 'uniquify)
;(with-eval-after-load 'uniquify)

;; The `setq' special form is used for setting variables. Remember
;; that you can look up these variables with "C-h v variable-name".
(setq uniquify-buffer-name-style 'forward
      window-resize-pixelwise t
      frame-resize-pixelwise t
      load-prefer-newer t
      backup-by-copying t
      ;; Backups are placed into your Emacs directory, e.g. ~/.config/emacs/backups
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
      ;; I'll add an extra note here since user customizations are important.
      ;; Emacs actually offers a UI-based customization menu, "M-x customize".
      ;; You can use this menu to change variable values across Emacs. By default,
      ;; changing a variable will write to your init.el automatically, mixing
      ;; your hand-written Emacs Lisp with automatically-generated Lisp from the
      ;; customize menu. The following setting instead writes customizations to a
      ;; separate file, custom.el, to keep your init.el clean.
      ;custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;(unless package-archive-contents
;  (package-refresh-contents))
;
;; A quick primer on the `use-package' function (refer to
;; "C-h f use-package" for the full details).
;;
;; (use-package my-package-name
;;   :ensure t    ; Ensure my-package is installed
;;   :after foo   ; Load my-package after foo is loaded (seldom used)
;;   :init        ; Run this code before my-package is loaded
;;   :bind        ; Bind these keys to these functions
;;   :custom      ; Set these variables
;;   :config      ; Run this code after my-package is loaded

(use-package which-key :ensure t :config (which-key-mode))
;(use-package gruvbox-theme :ensure t :config (load-theme 'gruvbox t))
;(use-package monokai-theme :ensure t);:config (load-theme 'monokai t))
(use-package rainbow-delimiters :ensure t :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(push 'which-key package-selected-packages)
;(push 'monokai-theme package-selected-packages)
;(push 'gruvbox-theme package-selected-packages)
(push 'rainbow-delimiters package-selected-packages)


(setq evil-want-keybinding nil)

(use-package evil-leader :config (evil-leader/set-leader "<SPC>") (global-evil-leader-mode))
(push 'evil-leader package-selected-packages)
(evil-leader/set-key
  "f" 'find-file
  "b" 'switch-to-buffer
  "ca" 'eglot-code-action-quickfix
  "mm" 'eglot-find-implementation
  "d" 'kill-buffer)


(use-package evil :ensure t :init (setq evil-want-integration t) :config (evil-mode 1))
(use-package evil-collection :after evil :ensure t :config (evil-collection-init))
(push 'evil package-selected-packages)
(push 'evil-collection package-selected-packages)


;; An extremely feature-rich git client. Activate it with "C-c g".
;(use-package magit
;    :ensure t
;    :bind (("C-c g" . magit-status)))

;; As you've probably noticed, Lisp has a lot of parentheses.
;; Maintaining the syntactical correctness of these parentheses
;; can be a pain when you're first getting started with Lisp,
;; especially when you're fighting the urge to break up groups
;; of closing parens into separate lines. Luckily we have
;; Paredit, a package that maintains the structure of your
;; parentheses for you. At first, Paredit might feel a little
;; odd; you'll probably need to look at a tutorial (linked
;; below) or read the docs before you can use it effectively.
;; But once you pass that initial barrier you'll write Lisp
;; code like it's second nature.
;; http://danmidwood.com/content/2014/11/21/animated-paredit.html
;; https://stackoverflow.com/a/5243421/3606440
;(use-package paredit
;  :ensure t
;  :hook ((emacs-lisp-mode . enable-paredit-mode)
;         (lisp-mode . enable-paredit-mode)
;         (ielm-mode . enable-paredit-mode)
;         (lisp-interaction-mode . enable-paredit-mode)
;         (scheme-mode . enable-paredit-mode)))


(package-install-selected-packages)

; https://github.com/sainnhe/sonokai-vscode/blob/master/themes/sonokai-default.json
; https://nice.github.io/themeforge/
(load "~/.config/emacs/sonokai-theme.el")
(load-theme 'sonokai t)
(load-file "~/.config/emacs/lsp.el")



