;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;;
;; config
;;
;; for autocomplete
(ac-config-default)

;; for eval c++
;; Use this parameter as C++ default
(quickrun-add-command "c++/c1z"
  '((:command . "g++")
    (:exec    . ("%c -std=c++1z %o -o %e %s"
		 "%e %a"))
    (:remove  . ("%e")))
  :default "c++")

;; flycheck for c++11
(if (eq system-type 'darwin)
    (add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++11")))
  (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
    )
