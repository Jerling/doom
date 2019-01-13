;;; private/my-blog/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +my-blog*export-blog-image-url(filename)
  (if (equal
       (string-match-p
        (regexp-quote (expand-file-name +my-blog-root-dir))
        (expand-file-name filename))
       0)
      (concat  +my-blog-res-url (string-trim-left filename +my-blog-img-dir))
    nil))


;;;###autoload
(defun +my-blog-kill-new-img-link(prefix imagename)
  (kill-new (format "[[file:%s%s]] " prefix imagename imagename)))

;;;###autoload
(defun +my-blog/capture-screenshot(basename)
  (interactive "sScreenshot name: ")
  (if (string-equal basename "")
      (setq basename
            (file-name-base buffer-file-name)))
  (setq filename (concat basename (format-time-string "_%Y%H%M%S")))
  (sleep-for 3)
  (call-process-shell-command
   (concat
    "deepin-screenshot -s " (concat (expand-file-name +my-blog-img-dir) filename)))
  (+my-blog-kill-new-img-link
   +my-blog-img-dir (concat filename ".png")))

;;;###autoload
(defun cesco/easy-hugo ()
  (interactive)
  (evil-define-key
    (list 'normal 'insert 'visual 'motion)
    easy-hugo-mode-map
    "n" 'easy-hugo-newpost
    "D" 'easy-hugo-article
    "p" 'easy-hugo-preview
    "P" 'easy-hugo-publish
    "o" 'easy-hugo-open
    "d" 'easy-hugo-delete
    "e" 'easy-hugo-open
    "c" 'easy-hugo-open-config
    "f" 'easy-hugo-open
    "N" 'easy-hugo-no-help
    "v" 'easy-hugo-view
    "r" 'easy-hugo-refresh
    "g" 'easy-hugo-refresh
    "s" 'easy-hugo-sort-time
    "S" 'easy-hugo-sort-char
    "G" 'easy-hugo-github-deploy
    "A" 'easy-hugo-amazon-s3-deploy
    "C" 'easy-hugo-google-cloud-storage-deploy
    "q" 'evil-delete-buffer
    (kbd "TAB") 'easy-hugo-open
    (kbd "RET") 'easy-hugo-preview)
  (define-key global-map (kbd "C-c C-e") 'easy/hugo))
