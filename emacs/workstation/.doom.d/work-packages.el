;;; $DOOMDIR/work-packages.el -*- lexical-binding: t; -*-

;; Packages specific to Google and coding in google3.

;; Dependency for protobuffer mode.
(package! aio)

(package! google
  :recipe (:local-repo "/usr/share/emacs/site-lisp/emacs-google-config/devtools/editors/emacs"))

;; Major modes for frontend development.
(package! web-mode)
(package! css-mode)
