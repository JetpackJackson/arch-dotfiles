(use-package general :ensure t :demand t)
(general-define-key
 :states '(normal visual emacs)
 :prefix "<SPC>"
 "" nil
 ;"a" #'org-agenda
 ;"b" #'counsel-bookmark
 ;"c" #'org-capture
 "f" #'find-file
 "s" #'consult-find
 "v" #'list-buffers
 "b" #'consult-buffer ;'switch-to-buffer
 "ca" #'eglot-code-actions
 "cq" #'eglot-code-action-quickfix
 "cn" #'consult-flymake ;'flymake-goto-next-error
 "d" #'kill-buffer
 "g" #'consult-bookmark ;'bookmark-jump
 "r" #'my-mode-recompile ;'recompile
 "u" #'my-mode-upload-run
 "l" #'my-org-insert-link
 "of" #'org-open-at-point
 "oe" #'org-export-dispatch
 "." #'comment-region
 "," #'uncomment-region
 "e" #'eshell
 "t" #'eat-other-window
 "q" #'delete-window)
