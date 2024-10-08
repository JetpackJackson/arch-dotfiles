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

;(defvar elpaca-installer-version 0.7)
;(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
;(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
;(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
;(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
;                              :ref nil :depth 1
;                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
;                              :build (:not elpaca--activate-package)))
;(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
;       (build (expand-file-name "elpaca/" elpaca-builds-directory))
;       (order (cdr elpaca-order))
;       (default-directory repo))
;  (add-to-list 'load-path (if (file-exists-p build) build repo))
;  (unless (file-exists-p repo)
;    (make-directory repo t)
;    (when (< emacs-major-version 28) (require 'subr-x))
;    (condition-case-unless-debug err
;        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
;                 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
;                                                 ,@(when-let ((depth (plist-get order :depth)))
;                                                     (list (format "--depth=%d" depth) "--no-single-branch"))
;                                                 ,(plist-get order :repo) ,repo))))
;                 ((zerop (call-process "git" nil buffer t "checkout"
;                                       (or (plist-get order :ref) "--"))))
;                 (emacs (concat invocation-directory invocation-name))
;                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
;                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
;                 ((require 'elpaca))
;                 ((elpaca-generate-autoloads "elpaca" repo)))
;            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
;          (error "%s" (with-current-buffer buffer (buffer-string))))
;      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
;  (unless (require 'elpaca-autoloads nil t)
;    (require 'elpaca)
;    (elpaca-generate-autoloads "elpaca" repo)
;    (load "./elpaca-autoloads")))
;(add-hook 'after-init-hook #'elpaca-process-queues)
;(elpaca `(,@elpaca-order))
;(elpaca elpaca-use-package
;  ;; Enable use-package :ensure support for Elpaca.
;  (elpaca-use-package-mode))


(require 'use-package)
(setq use-package-compute-statistics t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(use-package shrink-path :ensure t :demand t)
(use-package which-key :ensure t :demand t :config (which-key-mode))
(use-package rainbow-delimiters :ensure t :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package magit :ensure t :bind (("C-c g" . magit-status)))
(use-package eat :ensure t)
(use-package uniquify)

(use-package dirvish :ensure t :init (dirvish-override-dired-mode)
  :custom
  (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
   '(("g" "~/"                               "home")
     ("d" "~/dl/"                            "downloads")
     ("m" "/run/media/"                      "drives")
     ("t" "~/.cache/mytrash/"                "trash")
     ("c" "~/.local/share/"                  "data")
     ("n" "~/docs/notes/notes-zettelkasten/" "notes")
     ("p" "~/docs/notes/projects/git/"       "projects")
     ("s" "~/docs/notes/school/"             "school")))
  :config
  (dirvish-peek-mode) ; Preview files in minibuffer
  (dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
  (setq dirvish-open-with-programs
	'((("ape" "stm" "s3m" "ra" "rm" "ram" "wma" "wax" "m3u" "med" "669" "mtm" "m15" "uni" "ult" "mka" "flac" "axa" "kar" "midi" "mid" "s1m" "smp" "smp3" "rip" "multitrack" "ecelp9600" "ecelp7470" "ecelp4800" "vbk" "pya" "lvp" "plj" "dtshd" "dts" "mlp" "eol" "uvva" "uva" "koz" "xhe" "loas" "sofa" "smv" "qcp" "psid" "sid" "spx" "opus" "ogg" "oga" "mp1" "mpga" "m4a" "mxmf" "mhas" "l16" "lbc" "evw" "enw" "evb" "evc" "dls" "omg" "aa3" "at3" "atx" "aal" "acn" "awb" "amr" "ac3" "ass" "aac" "adts" "726" "abs" "aif" "aifc" "aiff" "au" "mp2" "mp3" "mp2a" "mpa" "mpa2" "mpega" "snd" "vox" "wav")
	  "/usr/bin/mpv" "--profile=builtin-pseudo-gui" "%f")
	 (("f4v" "rmvb" "wvx" "wmx" "wmv" "wm" "asx" "mk3d" "mkv" "fxm" "flv" "axv" "webm" "viv" "yt" "s1q" "smo" "smov" "ssw" "sswf" "s14" "s11" "smpg" "smk" "bk2" "bik" "nim" "pyv" "m4u" "mxu" "fvt" "dvb" "uvvv" "uvv" "uvvs" "uvs" "uvvp" "uvp" "uvvu" "uvu" "uvvm" "uvm" "uvvh" "uvh" "ogv" "m2v" "m1v" "m4v" "mpg4" "mp4" "mjp2" "mj2" "m4s" "3gpp2" "3g2" "3gpp" "3gp" "avi" "mov" "movie" "mpe" "mpeg" "mpegv" "mpg" "mpv" "qt" "vbs" "gif")
	  "mpv" "%f")
	 (("jpg" "jpeg" "png" "tga" "webp")
	  "feh" "%f")
	 (("pdf" "epub")
	  "zathura" "%f")
	 (("ods" "odt" "ppt" "pptx" "doc" "docx" "xlsx" "csv")
	  "libreoffice" "%f")))
  (setq dirvish-hide-details nil)
  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index)))
  (setq dirvish-attributes
        '(file-time file-size collapse subtree-state vc-state git-msg))
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")
  :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
  (("C-c f" . dirvish-fd)
   :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
   ("g"   . dirvish-quick-access) ;; binds from lf config
   ("f"   . dirvish-file-info-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ("h"   . dirvish-history-jump) ; remapped `describe-mode'
   ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
   ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
   ("TAB" . dirvish-subtree-toggle)
   ("M-f" . dirvish-history-go-forward)
   ("M-b" . dirvish-history-go-backward)
   ("M-l" . dirvish-ls-switches-menu)
   ("M-m" . dirvish-mark-menu)
   ("M-t" . dirvish-layout-toggle)
   ("M-s" . dirvish-setup-menu)
   ("M-e" . dirvish-emerge-menu)
   ("M-j" . dirvish-fd-jump)
   ("<left>" . dired-up-directory)
   ("<right>" . dired-find-file)))

(use-package project)
  ;; Cannot use :hook because 'project-find-functions does not end in -hook
  ;; Cannot use :init (must use :config) because otherwise
  ;; project-find-functions is not yet initialized.
;  :config
;  (add-hook 'project-find-functions #'my-project-override))
(use-package project-butler :ensure t :demand t)
(customize-set-variable 'project-butler-projects-list
                        '(("~/docs/notes/school/COP3503C/project3-p3/" . ("1|2<" ("src/main.cpp" "src/game_gui.h")))))
;; Replace the binding C-x p k, originally bound to `project-kill-buffers'
(keymap-set project-prefix-map "k" #'project-butler-cleanup)

;; path
(use-package exec-path-from-shell :ensure t :demand t
  :init (when (daemonp)
	  (require 'exec-path-from-shell)
	  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE" "GUILE_LOAD_PATH" "GUILE_LOAD_COMPILED_PATH" "RUSTUP_HOME" "CARGO_HOME"))
	    (add-to-list 'exec-path-from-shell-variables var))
	  (exec-path-from-shell-initialize)))

(use-package recentf :demand t
  :config
  (setq recentf-max-menu-items 10)
  (setq recentf-max-saved-items 10)
  (setq recentf-exclude '("emacs/bookmarks" "agenda.org" "custom.el" "Makefile" ".gitignore"))
  ;(setq recentf-filename-handlers '(shrink-path-file))
  (setq recentf-filename-handlers '(abbreviate-file-name))
  ;(setq recentf-menu-action '(shrink-path-file-expand))
  (setq recentf-filter-changer-current '(recentf-arrange-by-dir))
  (recentf-mode 1))

;; vertico
(use-package vertico :ensure t
  :custom
  (vertico-count 20) ;; Show more candidates
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init (vertico-mode)
  :config (use-package savehist :ensure t :init (savehist-mode))) ;; Persist history over Emacs restarts. Vertico sorts by history position.
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
(use-package select
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
(use-package org :ensure org-contrib ;:demand t
    :bind (:map
           org-mode-map
           ;; ("C-c o e" . org-export-dispatch) ;; C-c C-e
	   ("C-c o f" . org-open-at-point))

  :config (require 'ox-extra) (ox-extras-activate '(ignore-headlines))
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
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.75)))
(with-eval-after-load 'org
  (add-to-list 'org-latex-classes
               '("book"
		 "\\documentclass{book}"
		 ("\\part{%s}" . "\\part*{%s}")
		 ("\\chapter{%s}" . "\\chapter*{%s}")
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t) (emacs-lisp . t) (java . t) (C . t) (lisp . t) (dot . t) (shell . t)))
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c <TAB>") #'org-shiftmetaright)
  (define-key org-mode-map (kbd "C-c <DEL>") #'org-shiftmetaleft)
  (define-key org-mode-map (kbd "C-c s") #'org-insert-sub-task))
(with-eval-after-load 'org-faces
  (set-face-attribute 'org-level-3 nil :foreground "white")
  (set-face-attribute 'org-agenda-done nil :foreground "gray")
  (set-face-attribute 'org-scheduled nil :foreground "green yellow")
  (set-face-attribute 'org-scheduled-today nil :foreground "green yellow"))
  ;(set-face-attribute 'org-special-keyword nil :foreground "lightslategray")
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'org-fragtog-mode)

(use-package valign :ensure t)
;(add-hook 'org-mode-hook 'valign-mode)
(use-package org-timeblock :ensure t)
(use-package org-fragtog :ensure t)

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

      ;; manual:
      ;; "With X and Y being either "@" or "!", "X/Y" means
      ;; use X when entering the state, and use Y when leaving the
      ;; state if and only if the *target* state does not define X."
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
        ;("OBE" . (:foreground "LimeGreen" :weight bold))
        ("WONT-DO" . (:foreground "LimeGreen" :weight bold))))

(if (display-graphic-p)
    (use-package fira-code-mode :ensure t
      :custom (fira-code-mode-disabled-ligatures '("[]" "x" ":" "::" ":::"))
      :hook prog-mode))

(global-set-key (kbd "C-c 0") #'add-file-local-variable-prop-line)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; try out M-SPC or C-SPC as leader key

;; to sort region like in neovim, M-h and then M-x sort-line
(setq evil-disable-insert-state-bindings t)

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

(global-set-key (kbd "C-c ,") #'uncomment-region)
(global-set-key (kbd "C-c .") #'comment-line)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c b") #'consult-buffer) ;; C-x b
(global-set-key (kbd "C-c cf") #'consult-find) ;; M-s d
(global-set-key (kbd "C-c cm") #'jet/grep-for-tasks)
;; (global-set-key (kbd "C-c cn") #'consult-flymake)
(global-set-key (kbd "C-c d") #'kill-buffer) ;; C-x k
(global-set-key (kbd "C-c e") #'jet/eval-defun)
(global-set-key (kbd "C-c f") #'find-file) ;; C-x C-f
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c oc") #'org-capture)
;(global-set-key (kbd "C-c oe") #'org-export-dispatch)
;(global-set-key (kbd "C-c of") #'org-open-at-point)
(global-set-key (kbd "C-c ol") #'org-insert-link)
;; calls org-insert-link with prefix arg to make it always prompt for
;; a file
;(global-set-key (kbd "C-c ol") #'jet/org-insert-link)
(global-set-key (kbd "C-c pr") #'jet/mode-recompile)
(global-set-key (kbd "C-c pu") #'jet/mode-upload-run)
(global-set-key (kbd "C-c t") #'eat-other-window)
(global-set-key (kbd "C-c v") #'ibuffer-other-window)
;(global-set-key (kbd "C-c g") #'consult-bookmark)
;(global-set-key (kbd "C-c w") #'delete-other-windows)

;(global-unset-key (kbd "C-w"))
(global-set-key (kbd "C-c q") #'delete-other-windows)
;(global-unset-key (kbd "C-s"))
;(global-set-key (kbd "C-c C-s") #'isearch-forward)
;(global-set-key (kbd "C-c :w") #'save-buffer)


;;;; startup
;; https://www.reddit.com/r/emacs/comments/8n3lhc/launch_default_buffer_if_emacs_is_not_opening_a/
;;(setq initial-buffer-choice (unless (cadr command-line-args) (lambda () (get-buffer (recentf-open-files)))))
(unless (cadr command-line-args) (jet/dashboard))
(setq initial-buffer-choice (unless (cadr command-line-args) (lambda () (recentf-open-files))))

;; https://github.com/sainnhe/sonokai-vscode/blob/master/themes/sonokai-default.json
;; https://nice.github.io/themeforge/
(load "~/.config/emacs/sonokai-theme.el")
(load-theme 'sonokai t)
(load-file "~/.config/emacs/lsp.el")
(load-file "~/.config/emacs/consult.el")
(load-file "~/.config/emacs/evil.el")
