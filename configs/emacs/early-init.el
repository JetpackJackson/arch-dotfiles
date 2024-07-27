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

;; clean up elpa stuff
(setq package-user-dir (string-replace ".config" ".cache" package-user-dir))
(setcar native-comp-eln-load-path
        (string-replace ".config" ".cache" (car native-comp-eln-load-path)))
(require 'xdg) (startup-redirect-eln-cache (expand-file-name "emacs/elpa" (xdg-cache-home)))

(electric-pair-mode t) ;; Automatically insert closing parens
(show-paren-mode 1) ;; Visualize matching parens
(save-place-mode t) ;;; Automatically save your place in files
(savehist-mode t) ;;; Save history in minibuffer to keep recent commands easily accessible
(global-auto-revert-mode t) ;; Keep files up-to-date when they change outside Emacs

;; autosave stuff
(auto-save-mode 1)
(auto-save-visited-mode 1)
;(setq auto-save-visited-interval 20)
(setq auto-save-interval 5)
(setq auto-save-timeout 3)

;; ediff
(setq ediff-split-window-function 'split-window-horizontally)
(setq truncate-partial-width-windows t)

;; add file header
(global-set-key (kbd "C-c 0") #'add-file-local-variable-prop-line)

;; org-mode stuff
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c <TAB>") #'org-shiftmetaright)
;(define-key org-mode-map (kbd "C-c <TAB>") #'org-shiftmetaright)
(global-set-key (kbd "C-c <DEL>") #'org-shiftmetaleft)
;(define-key org-mode-map (kbd "C-c <DEL>") #'org-shiftmetaleft)
(setq org-agenda-span 20
      org-agenda-start-on-weekday nil
      org-agenda-start-day "-3d")
(setq org-agenda-files '("/home/jet/docs/notes/notes-zettelkasten/"))
;; Associate all org files with org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; Make the indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)
;; Follow the links
;(setq org-return-follows-link t)
(setq org-capture-templates
      '(    
        ("g" "General To-Do"
         entry (file+headline "~/docs/notes/notes-zettelkasten/todo.org" "General Tasks")
         "* TODO [#B] %?\n:Created: %T\n "
         :empty-lines 0)
      ))
(setq org-capture-templates
      '(    
        ("c" "Code To-Do"
         entry (file+headline "~/docs/notes/notes-zettelkasten/todo.org" "Code Related Tasks")
         "* TODO [#B] %?\n:Created: %T\n%a\nProposed Solution: "
         :empty-lines 0)
        ))
;; TODO states
(setq org-todo-keywords
      '((sequence "TODO(t)" "PLANNING(p)" "IN-PROGRESS(i@/!)" "VERIFYING(v!)" "BLOCKED(b@)"  "|" "DONE(d!)" "OBE(o@!)" "WONT-DO(w@/!)" )
        ))
;; TODO colors
(setq org-todo-keyword-faces
      '(
        ("TODO" . (:foreground "GoldenRod" :weight bold))
        ("PLANNING" . (:foreground "DeepPink" :weight bold))
        ("IN-PROGRESS" . (:foreground "Cyan" :weight bold))
        ("VERIFYING" . (:foreground "DarkOrange" :weight bold))
        ("BLOCKED" . (:foreground "Red" :weight bold))
        ("DONE" . (:foreground "LimeGreen" :weight bold))
        ("OBE" . (:foreground "LimeGreen" :weight bold))
        ("WONT-DO" . (:foreground "LimeGreen" :weight bold))
        ))

;; https://stackoverflow.com/questions/4872088/is-there-any-way-for-subtasks-to-inherit-deadlines-in-org-mode
(defun org-insert-sub-task ()
  (interactive)
  (let ((parent-deadline (org-get-deadline-time nil)))
    (org-goto-sibling)
    (org-insert-todo-subheading t)
    (when parent-deadline
      (org-deadline nil parent-deadline))))
;(define-key org-mode-map (kbd "C-c s") #'org-insert-sub-task)
(global-set-key (kbd "C-c s") 'org-insert-sub-task)
(setq org-enforce-todo-dependencies t)
(setq org-agenda-dim-blocked-tasks 'invisible)

;; code indents
(setq c-default-style "k&r"
  c-basic-offset 4)
;; testing
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

;; set type of line numbering 
(setq display-line-numbers-type 'relative)
;; activate line numbering in all buffers/modes
(global-display-line-numbers-mode)

;; recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

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
