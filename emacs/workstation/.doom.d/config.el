;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Nadeem Mohsin"
      user-mail-address "nadeemm@google.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Easy window switching.
(map! :g "M-o" 'other-window
      :g "M-O" 'ace-window)

;; Add shell opening commands to the leader-open menu.
(map! :leader
      :desc "Toggle shell popup" :nvm "o s" #'+shell/toggle
      :desc "Open shell here" :nvm "o S" #'+shell/here)

;; Visual Regexp steroids.
(use-package! visual-regexp-steroids
  :defer 3
  :config
  (require 'pcre2el)
  (setq vr/engine 'pcre2el)
  ;; Create a new prefix-map for these functions.
  (map! :leader
        :desc "Visual Regexp" :prefix-map "r"
        :desc "Replace" :nvi "r" #'vr/replace
        :desc "Query Replace" :nvi "q" #'vr/query-replace))

;; Allow pasting from the kill ring.
(map! :nvi "M-p" #'counsel-yank-pop)

;; Show trailing whitespace.
(setq show-trailing-whitespace t)

;; Auto revert buffers.
(global-auto-revert-mode)

;; Google-specific packages.
(use-package! google)
(use-package! google3)
(use-package! google-trailing-whitespace)
(use-package! google3-build-mode)
(use-package! google-emacs-support)
(use-package! google3-ffap
  :config
  (add-to-list 'ffap-alist (google3-ffap-alist-additions)))

(use-package! web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.soy$" . web-mode))
  (setq web-mode-markup-indent-offset 2))

(use-package! css-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.gss\\'" . css-mode))
  (setq css-indent-offset 2))
