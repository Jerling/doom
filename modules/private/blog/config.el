;;; private/my-blog/config.el -*- lexical-binding: t; -*-

(defvar +my-blog-root-dir
  "~/data/blog"
  "Blog root directory.")

(def-package! easy-hugo
  :init
  (setq easy-hugo-basedir +my-blog-root-dir
	easy-hugo-postdir "content/orgs"
        easy-hugo-url "http://127.0.0.1:1313"
        easy-hugo-preview-url "http://127.0.0.1:1313"
        easy-hugo-sshdomain "Jerling"
        easy-hugo-root "~/blog/"
        easy-hugo-previewtime "20")
  (setq easy-hugo-default-ext ".org")
  (setq easy-hugo-org-header t)
  (add-hook 'easy-hugo-mode-hook 'cesco/easy-hugo))
