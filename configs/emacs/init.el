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

;; Add unique buffer names in the minibuffer where there are many
;; identical files. This is super useful if you rely on folders for
;; organization and have lots of files with the same name,
;; e.g. foo/index.ts and bar/index.ts.
(require 'uniquify)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(use-package doom-modeline :ensure t :demand t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-buffer-file-name-style 'relative-from-project)
  (setq doom-modeline-icon nil)
  (setq doom-modeline-buffer-state-icon 1))

(use-package which-key :ensure t :demand t :config (which-key-mode))
(use-package rainbow-delimiters :ensure t :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(use-package magit :ensure t :bind (("C-c g" . magit-status)))
(use-package eat :ensure t)

;; vim keys
(setq evil-want-keybinding nil)
(use-package evil-leader :ensure t :demand t :config (evil-leader/set-leader "<SPC>") (global-evil-leader-mode)
(evil-leader/set-key
  "f" 'find-file
  "s" 'consult-find
  "v" 'list-buffers
  "b" 'consult-buffer ;'switch-to-buffer
  "ca" 'eglot-code-actions
  "cq" 'eglot-code-action-quickfix
  "cn" 'consult-flymake ;'flymake-goto-next-error
  "d" 'kill-buffer
  "g" 'consult-bookmark ;'bookmark-jump
  "r" 'my-mode-recompile ;'recompile
  "u" 'my-mode-upload-run
  "l" 'my-org-insert-link
  "of" 'org-open-at-point
  "oe" 'org-export-dispatch
  "." 'comment-region
  "," 'uncomment-region
  "e" 'eshell
  "t" 'eat-other-window))
(use-package evil :ensure t :demand t
  :init (setq evil-want-integration t)
  :config
  (evil-mode 1)
  (evil-set-initial-state 'dired-mode 'emacs)
  :custom (evil-undo-system 'undo-redo))
(use-package evil-collection :after evil :ensure t :demand t :config (evil-collection-init))
(use-package evil-terminal-cursor-changer :ensure t :demand t)
  (unless (display-graphic-p)
          (require 'evil-terminal-cursor-changer)
          (evil-terminal-cursor-changer-activate))

;(use-package general :ensure t :demand t
;  :config
;  (general-define-key
;   :prefix "<SPC>"
;   "" nil
;   "f" #'find-file
;   "s" #'consult-find
;   "v" #'list-buffers
;   "b" #'consult-buffer ;'switch-to-buffer
;   "ca" #'eglot-code-action-quickfix
;   "cn" #'consult-flymake ;'flymake-goto-next-error
;   "k" #'kill-buffer
;   "g" #'consult-bookmark ;'bookmark-jump
;   "r" #'recompile
;   "l" #'my-org-insert-link
;   "of" #'org-open-at-point
;   "oe" #'org-export-dispatch
;   "." #'comment-region
;   "," #'uncomment-region
;   "e" #'ansi-term))

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
          ;"kitty" "+kitten" "icat" "%f")))

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

;; org
(use-package org :config
  (setq org-agenda-span 20
	org-agenda-start-on-weekday nil
	org-agenda-start-day "-3d")
  (setq org-agenda-files '("/home/jet/docs/notes/notes-zettelkasten/"))
  (setq org-enforce-todo-dependencies nil)
  (setq org-agenda-dim-blocked-tasks t))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c <TAB>") #'org-shiftmetaright)
  (define-key org-mode-map (kbd "C-c <DEL>") #'org-shiftmetaleft)
  (define-key org-mode-map (kbd "C-c s") #'org-insert-sub-task))
(with-eval-after-load 'org-faces
  (set-face-attribute 'org-level-3 nil :foreground "white"))
  ;(set-face-attribute 'org-special-keyword nil :foreground "lightslategray")
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

(global-set-key (kbd "C-c 0") #'add-file-local-variable-prop-line)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; FIXME https://emacs.stackexchange.com/questions/15081/programming-of-initial-buffer-choice
;(setq initial-buffer-choice (lambda () (get-buffer (recentf-open-files))))
;(defun filefocus ()
;       (unless (cl-remove-if-not #'buffer-file-name (buffer-list))
;    (get-buffer (recentf-open-files))
;    (delete-other-windows)))
;(add-hook 'emacs-startup-hook #'filefocus t)

;; https://www.reddit.com/r/emacs/comments/8n3lhc/launch_default_buffer_if_emacs_is_not_opening_a/
(setq initial-buffer-choice (unless (cadr command-line-args) (lambda () (get-buffer (recentf-open-files)))))


;(defun my-setup-initial-window-setup ()
;  "start 2 buffers"
;  (interactive)
;  (switch-to-buffer (get-buffer (recentf-open-files)))
;  (split-window-horizontally)
;  (other-window 1)
;  (switch-to-buffer (get-buffer-create (scratch-buffer)))
;  (other-window 1))
;(add-hook 'emacs-startup-hook #'my-setup-initial-window-setup)

;; https://github.com/sainnhe/sonokai-vscode/blob/master/themes/sonokai-default.json
;; https://nice.github.io/themeforge/
(load "~/.config/emacs/sonokai-theme.el")
(load-theme 'sonokai t)
(load-file "~/.config/emacs/lsp.el")
(load-file "~/.config/emacs/consult.el")
