;; (unless (package-installed-p 'jabber)
;;   (require 'package-vc)
;;   (package-vc-install '(jabber
;;                         :url "https://codeberg.org/emacs-jabber/emacs-jabber"
;;                         :branch "production"
;;                         :lisp-dir "lisp"
;;                         :doc "README.org")))
(use-package jabber :demand t
  :config
  (setq jabber-vcard-avatars-retrieve t)
  (setq jabber-chat-buffer-format "*%n-jb*")
  (setq jabber-browse-buffer-format "*%n*")
  (setq jabber-groupchat-buffer-format "*%n*")
  (setq jabber-muc-private-buffer-format "*%n*")

  (setq jabber-alert-presence-hooks nil)
  (setq jabber-chatstates-confirm nil)
  ;(setq jabber-alert-info-message-hooks '(jabber-info-display))

  ;(setq jabber-alert-message-function (shell-command "notify-send" "foo" "&"))

  (setq jabber-alert-muc-hooks '(jabber-muc-notifications-personal jabber-muc-scroll))
  ;(setq jabber-alert-message-hooks '(jabber-message-scroll))
  :hook (jabber-chat-mode . visual-line-mode))
(custom-theme-set-faces
 'user
 '(jabber-chat-error ((t (:foreground "#fc5d7c" :weight bold))))
 '(jabber-chat-prompt-foreign ((t (:foreground "#fc5d7c" :weight bold))))
 '(jabber-chat-prompt-local ((t (:foreground "#76cce0" :weight bold))))
 '(jabber-chat-prompt-system ((t (:foreground "#9ed072" :weight bold))))
 '(jabber-activity-face ((t (:foreground "steel blue" :weight normal))))
 '(jabber-activity-personal-face ((t (:foreground "pale green" :weight bold))))
 '(jabber-rare-time-face ((t (:foreground "yellow" :underline t)))))
 (setq 
  special-display-regexps 
  '(("jb"
     (width . 80)
     (scroll-bar-width . 16)
     (height . 15)
     (tool-bar-lines . 0)
     (menu-bar-lines 0)
     (left . 80))))
;(setq jabber-muc-decorate-presence-patterns '(("enters the room" . nil)))
(setq jabber-muc-decorate-presence-patterns '(("enters the room")
 ("has left the chatroom")
 (".*" . jabber-muc-presence-dim)))

;; jabber filter for consult
(defvar jabber-source
  (list :name     "Jabber"
        :category 'buffer
        :narrow   ?j
        :face     'consult-buffer
        :history  'buffer-name-history
        :state    #'consult--buffer-state
        :items
        (lambda ()
          (consult--buffer-query :mode 'jabber-chat-mode :as #'consult--buffer-pair))))
(add-to-list 'consult-buffer-sources 'jabber-source 'append)

