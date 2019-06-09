;; -*- no-byte-compile: t; -*-
;;; private/my-cc/packages.el

(package! google-c-style)

(package! clang-format)

(package! cmake-project :recipe (:fetcher github :repo "xhcoding/cmake-project"))

(package! zeal-at-point)

(package! emacs-gdb :recipe (:fetcher github :repo "weirdNox/emacs-gdb" :files ("*.el" "*.c" "*.h" "Makefile")))