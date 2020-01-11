;;; private/my-blog/config.el -*- lexical-binding: t; -*-
(defvar +my-blog-root-dir
  "~/jerling.github.io/"
  "Blog root directory.")

(use-package! easy-hugo
  :init
  (setq easy-hugo-basedir +my-blog-root-dir
    easy-hugo-root +my-blog-root-dir
    easy-hugo-postdir "orgs"
    easy-hugo-url "https://jerling.github.io/"
    easy-hugo-preview-url "http://127.0.0.1:1313/"
    easy-hugo-sshdomain "Jerling"
    easy-hugo-previewtime "20"
    easy-hugo-default-ext ".org"
    easy-hugo-org-header t
    )
  (add-hook 'easy-hugo-mode-hook 'cesco/easy-hugo))

(defvar +my-blog-img-dir
  "../static/images/"
  "Blog's image directory")

(defvar +my-blog-img-url
  (concat easy-hugo-url "images/")
  "Blog's image URL")
