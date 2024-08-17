;; -*- lexical-binding: t -*-
;; UI and other settings that aren't necessarily related to a package/fit better elsewhere.
(set-face-attribute 'default nil :font "Ärzte Sans Mono" :height 120)
(setq initial-scratch-message "
; .`                             `.
; `--..```..`           `..```..--`
;   .-:///-:::.       `-:::///:-.
;      ````.:::`     `:::.````
;           -//:`    -::-
;            ://:   -::-
;            `///- .:::`
;             -+++-:::.
;              :+/:::-
;              `-....`
;
;        Welcome to GNU Emacs!
;
; This buffer is for text that is not
;   saved, and for Lisp evaluation.
;   To create a file, visit it with
; SPC f and enter text in its buffer.


")

(use-package emacs :ensure t :demand t :init
;; Performance tweaks for modern machines
;(setq gc-cons-threshold 100000000) ; 100 mb
;(setq read-process-output-max (* 1024 1024)) ; 1mb

 ;; https://www.reddit.com/r/emacs/comments/119mp95/emacs_can_be_heavy_but_still_blazingly_fast/
 (setq use-package-always-defer t)
 (setq uniquify-buffer-name-style 'forward
       window-resize-pixelwise t
       frame-resize-pixelwise t
       load-prefer-newer t
       backup-by-copying t
       ;; Backups are placed into your Emacs directory, e.g. ~/.config/emacs/backups
       backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
       ;; put M-x customize changes into a separate file
       custom-file (expand-file-name "custom.el" user-emacs-directory))

 (electric-pair-mode t) ;; Automatically insert closing parens
 (show-paren-mode 1) ;; Visualize matching parens
 (save-place-mode t) ;;; Automatically save your place in files
 (savehist-mode t) ;;; Save history in minibuffer to keep recent commands easily accessible
 (global-auto-revert-mode t) ;; Keep files up-to-date when they change outside Emacs
 
 (auto-save-mode 1)
 (auto-save-visited-mode 1)
 (setq auto-save-interval 5)
 (setq auto-save-timeout 3)
 
 (setq display-line-numbers-type 'relative)
 (global-display-line-numbers-mode)
 
 (recentf-mode 1)
 (setq recentf-max-menu-items 10)
 (setq recentf-max-saved-items 10)
 
 (setq ediff-split-window-function 'split-window-horizontally
       truncate-partial-width-windows t)
 (setq eldoc-echo-area-use-multiline-p nil) ;; make eldoc quieter
 (global-eldoc-mode -1) ;; disable eldoc instead

 (setq inhibit-splash-screen t ;; no thanks
       use-file-dialog nil ;; don't use system file dialog
       tab-bar-new-button-show nil ;; don't show new tab button
       tab-bar-close-button-show nil ;; don't show tab close button
       tab-line-close-button-show nil) ;; don't show tab close button
 ;; Remove extra UI clutter by hiding the scrollbar, menubar, and toolbar.
 (menu-bar-mode -1)
 (tool-bar-mode -1)
 (scroll-bar-mode -1)
 
 ;; No sound
 (setq visible-bell t)
 (setq ring-bell-function 'ignore)

 (windmove-default-keybindings 'meta)

 (setq fill-column 80)

 ;; https://code.whatever.social/exchange/emacs/questions/56214/use-the-terminal-background-color-for-the-emacs-nw
 ;; https://www.reddit.com/r/emacs/comments/10lkwgr/emacsclient_in_terminal_doesnt_show_theme/
 ;; still shows wrong color in some spots
 ;(set-face-background 'default "undefined")
 ;; does not work, need to set TERM outside of emacs
 (add-to-list 'term-file-aliases '("foot" . "xterm")))

 ;; FIXME
 ;(setq browse-url-firefox-program "librewolf")
 ;(setq browse-url-firefox-new-window-is-tab t)

;; clean up elpa stuff
(setq package-user-dir (string-replace ".config" ".cache" package-user-dir))
(setcar native-comp-eln-load-path
        (string-replace ".config" ".cache" (car native-comp-eln-load-path)))
(require 'xdg) (startup-redirect-eln-cache (expand-file-name "emacs/elpa" (xdg-cache-home)))

;; MODELINE
;; change tag color
(setq evil-normal-state-tag   (propertize "  NORMAL " 'face '((:background "gray35" :foreground "white")))
      evil-emacs-state-tag    (propertize "  EMACS  " 'face '((:background "#444488" :foreground "white")))
      evil-insert-state-tag   (propertize "  INSERT " 'face '((:background "dark sea green" :foreground "black")))
      evil-replace-state-tag  (propertize " REPLACE " 'face '((:background "dark orange" :foreground "black")))
      evil-motion-state-tag   (propertize "  MOTION " 'face '((:background "khaki" :foreground "black")))
      evil-visual-state-tag   (propertize "  VISUAL " 'face '((:background "light salmon" :foreground "black")))
      evil-operator-state-tag (propertize " OPERATE " 'face '((:background "sandy brown" :foreground "black"))))

(setq mode-line-position (list "(%l,%c)"))
(setq mode-line-front-space nil)
(setq evil-mode-line-format '(before . mode-line-front-space))
(defvar my-ml-separator "    ")
(defun my-modified-buffer-indicator () "Show buffer status in the mode line."
       (if (buffer-modified-p) "(modified)"
	 "----------"))

(defface mode-line-modified-buffer-id
  '((t (:slant italic :foreground "#ffe066" :inherit (mode-line-buffer-id))))
  "Face used for buffer id part of the mode line when the buffer is modified."
  :group 'mode-line-faces)

(defface mode-line-readonly-buffer-id
  '((t (:foreground "#ff6699" :inherit (mode-line-buffer-id))))
  "Face used for buffer id part of the mode line when the buffer is read-only."
  :group 'mode-line-faces)

;; TODO
(defun my-modified-buffer-indicator-colorized () "Show buffer status in the mode line."
       (cond ((buffer-modified-p) (propertize "%14b " 'face 'mode-line-modified-buffer-id))
	     ;((buffer-modified-p nil) (propertize "%14b " 'face 'mode-line-buffer-id))
	     (t (propertize "%14b " 'face 'mode-line-buffer-id))))
	     ;(t (propertize "" 'face 'mode-line-buffer-id))))

;(setq mode-line-format nil)
(setq-default mode-line-format
              '("%e"
		mode-line-front-space ;; evil-mode-line-format displays here
		my-ml-separator
		(:propertize (buffer-read-only "! " "") face mode-line-readonly-buffer-id)
		(:eval (my-modified-buffer-indicator-colorized))
		;(:propertize (buffer-read-only ">" "") face mode-line-readonly-buffer-id)
		my-ml-separator
		mode-line-position
		my-ml-separator
		mode-name
		my-ml-separator
		minor-mode-alist))


;;; FUNCTIONS
;; consult stuff ("manual, relay instructions")
(defun consult-info-emacs ()
  "Search through Emacs info pages."
  (interactive)
  (consult-info "emacs" "efaq" "elisp" "cl" "compat"))

(defun consult-info-org ()
  "Search through the Org info page."
  (interactive)
  (consult-info "org"))

(defun consult-info-completion ()
  "Search through completion info pages."
  (interactive)
  (consult-info "vertico" "consult" "marginalia" "orderless" "embark"
                "corfu" "cape" "tempel"))

;; credit: yorickvP on Github
;(setq wl-copy-process nil)
;(defun wl-copy (text)
;  (setq wl-copy-process (make-process :name "wl-copy"
;                                      :buffer nil
;                                      :command '("wl-copy" "-f" "-n")
;                                      :connection-type 'pipe))
;                                      ;:noquery t))
;  (process-send-string wl-copy-process text)
;  (process-send-eof wl-copy-process))
;(defun wl-paste ()
;  (if (and wl-copy-process (process-live-p wl-copy-process))
;      nil ; should return nil if we're the current paste owner
;      (shell-command-to-string "wl-paste -n"))); | tr -d \r")))
;(setq interprogram-cut-function 'wl-copy)
;(setq interprogram-paste-function 'wl-paste)

;(defun wl-copy (text)
;  (let ((p (make-process :name "wl-copy"
;                         :command '("wl-copy")
;                         :connection-type 'pipe)))
;    (process-send-string p text)
;    (process-send-eof p)))
;(setq interprogram-cut-function 'wl-copy)

;; https://stackoverflow.com/questions/4872088/is-there-any-way-for-subtasks-to-inherit-deadlines-in-org-mode
(defun org-insert-sub-task ()
  (interactive)
  (let ((parent-deadline (org-get-deadline-time nil)))
    (org-goto-sibling)
    (org-insert-todo-subheading t)
    (when parent-deadline
      (org-deadline nil parent-deadline))))

(defun my-org-insert-link () "bind org insert" (interactive)
   (let ((current-prefix-arg '(4))) (call-interactively #'org-insert-link)))

;; Returns the parent directory containing a .project.el file, if any,
;; to override the standard project.el detection logic when needed.
(defun my-project-override (dir)
  (let ((override (locate-dominating-file dir "manifest.scm")))
  ;(let ((override (locate-dominating-file dir ".project.el")))
    (if override
      (cons 'vc override)
      nil)))

;; activate platformio-mode when we have an arduino file
(defun turn-on-pio () (platformio-mode 1))
(define-derived-mode arduino-mode c++-mode "Arduino")

(defun my-mode-recompile () "Recompile a project based on its type" (interactive)
  (cond ((bound-and-true-p platformio-mode) (platformio-build buffer-file-name)) ;; if platformio minor mode
	((eq major-mode 'c++-mode) (recompile)) ;; if c++ major mode
	((bound-and-true-p sly-mode) (sly-compile-file))
	(t (message "recompile command not defined for this mode"))))

(defun my-mode-upload-run () "Upload/run a project based on its type" (interactive)
  (cond ((bound-and-true-p platformio-mode) (platformio-upload buffer-file-name)) ;; if platformio minor mode
	((bound-and-true-p sly-mode) (sly-compile-and-load-file))
	(t (message "upload command not defined for this mode"))))

(defun eos/add-watchwords ()
  "Highlight FIXME and TODO in code"
  (font-lock-add-keywords
   nil '(("\\<\\(TODO\\(?:(.*)\\)?:?\\)\\>"  1 'warning prepend)
         ("\\<\\(FIXME\\(?:(.*)\\)?:?\\)\\>" 1 'error prepend)
	 ("\\<\\(WIP\\(?:(.*)\\)?:?\\)\\>" 1 'info-title-2 prepend))))

(defun comment-auto-fill ()
  (setq-local comment-auto-fill-only-comments t)
  (auto-fill-mode 1))
