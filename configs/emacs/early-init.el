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
;(setq auto-save-visited-interval 20)
(setq auto-save-interval 5)
(setq auto-save-timeout 3)

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(setq org-agenda-start-on-weekday 0)
(setq org-agenda-files
   '("/home/jet/docs/notes/notes-zettelkasten/agenda.org"))

(c-add-style "1tbs"
         '("java"
           (c-hanging-braces-alist
             (defun-open after)
             (class-open after)
             (inline-open after)
             (block-close . c-snug-do-while)
             (statement-cont)
             (substatement-open after)
             (brace-list-open)
             (brace-entry-open)
             (extern-lang-open after)
             (namespace-open after)
             (module-open after)
             (composition-open after)
             (inexpr-class-open after)
             (inexpr-class-close before)
             (arglist-cont-nonempty))
           (c-offsets-alist
             (access-label . -))))
(setq c-default-style "1tbs")


;; set type of line numbering (global variable)
(setq display-line-numbers-type 'relative)
;; activate line numbering in all buffers/modes
(global-display-line-numbers-mode)

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; https://github.com/daedreth/UncleDavesEmacs
(defvar my-term-shell "/bin/fish")
(defadvice kitty (before force-fish)
  (interactive (list my-term-shell)))
(ad-activate 'kitty)
(global-set-key (kbd "<s-return>") 'kitty)

(defun compileandrun()
  (interactive)
  (save-buffer)
  (compile (concat "g++ "  (file-name-nondirectory (buffer-file-name)) " -o " (file-name-sans-extension   (file-name-nondirectory (buffer-file-name))) " && ./" (file-name-sans-extension  (file-name-nondirectory (buffer-file-name)))) t )
  ;(compile (concat "g++ " (file-name-nondirectory (buffer-file-name)) " && ./a.out") t )
(other-window 1)
(end-of-buffer))
;(add-hook 'c++-mode-hook (lambda () (local-set-key (kbd "<M-r>") #'compileandrun)))


