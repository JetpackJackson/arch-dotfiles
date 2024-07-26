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

;; https://www.reddit.com/r/emacs/comments/119mp95/emacs_can_be_heavy_but_still_blazingly_fast/
(setq use-package-always-defer t)

;; Add unique buffer names in the minibuffer where there are many
;; identical files. This is super useful if you rely on folders for
;; organization and have lots of files with the same name,
;; e.g. foo/index.ts and bar/index.ts.
(require 'uniquify) ;(with-eval-after-load 'uniquify)
;; The `setq' special form is used for setting variables. Remember
;; that you can look up these variables with "C-h v variable-name".
(setq uniquify-buffer-name-style 'forward
      window-resize-pixelwise t
      frame-resize-pixelwise t
      load-prefer-newer t
      backup-by-copying t
      ;; Backups are placed into your Emacs directory, e.g. ~/.config/emacs/backups
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
      ;; I'll add an extra note here since user customizations are important.
      ;; Emacs actually offers a UI-based customization menu, "M-x customize".
      ;; You can use this menu to change variable values across Emacs. By default,
      ;; changing a variable will write to your init.el automatically, mixing
      ;; your hand-written Emacs Lisp with automatically-generated Lisp from the
      ;; customize menu. The following setting instead writes customizations to a
      ;; separate file, custom.el, to keep your init.el clean.
      custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; modeline
(use-package doom-modeline :ensure t :demand t :init (doom-modeline-mode 1))
(setq doom-modeline-buffer-file-name-style 'relative-from-project)
(setq doom-modeline-icon nil)
(setq doom-modeline-buffer-state-icon 1)

;; what key does what
(use-package which-key :ensure t :demand t :config (which-key-mode))

;; colorful parentheses
(use-package rainbow-delimiters :ensure t :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; vim keys
(setq evil-want-keybinding nil)
(use-package evil-leader :ensure t :demand t :config (evil-leader/set-leader "<SPC>") (global-evil-leader-mode)
(evil-leader/set-key
  "f" 'find-file
  "v" 'list-buffers
  "b" 'switch-to-buffer
  "ca" 'eglot-code-action-quickfix
  "cn" 'flymake-goto-next-error
  "d" 'kill-buffer
  "g" 'bookmark-jump
  "r" 'recompile))
(use-package evil :ensure t :demand t :init (setq evil-want-integration t) :config (evil-mode 1))
(use-package evil-collection :after evil :ensure t :demand t :config (evil-collection-init))
(use-package evil-terminal-cursor-changer :ensure t :demand t)
  (unless (display-graphic-p)
          (require 'evil-terminal-cursor-changer)
          (evil-terminal-cursor-changer-activate))

;; a killer git interface
(use-package magit :ensure t
    :bind (("C-c g" . magit-status)))

(use-package indent-bars
  :load-path "~/.cache/emacs/indent-bars"
  :hook ((python-mode c++-mode c-mode) . indent-bars-mode))

(use-package guix :ensure t)
(use-package envrc :ensure t
  :hook (after-init . envrc-global-mode))

;; project.el

;; Returns the parent directory containing a .project.el file, if any,
;; to override the standard project.el detection logic when needed.
;(defun my-project-override (dir)
;  (let ((override (locate-dominating-file dir "manifest.scm")))
;  ;(let ((override (locate-dominating-file dir ".project.el")))
;    (if override
;      (cons 'vc override)
;      nil)))
(use-package project)
  ;; Cannot use :hook because 'project-find-functions does not end in -hook
  ;; Cannot use :init (must use :config) because otherwise
  ;; project-find-functions is not yet initialized.
;  :config
;  (add-hook 'project-find-functions #'my-project-override))
(use-package project-butler :ensure t :demand t)
(customize-set-variable 'project-butler-projects-list
                        '(("~/docs/notes/school/COP3503C/project3-p2/" . ("1|2<" ("src/main.cpp" "src/game_gui.h")))))
;; Replace the binding C-x p k, originally bound to `project-kill-buffers'
(keymap-set project-prefix-map "k" #'project-butler-cleanup)



;; vertico
(use-package vertico :ensure t
  :custom
  (vertico-count 20) ;; Show more candidates
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init (vertico-mode)
  :config (use-package savehist :ensure t :init (savehist-mode))) ;; Persist history over Emacs restarts. Vertico sorts by history position.



;; https://github.com/sainnhe/sonokai-vscode/blob/master/themes/sonokai-default.json
;; https://nice.github.io/themeforge/
(load "~/.config/emacs/sonokai-theme.el")
(load-theme 'sonokai t)
(load-file "~/.config/emacs/lsp.el")
(load-file "~/.config/emacs/consult.el")
;(load-file "~/.config/emacs/jabber.el")
