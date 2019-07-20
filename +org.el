;;; config/private/+org -*- lexical-binding: t; -*-


(after! org
  (setq org-ellipsis " ▼ "
        org-image-actual-width '(400)
        org-ditaa-jar-path (concat doom-private-dir "tools/ditaa.jar")
        org-plantuml-jar-path (concat doom-private-dir "tools/plantuml.jar")
        org-agenda-files (list (concat +my-org-dir "gtd.org"))
        +org-default-notes-file (expand-file-name "inbox.org" +my-org-dir)
        +org-default-todo-file (expand-file-name "todo.org" +my-org-dir)
        )
  (setcar (nthcdr 0 org-emphasis-regexp-components) " \t('\"{[:nonascii:]")
  (setcar (nthcdr 1 org-emphasis-regexp-components) "- \t.,:!?;'\")}\\[[:nonascii:]")
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
  (org-element-update-syntax)

  ;; org-latex
  (setq org-use-sub-superscripts "{}"
        org-latex-compiler "xelatex"
        org-preview-latex-process-alist
        '((dvipng :programs
                  ("latex" "dvipng")
                  :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
                  (1.0 . 1.0)
                  :latex-compiler
                  ("latex -interaction nonstopmode -output-directory %o %f")
                  :image-converter
                  ("dvipng -fg %F -bg %B -D %D -T tight -o %O %f"))
          (dvisvgm :programs
                   ("latex" "dvisvgm")
                   :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :use-xcolor t :image-input-type "dvi" :image-output-type "svg" :image-size-adjust
                   (1.7 . 1.5)
                   :latex-compiler
                   ("latex -interaction nonstopmode -output-directory %o %f")
                   :image-converter
                   ("dvisvgm %f -n -b min -c %S -o %O"))
          (imagemagick :programs
                       ("latex" "convert" "gs")
                       :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :use-xcolor t :image-input-type "pdf" :image-output-type "png" :image-size-adjust
                       (1.0 . 1.0)
                       :latex-compiler
                       ("xelatex -interaction nonstopmode -output-directory %o %f")
                       :image-converter
                       ("convert -density %D -trim -antialias %f -quality 100 %O")))
        org-preview-latex-default-process 'imagemagick

        org-latex-classes
        '(("ctexart"
           "\\documentclass[UTF8,a4paper]{ctexart}"
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
           ("\\paragraph{%s}" . "\\paragraph*{%s}")
           ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
          ("ctexrep"
           "\\documentclass[UTF8,a4paper]{ctexrep}"
           ("\\part{%s}" . "\\part*{%s}")
           ("\\chapter{%s}" . "\\chapter*{%s}")
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
          ("ctexbook"
           "\\documentclass[UTF8,a4paper]{ctexbook}"
           ("\\part{%s}" . "\\part*{%s}")
           ("\\chapter{%s}" . "\\chapter*{%s}")
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
          ("beamer"
           "\\documentclass{beamer}
               \\usepackage[UTF8,a4paper]{ctex}"
           org-beamer-sectioning))
        org-latex-default-class "ctexart"
        )

  (setq org-agenda-dir +my-org-dir)
  (setq org-agenda-file-note (expand-file-name "notes.org" org-agenda-dir))
  (setq org-agenda-file-gtd (expand-file-name "gtd.org" org-agenda-dir))
  (setq org-agenda-file-journal (expand-file-name "journal.org" org-agenda-dir))
  (setq org-agenda-file-code-snippet (expand-file-name "snippet.org" org-agenda-dir))
  (setq org-default-notes-file (expand-file-name "gtd.org" org-agenda-dir))
  (setq org-agenda-file-blogposts (expand-file-name "all-posts.org" org-agenda-dir))
  (setq org-agenda-files (list org-agenda-dir))

  (require 'org-protocol)

  (setq org-capture-templates
        `(
          ("st" "Study Task" entry
           (file+headline , org-agenda-file-gtd "Study Tasks")
           "* TODO [#B] %^{Brief Description}\tAdded: %T\t:study:\n%?")
          ("lt" "Life Task" entry
           (file+headline , org-agenda-file-journal "Life Tasks")
           "* TODO [#C] %^{Brief Description}\tAdded: %T\t:life:\n%?")
          ("pw" "Work Project Task" entry
           (file+headline ,org-agenda-file-gtd "Work Projects")
           "* TODO [#A] %^{Brief Description}\tAdded: %T\t:Project:work:\n%?")
          ("ps" "Self Project Task" entry
           (file+headline ,org-agenda-file-gtd "Self Projects")
           "* TODO [#B] %^{Brief Description}\tAdded: %T\t:Project:self:\n%?")
          ("pt" "Protocol Text" plain
           (file+function ,(expand-file-name "web.org" +my-org-dir) org-capture-template-goto-link)
           "Added: %U\n\t%:initial" :empty-lines 1 :immediate-finish t :kill-buffer t)
          ("pb" "Protocol Bookmarks" entry
           (file+headline ,(expand-file-name "web.org" +my-org-dir) "Bookmarks")
           "* %:annotation\tAdded: %T" :empty-lines 1 :immediate-finish t :kill-buffer t)
          ("n" "notes" entry (file+headline org-agenda-file-note "Quick notes")
            "* %^{Brief Description}\tAdded:%T\t:note:\n%?"
            :empty-lines 1)
          ("b" "Blog Ideas" entry (file+headline org-agenda-file-note "Blog Ideas")
            "* TODO [#B] %^{Brief Description}\tAdded:%T\t:blog:\n %?"
            :empty-lines 1)
          ("s" "Code Snippet" entry
            (file org-agenda-file-code-snippet)
            "* %^{Brief Description} \n#+BEGIN_SRC %^{language}\n%?\n#+END_SRC")
          ("w" "work" entry (file+headline org-agenda-file-gtd "Works")
            "* TODO [#A] %^{Brief Description}\tAdded: %T\t:work:\n%?"
            :empty-lines 1)
          ("c" "Chrome" entry (file+headline org-agenda-file-note "Quick notes")
            "* TODO [#C] %^{Brief Description}\tAdded: %T\t:link:\n %?\n %(my-retrieve-chrome-current-tab-url)\n"
            :empty-lines 1)
          ("l" "links" entry (file+headline org-agenda-file-note "Quick notes")
            "* TODO [#C] %^{Brief Description}\tAdded: %T\t:link:\n %?\n"
            :empty-lines 1)
          )
        )


  (setq org-agenda-custom-commands
        `(
          ("w" . "任务安排")
          ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
          ("wb" "重要且不紧急的任务" tags-todo "-weekly-monthly-daily+PRIORITY=\"B\"")
          ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
          ("b" "Blog" tags-todo "BLOG")
          ("p" . "项目安排")
          ("pw" tags-todo "PROJECT+WORK+CATEGORY=\"work\"")
          ("ps" tags-todo "PROJECT+DREAM+CATEGORY=\"self\"")
          ("W" "Weekly Review"
            ((stuck "") ;; review stuck projects as designated by org-stuck-projects
            (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
            ))))
  )

(defun org-capture-template-goto-link ()
  (org-capture-put :target (list 'file+headline
                                 (nth 1 (org-capture-get :target))
                                 (org-capture-get :annotation)))
  (org-capture-put-target-region-and-position)
  (widen)
  (let ((hd (nth 2 (org-capture-get :target))))
    (goto-char (point-min))
    (if (re-search-forward
         (format org-complex-heading-regexp-format (regexp-quote hd)) nil t)
        (org-end-of-subtree)
      (goto-char (point-max))
      (or (bolp) (insert "\n"))
      (insert "** " hd "\n"))))

(defun my-org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "typescript" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))
