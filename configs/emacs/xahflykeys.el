(use-package xah-fly-keys :ensure t :demand t
  :init (xah-fly-keys 1)
  :config (xah-fly-keys-set-layout "qwerty"))
;; 2021-03-10 this fix the problem of: when emacs start as daemon, xah fly keys is not in command mode. thx to David Wilson (daviwil)

(defun my/server-fix-up()
  "Make sure 'xah-fly-keys' is starting in command-mode.

https://github.com/xahlee/xah-fly-keys/issues/103
https://github.com/daviwil/emacs-from-scratch/blob/master/show-notes/Emacs-Tips-08.org#configuring-the-ui-for-new-frames"
  (xah-fly-keys-set-layout "dvorak")
  (xah-fly-keys t))

(if (daemonp)
    (add-hook 'server-after-make-frame-hook 'my/server-fix-up))
;; make escape key do both activate command mode and cancel
;; from Egor Maltsev
;; Version 2023-04-08 2023-04-09

;; how it works:
;; 1. <escape> set to xah-fly-keys-command-mode-activate in xah-fly-keys-shared-map
;; 2. <escape> set to xah-fly-keys-escape in xah-fly-keys-command-map
;; 3. catched tty ESC translates to <escape>

;; 1. hack escape:

(progn
  (defun xah-fly-keys-escape ()
    (interactive)
    (when (region-active-p)
      (deactivate-mark))
    (when (active-minibuffer-window)
      (abort-recursive-edit)))

  (define-key xah-fly-command-map (kbd "<escape>")     'xah-fly-keys-escape))

(progn
  (defvar xah-fly-keys-fast-keyseq-timeout 200)

  (defun xah-fly-keys-tty-ESC-filter (map)
    (if (and (equal (this-single-command-keys) [?\e])
             (sit-for (/ xah-fly-keys-fast-keyseq-timeout 1000.0)))
        [escape] map))

  (defun xah-fly-keys-lookup-key (map key)
    (catch 'found
      (map-keymap (lambda (k b) (if (equal key k) (throw 'found b))) map)))

  (defun xah-fly-keys-catch-tty-ESC ()
    "Setup key mappings of current terminal to turn a tty's ESC into
`escape'."
    (when (memq (terminal-live-p (frame-terminal)) '(t pc))
      (let ((esc-binding (xah-fly-keys-lookup-key input-decode-map ?\e)))
        (define-key input-decode-map
          [?\e] `(menu-item "" ,esc-binding :filter xah-fly-keys-tty-ESC-filter)))))

  (xah-fly-keys-catch-tty-ESC)

  (define-key key-translation-map (kbd "ESC") (kbd "<escape>")))

;; 2. profit! Escape activates command mode GUI and terminal. Escape
;; activates command mode in minibuffer, second press quits
;; minibuffer. Deactivates mark too

