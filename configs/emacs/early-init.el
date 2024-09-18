;; -*- lexical-binding: t -*-
;; UI and other settings that aren't necessarily related to a package/fit better elsewhere.
(setq package-enable-at-startup nil)

(set-face-attribute 'default nil :font "Ärzte Sans Mono" :height 120)
(setq default-frame-alist '((font . "Ärzte Sans Mono Roman-12")))
;(setq default-frame-alist '((font . "Ärzte Sans-12")))
;(add-to-list 'default-frame-alist '(font . "Ärzte Sans Mono Roman-12"))
;(set-face-background 'default "undefined")

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

;(use-package emacs :ensure t :demand t :init
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
 
 (setq ediff-split-window-function 'split-window-horizontally
       truncate-partial-width-windows t)
 (setq split-width-threshold 100)
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

 ;; EMACS 30
 ;(global-font-lock-mode)
 ;(font-lock-ensure)
(setq-default indent-tabs-mode nil)
(setq tab-always-indent 'complete)

(if (version<= "30.0.60" emacs-version)
    (font-lock-update)
  (message "foo"))

 ;(display-line-numbers--turn-on)
 ;(if (bound-and-true-p 'display-line-numbers-mode)
 ;    (message "foo")
 ;  (display-line-numbers--turn-on))
 
 ;; No sound
 (setq visible-bell t)
 (setq ring-bell-function 'ignore)

 (windmove-default-keybindings 'meta)

 (setq fill-column 80)

 (setq browse-url-firefox-new-window-is-tab t)
 (setq browse-url-firefox-program "librewolf")
 (setq browse-url-generic-program "badwolf")
 (setq org-roam-ui-browser-function 'browse-url-generic)

 (setenv "LANG" "en_US.UTF-8")
 (setenv "LC_ALL" "en_US.UTF-8")

 ;; https://code.whatever.social/exchange/emacs/questions/56214/use-the-terminal-background-color-for-the-emacs-nw
 ;; https://www.reddit.com/r/emacs/comments/10lkwgr/emacsclient_in_terminal_doesnt_show_theme/
 ;; still shows wrong color in some spots
 ;(set-face-background 'default "undefined")
 ;; does not work, need to set TERM outside of emacs
(add-to-list 'term-file-aliases '("foot" . "xterm"))
;)

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
;(setq mode-line-position (list "%7 (%l,%c)"))
(setq mode-line-front-space nil)
(setq evil-mode-line-format '(before . mode-line-front-space))
(defvar jet/ml-separator "    ")
(defun jet/modified-buffer-indicator () "Show buffer status in the mode line."
       (if (buffer-modified-p) "(modified)"
	 "----------"))

(defface mode-line-modified-buffer-id
  ;'((t (:slant italic :foreground "#ffe066" :inherit (mode-line-buffer-id))))
  '((t (:foreground "#ffe066" :inherit (mode-line-buffer-id))))
  "Face used for buffer id part of the mode line when the buffer is modified."
  :group 'mode-line-faces)

(defface mode-line-readonly-buffer-id
  '((t (:foreground "#ff6699" :inherit (mode-line-buffer-id))))
  "Face used for buffer id part of the mode line when the buffer is read-only."
  :group 'mode-line-faces)

;; FIXME errors with special buffers not having a file dir
(defvar trunc-name)
(defun jet/modified-buffer-indicator-colorized (trunc-name) "Show buffer status in the mode line."
       ;(if (buffer-file-name) nil (propertize buffer-file-name 'face 'hide))
       (cond ((buffer-modified-p) (propertize trunc-name 'face 'mode-line-modified-buffer-id))
	     (t (propertize trunc-name 'face 'mode-line-buffer-id))))
(defun jet/dir-indicator-colorized (trunc-name) "Show directory in the mode line with thin font."
       ;(if (buffer-file-name) nil (propertize buffer-file-name 'face 'hide))
       (cond ((buffer-modified-p) (propertize trunc-name 'face 'mode-line-modified-buffer-id))
	     (t (propertize trunc-name 'face '(:foreground "#ffffff"))))) ;:background "#4a4b4f" :inherit normal))))) ;:inherit (mode-line-buffer-id))))))

(defun pretty-buffername ()
  (if buffer-file-truename
      (let* ((cur-dir (file-name-directory buffer-file-truename))
             (two-up-dir (-as-> cur-dir it (or (f-parent it) "") (or (f-parent it) "")))
             (shrunk (shrink-path-file-mixed two-up-dir cur-dir buffer-file-truename)))
        (concat (car shrunk)
                (mapconcat #'identity (butlast (cdr shrunk)) "/")
                (car (last shrunk))))
    (buffer-name)))

;(setq mode-line-format nil)
(setq-default mode-line-format
              '("%e"
		mode-line-front-space ;; evil-mode-line-format displays here
		jet/ml-separator
		(:propertize (buffer-read-only "! " "") face mode-line-readonly-buffer-id)
		;(:eval (jet/modified-buffer-indicator-colorized (pretty-buffername)))
		(:eval (jet/dir-indicator-colorized (shrink-path-dirs (file-name-directory buffer-file-truename))))
		(:eval (jet/modified-buffer-indicator-colorized (buffer-name)))
		;(:eval (shrink-path-dirs (file-name-directory buffer-file-truename)))
		;(:eval (buffer-name))
		jet/ml-separator
		;mode-line-buffer-identification
		mode-line-position
		jet/ml-separator
		;jet/ml-separator
		;jet/ml-separator
		;mode-name
		;jet/ml-separator
		mode-line-modes ;; eat doesn't show mode when using mode-name
		jet/ml-separator
		mode--line-format-right-align
                project-mode-line
		project-mode-line-format
		mode-line-misc-info))

;; https://code.whatever.social/exchange/emacs/questions/3925/hide-list-of-minor-modes-in-mode-line#3928
(defvar hidden-minor-modes ; example, write your own list of hidden minor modes
  '(abbrev-mode            
    auto-fill-function
    flycheck-mode
    flyspell-mode
    company-mode
    evil-collection-unimpaired-mode
    which-key-mode))
(defun purge-minor-modes ()
  (interactive)
  (dolist (x hidden-minor-modes nil)
    (let ((trg (cdr (assoc x minor-mode-alist))))
      (when trg
        (setcar trg "")))))
(add-hook 'after-change-major-mode-hook 'purge-minor-modes)

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

(defun jet/org-insert-link () "bind org insert" (interactive)
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

;; https://code.whatever.social/exchange/emacs/questions/20954/compile-from-parent-directory-in-emacs#20964
(defun my-compile-project ()
  (interactive)
  (let* ((mk-dir (locate-dominating-file (buffer-file-name) "Makefile"))
         (compile-command (concat "make -k -C " (shell-quote-argument mk-dir)))
         (compilation-read-command nil))
    (call-interactively 'compile)))

;; TODO figure out better way + comint or no?
(defun jet/project-compile-build () "Run `make' in the project root."
  (interactive)
  (declare (interactive-only compile))
  (let ((default-directory (project-root (project-current t)))
	;(compile-command (concat "make build"))
        (compilation-buffer-name-function
         (or project-compilation-buffer-name-function
             compilation-buffer-name-function)))
    (compile "make")))

(defun jet/project-compile-tests () "Run tests in the project root."
  (interactive)
  (declare (interactive-only compile))
  (let ((default-directory (project-root (project-current t)))
	;(compile-command (concat "make build"))
        (compilation-buffer-name-function
         (or project-compilation-buffer-name-function
             compilation-buffer-name-function)))
    (compile "make test")))


(defun jet/mode-recompile () "Recompile a project based on its type" (interactive)
  (cond ((bound-and-true-p platformio-mode) (platformio-build buffer-file-name)) ;; if platformio minor mode
	((eq major-mode 'c++-mode) (jet/project-compile-build));(my-compile-project))
	((bound-and-true-p sly-mode) (sly-compile-file))
	((bound-and-true-p eglot-java-mode) (eglot-java-run-main))
	(t (message "recompile command not defined for this mode"))))

(defun jet/mode-upload-run () "Upload/run a project based on its type" (interactive)
  (cond ((bound-and-true-p platformio-mode) (platformio-upload buffer-file-name)) ;; if platformio minor mode
	((eq major-mode 'c++-mode) (jet/project-compile-tests));(my-compile-project))
	((bound-and-true-p sly-mode) (sly-compile-and-load-file))
	((bound-and-true-p eglot-java-mode) (eglot-java-run-main))
	(t (message "upload command not defined for this mode"))))

(defun jet/eval-defun () "Eval functions" (interactive)
  (cond ((eq major-mode 'emacs-lisp-mode) (eval-defun)) 
	((bound-and-true-p sly-mode) (sly-eval-defun))
	((eq major-mode 'org-mode) (org-babel-execute-src-block))
	(t (message "eval function not defined for this mode"))))

(defun eos/add-watchwords ()
  "Highlight `FIXME' and `TODO' in code"
  (font-lock-add-keywords
   nil '(("\\<\\(TODO\\(?:(.*)\\)?:?\\)\\>"  1 'warning prepend)
         ("\\<\\(FIXME\\(?:(.*)\\)?:?\\)\\>" 1 'error prepend)
	 ("\\<\\(WIP\\(?:(.*)\\)?:?\\)\\>" 1 'info-title-2 prepend))))

(defun comment-auto-fill ()
  (setq-local comment-auto-fill-only-comments t)
  (auto-fill-mode 1))

(defun jet/grep-for-tasks () "grep for tasks" (interactive)
  (consult-ripgrep (consult--project-root) "\\(TODO\\|FIXME\\|WIP\\)"))

(defun colorize-compilation-buffer ()
  (require 'ansi-color)
  (ansi-color-apply-on-region compilation-filter-start (point)))

(defun jet/dashboard ()
  (interactive)
  (delete-other-windows)
  (get-buffer (scratch-buffer))
  (other-window 1)
  (split-window-horizontally)
  (get-buffer (recentf-open-files)))
