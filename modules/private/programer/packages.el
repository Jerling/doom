;; -*- no-byte-compile: t; -*-
;;; private/my-cc/packages.el

(package! google-c-style)

(package! clang-format)

(package! cmake-project :recipe (:host github :repo "xhcoding/cmake-project"))

;; (package! zeal-at-point)

(package! emacs-gdb :recipe (:host github :repo "weirdNox/emacs-gdb" :files ("*.el" "*.c" "*.h" "Makefile")))

(package! counsel-tramp)

(package! exec-path-from-shell)
