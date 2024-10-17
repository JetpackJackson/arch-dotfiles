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
;; - C-h t: Start the Emacs tutorial
;; - C-h o some-symbol: Describe symbol
;; - C-h C-q: Pull up the quick-help cheatsheet

;;; Code:
(require 'use-package)

;;;; use-package :mark-selected
;; Make it possible to kinda manage package-selected-packages' from
;; use-package by adding `:mark-selected' as a keyword...

;; (defcustom use-package-always-mark nil
;;   "If non-nil, assume `:mark-selected t' unless `:mark-selected' is used."
;;   :type 'boolean
;;   :group 'use-package)

;; (defun use-package-normalize/:mark-selected (_name keyword args)
;;   (use-package-only-one (symbol-name keyword)
;;     args #'(lambda (_label arg) (or arg nil))))

;; (defun use-package-handler/:mark-selected (name _keyword arg rest state)
;;   (let ((body (use-package-process-keywords name rest state)))
;;     (if arg (package--update-selected-packages `(,name) '())) body))

;; (add-to-list 'use-package-keywords :mark-selected t) 

;; https://www.reddit.com/r/emacs/comments/119mp95/emacs_can_be_heavy_but_still_blazingly_fast/
(setq use-package-always-defer t
      use-package-always-ensure t)
;use-package-always-mark t

;(require 'use-package)
(setq use-package-compute-statistics t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(use-package emacs :ensure nil
  :config
  (setq window-resize-pixelwise t
      	frame-resize-pixelwise t
     	load-prefer-newer t
	backup-by-copying t
	;; Backups are placed into your Emacs directory, e.g. ~/.config/emacs/backups
	backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
	;; put M-x customize changes into a separate file
	custom-file (expand-file-name "custom.el" user-emacs-directory))
  ;; Automatically insert closing parens
  (electric-pair-mode t) 
  ;; Visualize matching parens
  (show-paren-mode 1) 
  ;; Automatically save your place in files
  (save-place-mode t) 
  ;; Save history in minibuffer to keep recent commands easily accessible
  (savehist-mode t) 
  ;; Keep files up-to-date when they change outside Emacs
  (global-auto-revert-mode t)

  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode)
  ;; No sound
  (setq visible-bell t
	ring-bell-function 'ignore)
  (setq fill-column 100)
  ;; move around with alt+up/down/left/right
  (windmove-default-keybindings 'meta)
  (setq browse-url-firefox-new-window-is-tab t
	browse-url-firefox-program "firefox"
	browse-url-generic-program "badwolf")

  (setenv "LANG" "en_US.UTF-8")
  (setenv "LC_ALL" "en_US.UTF-8")

  ;; https://code.whatever.social/exchange/emacs/questions/56214/use-the-terminal-background-color-for-the-emacs-nw
  ;; https://www.reddit.com/r/emacs/comments/10lkwgr/emacsclient_in_terminal_doesnt_show_theme/
  (add-to-list 'term-file-aliases '("foot" . "xterm"))

  (setq revert-without-query '(".pdf"))

  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function. As an alternative,
  ;; try `cape-dict'.
  (text-mode-ispell-word-completion nil)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

(use-package auto-save :ensure nil
  :init
  (auto-save-mode 1)
  (auto-save-visited-mode 1)
  :config (setq auto-save-interval 5
		auto-save-timeout 3))

(use-package ediff :ensure nil
  :config
  (setq ediff-split-window-function 'split-window-horizontally
	truncate-partial-width-windows t
	ediff-window-setup-function 'ediff-setup-windows-plain
	split-width-threshold 100))

(use-package eldoc :ensure nil
  :config (setq eldoc-echo-area-use-multiline-p nil)) ;; make eldoc quieter

(use-package uniquify :ensure nil
  :config (setq uniquify-buffer-name-style 'forward))

(use-package valign)
(use-package project :ensure nil)
(use-package shrink-path :demand t)
(use-package which-key :demand t :config (which-key-mode))
(use-package rainbow-delimiters :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package magit :bind (("C-c g" . magit-status)))
(use-package eat)
(with-eval-after-load 'eat
  (set-face-attribute 'ansi-color-blue nil :background "#76cce0" :foreground "#76cce0")
  (set-face-attribute 'ansi-color-cyan nil :background "#85d3f2" :foreground "#85d3f2")
  (set-face-attribute 'ansi-color-green nil :background "#9ed072" :foreground "#9ed072")
  (set-face-attribute 'ansi-color-magenta nil :background "#dc8cc3" :foreground "#dc8cc3")
  (set-face-attribute 'ansi-color-red nil :background "#fc5d7c" :foreground "#fc5d7c")
  (set-face-attribute 'ansi-color-yellow nil :background "#e7c664" :foreground "#e7c664")
  (set-face-attribute 'ansi-color-white nil :background "#e2e2e3" :foreground "#e2e2e3"))

;; TODO keep or remove?
;; dired
;; (use-package dirvish :init (dirvish-override-dired-mode)
;;   :custom
;;   (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
;;    '(("g" "~/"                               "home")
;;      ("d" "~/dl/"                            "downloads")
;;      ("m" "/run/media/"                      "drives")
;;      ("t" "~/.cache/mytrash/"                "trash")
;;      ("c" "~/.local/share/"                  "data")
;;      ("n" "~/docs/notes/notes-zettelkasten/" "notes")
;;      ("p" "~/docs/notes/projects/git/"       "projects")
;;      ("s" "~/docs/notes/school/"             "school")))
;;   :config
;;   (dirvish-peek-mode) ; Preview files in minibuffer
;;   (dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
;;   (setq dirvish-open-with-programs
;; 	'((("ape" "stm" "s3m" "ra" "rm" "ram" "wma" "wax" "m3u" "med" "669" "mtm" "m15" "uni" "ult" "mka" "flac" "axa" "kar" "midi" "mid" "s1m" "smp" "smp3" "rip" "multitrack" "ecelp9600" "ecelp7470" "ecelp4800" "vbk" "pya" "lvp" "plj" "dtshd" "dts" "mlp" "eol" "uvva" "uva" "koz" "xhe" "loas" "sofa" "smv" "qcp" "psid" "sid" "spx" "opus" "ogg" "oga" "mp1" "mpga" "m4a" "mxmf" "mhas" "l16" "lbc" "evw" "enw" "evb" "evc" "dls" "omg" "aa3" "at3" "atx" "aal" "acn" "awb" "amr" "ac3" "ass" "aac" "adts" "726" "abs" "aif" "aifc" "aiff" "au" "mp2" "mp3" "mp2a" "mpa" "mpa2" "mpega" "snd" "vox" "wav")
;; 	  "/usr/bin/mpv" "--profile=builtin-pseudo-gui" "%f")
;; 	 (("f4v" "rmvb" "wvx" "wmx" "wmv" "wm" "asx" "mk3d" "mkv" "fxm" "flv" "axv" "webm" "viv" "yt" "s1q" "smo" "smov" "ssw" "sswf" "s14" "s11" "smpg" "smk" "bk2" "bik" "nim" "pyv" "m4u" "mxu" "fvt" "dvb" "uvvv" "uvv" "uvvs" "uvs" "uvvp" "uvp" "uvvu" "uvu" "uvvm" "uvm" "uvvh" "uvh" "ogv" "m2v" "m1v" "m4v" "mpg4" "mp4" "mjp2" "mj2" "m4s" "3gpp2" "3g2" "3gpp" "3gp" "avi" "mov" "movie" "mpe" "mpeg" "mpegv" "mpg" "mpv" "qt" "vbs" "gif")
;; 	  "mpv" "%f")
;; 	 (("jpg" "jpeg" "png" "tga" "webp")
;; 	  "feh" "%f")
;; 	 (("pdf" "epub")
;; 	  "zathura" "%f")
;; 	 (("ods" "odt" "ppt" "pptx" "doc" "docx" "xlsx" "csv")
;; 	  "libreoffice" "%f")))
;;   (setq dirvish-hide-details nil)
;;   (setq dirvish-mode-line-format
;;         '(:left (sort symlink) :right (omit yank index)))
;;   (setq dirvish-attributes
;;         '(file-time file-size collapse subtree-state vc-state git-msg))
;;   (setq delete-by-moving-to-trash t)
;;   (setq dired-listing-switches
;;         "-l --almost-all --human-readable --group-directories-first --no-group")
;;   :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
;;   (("C-c f" . dirvish-fd)
;;    :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
;;    ("g"   . dirvish-quick-access) ;; binds from lf config
;;    ("f"   . dirvish-file-info-menu)
;;    ("y"   . dirvish-yank-menu)
;;    ("N"   . dirvish-narrow)
;;    ("^"   . dirvish-history-last)
;;    ("h"   . dirvish-history-jump) ; remapped `describe-mode'
;;    ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
;;    ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
;;    ("TAB" . dirvish-subtree-toggle)
;;    ("M-f" . dirvish-history-go-forward)
;;    ("M-b" . dirvish-history-go-backward)
;;    ("M-l" . dirvish-ls-switches-menu)
;;    ("M-m" . dirvish-mark-menu)
;;    ("M-t" . dirvish-layout-toggle)
;;    ("M-s" . dirvish-setup-menu)
;;    ("M-e" . dirvish-emerge-menu)
;;    ("M-j" . dirvish-fd-jump)
;;    ("<left>" . dired-up-directory)
;;    ("<right>" . dired-find-file)))

;; path
(use-package exec-path-from-shell :demand t
  :init (when (daemonp)
	  (require 'exec-path-from-shell)
	  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE" "GUILE_LOAD_PATH" "GUILE_LOAD_COMPILED_PATH" "RUSTUP_HOME" "CARGO_HOME"))
	    (add-to-list 'exec-path-from-shell-variables var))
	  (exec-path-from-shell-initialize)))

;; recentf
(use-package recentf :ensure nil :demand t
  :config
  (setq recentf-max-menu-items 10
	recentf-max-saved-items 10
	recentf-exclude '("emacs/bookmarks" "agenda.org" "custom.el" "Makefile" ".gitignore")
	recentf-filename-handlers '(abbreviate-file-name)
	recentf-filter-changer-current '(recentf-arrange-by-dir))
  (recentf-mode 1))

;; vertico
(use-package vertico
  :custom
  (vertico-count 20) ;; Show more candidates
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init (vertico-mode)
  :config (use-package savehist :init (savehist-mode))) ;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

;; https://old.reddit.com/r/emacs/comments/qch2n1/how_can_i_copy_out_of_emacs_in_terminal_mode_with/
;; https://github.com/Crandel/home/blob/master/.config/emacs/recipes/base-rcp.el#L357-L379
(use-package select :ensure nil
  :demand t
  :custom
  (save-interprogram-paste-before-kill t)
  (select-enable-clipboard             t)
  (selection-coding-system             'utf-8)
  :init
  (setq-default wl-copy-process nil)
  (when (string-prefix-p "wayland" (getenv "WAYLAND_DISPLAY"))
    (defun wl-copy-handler (text)
      (setq wl-copy-process (make-process :name "wl-copy"
                                          :buffer nil
                                          :command '("wl-copy" "-f" "-n")
                                          :connection-type 'pipe))
      (process-send-string wl-copy-process text)
      (process-send-eof wl-copy-process))
    (defun wl-paste-handler ()
      (if (and wl-copy-process (process-live-p wl-copy-process))
          nil ; should return nil if we're the current paste owner
        (shell-command-to-string "wl-paste -n | tr -d '\r'")))
    (setq interprogram-cut-function 'wl-copy-handler
          interprogram-paste-function 'wl-paste-handler)))

;; org
(use-package org-fragtog)
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'org-fragtog-mode)

(use-package org :ensure org-contrib ;:demand t
    :bind (:map
           org-mode-map
           ;; ("C-c o e" . org-export-dispatch) ;; C-c C-e
	   ("C-c o f" . org-open-at-point))
  :config (require 'ox-extra) (ox-extras-activate '(ignore-headlines))
  (setq org-roam-ui-browser-function 'browse-url-generic)
  (setq org-latex-listings 'minted
	org-latex-packages-alist '(("" "minted"))
	org-latex-pdf-process
	'("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  (setq org-agenda-span 20
	org-agenda-start-on-weekday nil
	org-agenda-start-day "-3d"
	org-agenda-files '("/home/jet/docs/notes/notes-zettelkasten/agenda/")
	org-enforce-todo-dependencies nil
	org-agenda-dim-blocked-tasks t
	org-M-RET-may-split-line '(default . nil)
	org-babel-lisp-eval-fn #'sly-eval
	org-priority-lowest ?H)
  (setq org-agenda-todo-ignore-with-date t) ;; clean up todo list
  (setq org-image-actual-width nil) ;; shrink images
  (setq org-agenda-inhibit-startup t) ;; https://orgmode.org/manual/Speeding-Up-Your-Agendas.html
  (if (equal (system-name) "weasel")
      (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.00))
    (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.75))))
(with-eval-after-load 'org
  (add-to-list 'org-latex-classes
               '("book"
		 "\\documentclass{book}"
		 ("\\part{%s}" . "\\part*{%s}")
		 ("\\chapter{%s}" . "\\chapter*{%s}")
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t) (emacs-lisp . t) (java . t) (C . t) (lisp . t) (dot . t) (shell . t)))
  (define-key org-mode-map (kbd "C-c <TAB>") #'org-shiftmetaright)
  (define-key org-mode-map (kbd "C-c <DEL>") #'org-shiftmetaleft)
  (define-key org-mode-map (kbd "C-c s") #'org-insert-sub-task)
  (setq org-capture-templates
	'(
	  ("g" "General To-Do"
           entry (file+headline "~/docs/notes/notes-zettelkasten/todo.org" "General Tasks")
           "* TODO [#B] %?\n:Created: %T\n "
           :empty-lines 0)
	  ("c" "Code To-Do"
	   entry (file+headline "~/docs/notes/notes-zettelkasten/todo.org" "Code Related Tasks")
	   "* TODO [#B] %?\n:Created: %T\n%a\nProposed Solution: "
	   :empty-lines 0)))
  ;; todo/task states
  (setq org-todo-keywords
	;; TODO tweak keywords to fit usage
	;; ! means add timestamp, @ adds note w/time
	'((sequence "TODO(t)" "PLANNING(p)" "IN-PROGRESS(i@/!)" "VERIFYING(v!)" "BLOCKED(b@)"  "|" "DONE(d!)" "WONT-DO(w@/!)" )))

  ;; todo/task colors
  (setq org-todo-keyword-faces
	'(
          ("TODO" . (:foreground "GoldenRod" :weight bold))
          ("PLANNING" . (:foreground "DeepPink" :weight bold))
          ("IN-PROGRESS" . (:foreground "Cyan" :weight bold))
          ("VERIFYING" . (:foreground "DarkOrange" :weight bold))
          ("BLOCKED" . (:foreground "Red" :weight bold))
          ("DONE" . (:foreground "LimeGreen" :weight bold))
	  ("WONT-DO" . (:foreground "LimeGreen" :weight bold)))))
(with-eval-after-load 'org-faces
  (set-face-attribute 'org-level-3 nil :foreground "white")
  (set-face-attribute 'org-agenda-done nil :foreground "gray")
  (set-face-attribute 'org-scheduled nil :foreground "green yellow")
  (set-face-attribute 'org-scheduled-today nil :foreground "green yellow"))
  ;(set-face-attribute 'org-special-keyword nil :foreground "lightslategray")

;; does not work in emacs 30, missing compat-macs
;(use-package org-timeblock)

;; ligatures in GUI emacs
(if (display-graphic-p)
    (use-package fira-code-mode
      :custom (fira-code-mode-disabled-ligatures '("[]" "x" ":" "::" ":::"))
      :hook prog-mode))

;; global binds
(global-set-key (kbd "C-c 0") #'add-file-local-variable-prop-line)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c l") #'org-store-link)

;; C-SPC leader key without any packages
;; https://protesilaos.com/codelog/2024-01-29-emacs-prefix-map/
(defvar-keymap test-prefix-org-map
  "c" #'org-capture
  "l" #'org-insert-link)

(defvar-keymap test-prefix-project-map
  "r" #'jet/mode-recompile
  "u" #'jet/mode-upload-run)

(defvar-keymap test-prefix-consult-map
  "f" #'consult-find
  "m" #'jet/grep-for-tasks)

(defvar-keymap test-prefix-map
  "," #'uncomment-region
  "." #'comment-line
  "b" #'consult-buffer
  "c" test-prefix-consult-map
  "d" #'kill-buffer
  "e" #'jet/eval-defun
  "f" #'find-file
  "g" #'consult-bookmark
  "l" #'org-store-link
  "o" test-prefix-org-map
  "p" test-prefix-project-map
  "t" #'eat-other-window
  "v" #'ibuffer-other-window
  "q" #'delete-other-windows)

(global-unset-key (kbd "C-SPC"))
(keymap-set global-map "C-SPC" test-prefix-map)
(global-unset-key (kbd "M-SPC"))
(keymap-set global-map "M-SPC" #'set-mark-command)
(which-key-add-keymap-based-replacements test-prefix-map
  "c" `("consult" . ,test-prefix-consult-map)
  "o" `("org" . ,test-prefix-org-map)
  "p" `("project" . ,test-prefix-project-map))

;;;; startup
;; https://www.reddit.com/r/emacs/comments/8n3lhc/launch_default_buffer_if_emacs_is_not_opening_a/
;(unless (cadr command-line-args) (jet/dashboard))
;(setq initial-buffer-choice (unless (cadr command-line-args) (lambda () (recentf-open-files))))

;; https://github.com/sainnhe/sonokai-vscode/blob/master/themes/sonokai-default.json
;; https://nice.github.io/themeforge/
(load "~/.config/emacs/sonokai-theme.el")
(load-theme 'sonokai t)
(load-file "~/.config/emacs/lsp.el")
(load-file "~/.config/emacs/consult.el")
(load-file "~/.config/emacs/meow.el")
(load-file "~/.config/emacs/jabber.el")
(load-file "~/.config/emacs/private.el")

;; set modeline stuff here because we want it to pick up meow
(setq-default mode-line-format
              '("%e"
                (:eval (meow-indicator))
		jet/ml-separator
		(:propertize (buffer-read-only "! " "") face mode-line-readonly-buffer-id)
		(:eval (jet/dir-indicator-colorized))
		(:eval (jet/modified-buffer-indicator-colorized (buffer-name)))
		jet/ml-separator
		mode-line-position
		jet/ml-separator
		mode-line-modes
		jet/ml-separator
		project-mode-line
		project-mode-line-format
		mode-line-misc-info))

(setq-default tab-bar-format '(tab-bar-format-global
					;tab-bar-format-history
		       ;tab-bar-format-tabs
					;tab-bar-separator tab-bar-format-add-tab
		       ))
(set-face-attribute 'tab-bar nil :background "gray15" :foreground "white")

;; https://code.whatever.social/exchange/emacs/questions/3925/hide-list-of-minor-modes-in-mode-line#3928
(defvar hidden-minor-modes ; example, write your own list of hidden minor modes
  '(abbrev-mode            
    auto-fill-function
    flycheck-mode
    flyspell-mode
    company-mode
    meow-mode
    meow-normal-mode
    meow-insert-mode
    meow-keypad-mode
    meow-beacon-mode
    meow-motion-mode
    evil-collection-unimpaired-mode
    which-key-mode))
(defun purge-minor-modes ()
  (interactive)
  (dolist (x hidden-minor-modes nil)
    (let ((trg (cdr (assoc x minor-mode-alist))))
      (when trg
        (setcar trg "")))))
(add-hook 'after-change-major-mode-hook 'purge-minor-modes)

;; (defconst animate-n-steps 6)
;; (defun emacs-reloaded ()
;;   (animate-string (concat ";; Initialization successful, welcome to "
;; 			  (substring (emacs-version) 0 16) ".")
;; 		  0 0)
;;   (newline-and-indent)  (newline-and-indent))
;; (add-hook 'after-init-hook 'emacs-reloaded)  
