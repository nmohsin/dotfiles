;;; $DOOMDIR/work-config.el -*- lexical-binding: t; -*-

;; Configuration specific to Google and coding in google3.

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
