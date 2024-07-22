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

; https://www.reddit.com/r/emacs/comments/119mp95/emacs_can_be_heavy_but_still_blazingly_fast/
(setq use-package-always-defer t)

;; Add unique buffer names in the minibuffer where there are many
;; identical files. This is super useful if you rely on folders for
;; organization and have lots of files with the same name,
;; e.g. foo/index.ts and bar/index.ts.
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

;(use-package telephone-line :ensure t :demand t)
;(setq telephone-line-lhs
;      '((evil   . (telephone-line-evil-tag-segment))
;        (accent . (telephone-line-vc-segment
;                   telephone-line-erc-modified-channels-segment
;                   telephone-line-process-segment))
;        (nil    . (telephone-line-minor-mode-segment
;                   telephone-line-buffer-segment))))
;(setq telephone-line-rhs
;      '((nil    . (telephone-line-misc-info-segment))
;        (accent . (telephone-line-major-mode-segment))
;        (evil   . (telephone-line-airline-position-segment))))
;(telephone-line-mode 1)
;(push 'telephone-line package-selected-packages)

(use-package doom-modeline :ensure t :demand t :init (doom-modeline-mode 1))
(setq doom-modeline-buffer-file-name-style 'relative-from-project)
(setq doom-modeline-icon nil)
(setq doom-modeline-buffer-state-icon 1)
(push 'doom-modeline package-selected-packages)

(use-package which-key :ensure t :config (which-key-mode))
(use-package rainbow-delimiters :ensure t :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(push 'which-key package-selected-packages)
(push 'rainbow-delimiters package-selected-packages)

(setq evil-want-keybinding nil)
(use-package evil-leader :demand t :config (evil-leader/set-leader "<SPC>") (global-evil-leader-mode)
(evil-leader/set-key
  "f" 'find-file
  "v" 'list-buffers
  "b" 'switch-to-buffer
  "ca" 'eglot-code-action-quickfix
  "cn" 'flymake-goto-next-error
  "d" 'kill-buffer
  "g" 'bookmark-jump
  "r" 'recompile))
;(global-set-key (kbd "C-c r") 'recompile)
(use-package evil :ensure t :demand t :init (setq evil-want-integration t) :config (evil-mode 1))
(use-package evil-collection :after evil :ensure t :demand t :config (evil-collection-init))
(use-package evil-terminal-cursor-changer :ensure t :demand t)
  (unless (display-graphic-p)
          (require 'evil-terminal-cursor-changer)
          (evil-terminal-cursor-changer-activate))
(push 'evil-leader package-selected-packages)
(push 'evil package-selected-packages)
(push 'evil-collection package-selected-packages)
(push 'evil-terminal-cursor-changer package-selected-packages)

(use-package magit
    :ensure t
    :bind (("C-c g" . magit-status)))
(push 'magit package-selected-packages)

(package-install-selected-packages)

; https://github.com/sainnhe/sonokai-vscode/blob/master/themes/sonokai-default.json
; https://nice.github.io/themeforge/
(load "~/.config/emacs/sonokai-theme.el")
(load-theme 'sonokai t)
(load-file "~/.config/emacs/lsp.el")
(load-file "~/.config/emacs/consult.el")
;(load-file "~/.config/emacs/jabber.el")
