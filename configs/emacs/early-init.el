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
 (setq ring-bell-function 'ignore))

 ;; fixme
 ;(setq browse-url-firefox-program "librewolf")
 ;(setq browse-url-firefox-new-window-is-tab t)

;; clean up elpa stuff
(setq package-user-dir (string-replace ".config" ".cache" package-user-dir))
(setcar native-comp-eln-load-path
        (string-replace ".config" ".cache" (car native-comp-eln-load-path)))
(require 'xdg) (startup-redirect-eln-cache (expand-file-name "emacs/elpa" (xdg-cache-home)))

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
(setq wl-copy-process nil)
(defun wl-copy (text)
  (setq wl-copy-process (make-process :name "wl-copy"
                                      :buffer nil
                                      :command '("wl-copy" "-f" "-n")
                                      :connection-type 'pipe))
                                      ;:noquery t))
  (process-send-string wl-copy-process text)
  (process-send-eof wl-copy-process))
(defun wl-paste ()
  (if (and wl-copy-process (process-live-p wl-copy-process))
      nil ; should return nil if we're the current paste owner
      (shell-command-to-string "wl-paste -n"))); | tr -d \r")))
(setq interprogram-cut-function 'wl-copy)
(setq interprogram-paste-function 'wl-paste)

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
