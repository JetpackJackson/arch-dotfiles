;; -*- lexical-binding: t -*-
;; UI and other settings that aren't necessarily related to a package/fit better elsewhere.

(set-face-attribute 'default nil :font "Ärzte Sans Mono" :height 120)
(setq default-frame-alist '((font . "Ärzte Sans Mono Roman-12")))

;; transparent background
(set-frame-parameter nil 'alpha-background 80)
(add-to-list 'default-frame-alist '(alpha-background . 80))

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

(setq inhibit-splash-screen t
      use-file-dialog nil ;; don't use system file dialog
      tab-bar-new-button-show nil ;; don't show new tab button
      tab-bar-close-button-show nil ;; don't show tab close button
      tab-line-close-button-show nil) ;; don't show tab close button
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; clean up elpa stuff
(setq package-user-dir (string-replace ".config" ".cache" package-user-dir))
(setcar native-comp-eln-load-path
        (string-replace ".config" ".cache" (car native-comp-eln-load-path)))
;(require 'xdg) (startup-redirect-eln-cache (expand-file-name "emacs/elpa" (xdg-cache-home)))
;(startup-redirect-eln-cache (expand-file-name "emacs/elpa" (xdg-cache-home)))

;; modeline functions
(setq mode-line-position (list "(%l,%c)"))
(setq mode-line-front-space nil)
(defvar jet/ml-separator "    ")

(defface mode-line-modified-buffer-id
  '((t (:foreground "#ffe066" :inherit (mode-line-buffer-id))))
  "Face used for buffer id part of the mode line when the buffer is modified."
  :group 'mode-line-faces)

(defface mode-line-readonly-buffer-id
  '((t (:foreground "#ff6699" :inherit (mode-line-buffer-id))))
  "Face used for buffer id part of the mode line when the buffer is read-only."
  :group 'mode-line-faces)

;; fixed?
(defvar trunc-name)
(defun jet/modified-buffer-indicator-colorized (trunc-name) "Show buffer status in the mode line."
       ;(if (buffer-file-name) nil (propertize buffer-file-name 'face 'hide))
       (cond ((buffer-modified-p) (propertize trunc-name 'face 'mode-line-modified-buffer-id))
	     (t (propertize trunc-name 'face 'mode-line-buffer-id))))

(defun jet/dir-indicator-colorized () "Show directory in the mode line with thin font."
  (let ((trunc-name ""))
    (if (string-equal-ignore-case (buffer-name) "*scratch*")
        (setq trunc-name "")
      (when buffer-file-name
        (setq trunc-name (shrink-path-dirs (file-name-directory buffer-file-truename)))))
    (cond ((buffer-modified-p) (propertize trunc-name 'face 'mode-line-modified-buffer-id))
          (t (propertize trunc-name 'face '(:foreground "#ffffff"))))))

;;; FUNCTIONS
;; https://stackoverflow.com/questions/4872088/is-there-any-way-for-subtasks-to-inherit-deadlines-in-org-mode
(defun org-insert-sub-task ()
  (interactive)
  (let ((parent-deadline (org-get-deadline-time nil)))
    (org-goto-sibling)
    (org-insert-todo-subheading t)
    (when parent-deadline
      (org-deadline nil parent-deadline))))

(defun jet/mode-recompile () "Recompile a project based on its type" (interactive)
  (cond ((bound-and-true-p platformio-mode) (platformio-build buffer-file-name)) ;; if platformio minor mode
	((eq major-mode 'c++-mode) (project-compile));(jet/project-compile-build));(my-compile-project))
	((bound-and-true-p sly-mode) (sly-compile-file))
	((bound-and-true-p eglot-java-mode) (project-compile)) ;(eglot-java-run-main)) ; FIXME
	(t (message "recompile command not defined for this mode"))))

(defun jet/mode-upload-run () "Upload/run a project based on its type" (interactive)
  (cond ((bound-and-true-p platformio-mode) (platformio-upload buffer-file-name)) ;; if platformio minor mode
	((eq major-mode 'c++-mode) (project-compile));(my-compile-project))
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

(defun jet/grep-for-tasks () "grep for tasks" (interactive)
  (consult-ripgrep (consult--project-root) "\\(TODO\\|FIXME\\|WIP\\)"))

(defun colorize-compilation-buffer ()
  (require 'ansi-color)
  (ansi-color-apply-on-region compilation-filter-start (point)))

(defun comment-auto-fill ()
  (setq-local comment-auto-fill-only-comments t)
  (auto-fill-mode 1))

(defun jet/dashboard ()
  (interactive)
  (delete-other-windows)
  (get-buffer (scratch-buffer))
  (other-window 1)
  (split-window-horizontally)
  (get-buffer (recentf-open-files)))

;; based on http://xahlee.info/emacs/emacs/elisp_toggle_command.html
(defun jet/toggle-transparency ()
  (interactive)
  (if (get 'my-toggle 'state)
      (progn (set-frame-parameter nil 'alpha-background 100)
	     (put 'my-toggle 'state nil))
    (progn (set-frame-parameter nil 'alpha-background 80)
	   (put 'my-toggle 'state t))))
