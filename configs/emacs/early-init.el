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

; clean up elpa stuff
(setq package-user-dir (string-replace ".config" ".cache" package-user-dir))
(setcar native-comp-eln-load-path
        (string-replace ".config" ".cache" (car native-comp-eln-load-path)))
(require 'xdg) (startup-redirect-eln-cache (expand-file-name "emacs/elpa" (xdg-cache-home)))

(electric-pair-mode t) ;; Automatically insert closing parens
(show-paren-mode 1) ;; Visualize matching parens
(save-place-mode t) ;;; Automatically save your place in files
(savehist-mode t) ;;; Save history in minibuffer to keep recent commands easily accessible
(global-auto-revert-mode t) ;; Keep files up-to-date when they change outside Emacs

; autosave
(auto-save-mode 1)
(auto-save-visited-mode 1)
;(setq auto-save-visited-interval 20)
(setq auto-save-interval 5)
(setq auto-save-timeout 3)

; org-mode stuff
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(setq org-agenda-start-on-weekday 0)
(setq org-agenda-files
   '("/home/jet/docs/notes/notes-zettelkasten/agenda.org"))

; code indents
;(setq (c-basic-offset . 4)
; (c-offsets-alist
;  (access-label . -)
;  (inline-open . +)
;  (topmost-intro-cont . c-lineup-topmost-intro-cont)
;  (knr-argdecl-intro . +)
;  (substatement-open . +)
;  (substatement-label . 2)
;  (label . 2)
;  (statement-case-open . 0)
;  (statement-cont . +)
;  (arglist-intro . +)
;  (brace-list-intro . +)
;  (func-decl-cont . +)
;  (defun-open . 0)
;  (class-open . 0)
;  (class-close . 0)
;  (inline-close . 0)
;  (knr-argdecl . 0)
;  (annotation-top-cont . 0)
;  (annotation-var-cont . +)
;  (member-init-intro . +)
;  (member-init-cont . c-lineup-multi-inher)
;  (inher-intro . +)
;  (block-open . 0)
;  (brace-list-open . 0)
;  (brace-list-close . 0)
;  (brace-list-entry . 0)
;  (brace-entry-open . 0)
;  (substatement . +)
;  (do-while-closure . 0)
;  (else-clause . 0)
;  (catch-clause . 0)
;  (arglist-cont c-lineup-gcc-asm-reg 0)
;  (stream-op . c-lineup-streamop)
;  (inclass . +)
;  (cpp-macro-cont . +)
;  (cpp-define-intro c-lineup-cpp-define +)
;  (friend . 0)
;  (objc-method-intro .
;		     [0])
;  (objc-method-args-cont . c-lineup-ObjC-method-args)
;  (objc-method-call-cont c-lineup-ObjC-method-call-colons c-lineup-ObjC-method-call +)
;  (extern-lang-open . 0)
;  (namespace-open . 0)
;  (module-open . 0)
;  (composition-open . 0)
;  (extern-lang-close . 0)
;  (namespace-close . 0)
;  (module-close . 0)
;  (composition-close . 0)
;  (inextern-lang . +)
;  (innamespace . +)
;  (inmodule . +)
;  (incomposition . +)
;  (template-args-cont c-lineup-template-args +)
;  (inlambda . 0)
;  (lambda-intro-cont . +)
;  (inexpr-statement . +)
;  (inexpr-class . +)
;  (topmost-intro . 0)
;  (defun-block-intro . +)
;  (statement . 0)
;  (statement-block-intro . +)
;  (block-close . 0)
;  (case-label . +)
;  (statement-case-intro . +)
;  (defun-close . 0)
;  (c . c-lineup-C-comments)
;  (inher-cont . c-lineup-multi-inher)
;  (string . -1000)
;  (comment-intro . c-lineup-comment)
;  (arglist-cont-nonempty . c-lineup-arglist)
;  (arglist-close . c-lineup-close-paren)
;  (cpp-macro . -1000)))

(setq c-default-style "k&r"
  c-basic-offset 4)
;(c-add-style "1tbs"
;         '("java"
;           (c-hanging-braces-alist
;             (defun-open after)
;             (class-open after)
;             (inline-open after)
;             (block-close . c-snug-do-while)
;             (statement-cont)
;             (substatement-open after)
;             (brace-list-open)
;             (brace-entry-open)
;             (extern-lang-open after)
;             (namespace-open after)
;             (module-open after)
;             (composition-open after)
;             (inexpr-class-open after)
;             (inexpr-class-close before)
;             (arglist-cont-nonempty))
;           (c-offsets-alist
;             (access-label . -))))
;(setq c-default-style "1tbs")

;; set type of line numbering 
(setq display-line-numbers-type 'relative)
;; activate line numbering in all buffers/modes
(global-display-line-numbers-mode)

; recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

; consult stuff
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

; TODO: remove this? or refactor into smth with eshell/flymake-compile
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
