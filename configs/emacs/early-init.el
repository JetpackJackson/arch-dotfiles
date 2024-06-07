(set-face-attribute 'default nil :font "Ärzte Sans Mono" :height 120)

(setq inhibit-splash-screen t ;; no thanks
        use-file-dialog nil ;; don't use system file dialog
        tab-bar-new-button-show nil ;; don't show new tab button
        tab-bar-close-button-show nil ;; don't show tab close button
        tab-line-close-button-show nil) ;; don't show tab close button
;; Remove extra UI clutter by hiding the scrollbar, menubar, and toolbar.
(menu-bar-mode -1)
;(tool-bar-mode -1)
;(scroll-bar-mode -1)

(electric-pair-mode t) ;; Automatically insert closing parens
(show-paren-mode 1) ;; Visualize matching parens
;(save-place-mode t) ;;; Automatically save your place in files
;(savehist-mode t) ;;; Save history in minibuffer to keep recent commands easily accessible
;(recentf-mode t) ;;; Keep track of open files
(global-auto-revert-mode t) ;; Keep files up-to-date when they change outside Emacs

; autosave
(auto-save-mode 1)
(auto-save-visited-mode 1)
;(setq auto-save-visited-interval 30)
(setq auto-save-interval 20)

;; set type of line numbering (global variable)
(setq display-line-numbers-type 'relative) 
;; activate line numbering in all buffers/modes
(global-display-line-numbers-mode) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; https://github.com/daedreth/UncleDavesEmacs
(defvar my-term-shell "/bin/fish")
(defadvice kitty (before force-fish)
  (interactive (list my-term-shell)))
(ad-activate 'kitty)
(global-set-key (kbd "<s-return>") 'kitty)

