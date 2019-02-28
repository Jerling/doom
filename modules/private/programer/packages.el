;; -*- no-byte-compile: t; -*-
;;; private/my-cc/packages.el

;; (package! google-c-style)

(package! clang-format)

(package! cmake-project :recipe (:fetcher github :repo "xhcoding/cmake-project"))

(package! zeal-at-point)

(package! gdb-ui :recipe (:fetcher github :repo "inlinechan/gdb-ui"))
