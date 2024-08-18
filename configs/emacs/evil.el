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
  "." 'comment-line ;comment-region
  "," 'uncomment-region
  "e" 'my-eval-defun
  "t" 'eat-other-window))
(use-package evil :ensure t :demand t
  :init (setq evil-want-integration t)
  :config
  (evil-mode 1)
  (evil-set-initial-state 'dired-mode 'emacs)
  (setq evil-echo-state nil)
  :custom (evil-undo-system 'undo-redo))
(use-package evil-collection :after evil :ensure t :demand t :config (evil-collection-init))
(use-package evil-terminal-cursor-changer :ensure t :demand t)
  (unless (display-graphic-p)
          (require 'evil-terminal-cursor-changer)
          (evil-terminal-cursor-changer-activate))
