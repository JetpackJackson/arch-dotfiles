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
 (electric-pair-mode t) ;; Automatically insert closing parens
 (show-paren-mode 1) ;; Visualize matching parens
 (save-place-mode t) ;;; Automatically save your place in files
 (savehist-mode t) ;;; Save history in minibuffer to keep recent commands easily accessible
 (global-auto-revert-mode t) ;; Keep files up-to-date when they change outside Emacs
 
 ;; autosave stuff
 (auto-save-mode 1)
 (auto-save-visited-mode 1)
 (setq auto-save-interval 5)
 (setq auto-save-timeout 3)
 
 (setq display-line-numbers-type 'relative)
 (global-display-line-numbers-mode)
 
 ;; recent files
 (recentf-mode 1)
 (setq recentf-max-menu-items 10)
 (setq recentf-max-saved-items 10)
 
 ;; ediff
 (setq ediff-split-window-function 'split-window-horizontally)
 (setq truncate-partial-width-windows t)

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
)

;; clean up elpa stuff
(setq package-user-dir (string-replace ".config" ".cache" package-user-dir))
(setcar native-comp-eln-load-path
        (string-replace ".config" ".cache" (car native-comp-eln-load-path)))
(require 'xdg) (startup-redirect-eln-cache (expand-file-name "emacs/elpa" (xdg-cache-home)))

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
