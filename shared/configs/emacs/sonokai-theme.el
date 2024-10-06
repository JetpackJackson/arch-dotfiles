
;; If you are distributing this theme, please replace this comment
;; with the appropriate license attributing the original VS Code
;; theme author.

(deftheme sonokai "A nice dark theme.")


(let (
(color0 "#2c2e34")
(color1 "#e2e2e3")
(color2 "#404248")
(color3 "#595b61")
(color4 "#45474d")
(color5 "#36373b")
(color6 "#f6f6f7")
(color7 "#4a4b4f")
(color8 "#ffffff")
(color9 "#77797f")
(color10 "#9ed072")
(color11 "#7f8490")
(color12 "#b39df3")
(color13 "#fc5d7c")
(color14 "#e7c664")
(color15 "#76cce0")
(color16 "#3b3d43")
(color17 "#f1f1f2")
(color18 "#37393f")
(color19 "#ededee"))


(custom-theme-set-faces
'sonokai


;; BASIC FACES
`(default ((t (:background ,color0 :foreground ,color1 ))))
`(hl-line ((t (:background ,color2 ))))
`(cursor ((t (:foreground ,color1 ))))
`(region ((t (:background ,color3 ))))
`(secondary-selection ((t (:background ,color4 ))))
`(fringe ((t (:background ,color0 ))))
`(mode-line-inactive ((t (:background ,color5 :foreground ,color6 ))))
`(mode-line ((t (:background ,color7 :foreground ,color8 ))))
`(minibuffer-prompt ((t (:background ,color0 :foreground ,color1 ))))
`(vertical-border ((t (:foreground ,color9 ))))


;; FONT LOCK FACES
`(font-lock-builtin-face ((t (:foreground ,color10 ))))
`(font-lock-comment-face ((t (:foreground ,color11 ))))
`(font-lock-constant-face ((t (:foreground ,color12 ))))
`(font-lock-function-name-face ((t (:foreground ,color10 ))))
`(font-lock-keyword-face ((t (:foreground ,color13 ))))
`(font-lock-string-face ((t (:foreground ,color14 ))))
`(font-lock-type-face ((t (:foreground ,color15 ))))
`(font-lock-variable-name-face ((t (:foreground ,color1 ))))


;; linum-mode
`(linum ((t (:foreground ,color11 ))))
`(linum-relative-current-face ((t (:foreground ,color11 ))))


;; display-line-number-mode
`(line-number ((t (:foreground ,color11 ))))
`(line-number-current-line ((t (:foreground ,color11 ))))


;; THIRD PARTY PACKAGE FACES


;; doom-modeline-mode
`(doom-modeline-bar ((t (:background ,color7 :foreground ,color8 ))))
`(doom-modeline-inactive-bar ((t (:background ,color5 :foreground ,color6 ))))


;; web-mode
`(web-mode-string-face ((t (:foreground ,color14 ))))
`(web-mode-html-tag-face ((t (:foreground ,color13 ))))
`(web-mode-html-tag-bracket-face ((t (:foreground ,color13 ))))
`(web-mode-html-attr-name-face ((t (:foreground ,color15 ))))


;; company-mode
`(company-tooltip ((t (:background ,color16 :foreground ,color17 ))))


;; org-mode
`(org-block ((t (:background ,color18 :foreground ,color19 ))))
`(org-block-begin-line ((t (:foreground ,color11 ))))))


(custom-theme-set-variables
  'sonokai
  '(linum-format " %3i "))


;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))


;;;###autoload
(defun sonokai-theme()
  "Apply the sonokai-theme."
  (interactive)
  (load-theme 'sonokai t))


(provide-theme 'sonokai)


;; Local Variables:
;; no-byte-compile: t
;; End:


;; Generated using https://github.com/nice/themeforge
;; Feel free to remove the above URL and this line.
