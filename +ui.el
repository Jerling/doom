;;; config/private/+ui.el -*- lexical-binding: t; -*-

;; theme
;; cycle by +my/toggle-cycle-theme, binding SPC t t
(defvar +my-themes '(doom-one doom-one-light doom-dracula))
(if (display-graphic-p)
    (setq doom-theme 'doom-dracula)
  (setq doom-theme 'doom-one))

;; disable line-number
(setq display-line-numbers-type nil)

;; font
;; (setq doom-font (font-spec :family "DejaVu Sans Mono" :size 16)
(setq doom-font (font-spec :family "Sarasa Term SC" :size 16))
