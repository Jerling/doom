;;; private/my-cc/config.el -*- lexical-binding: t; -*-

;;(def-package! google-c-style
;; :config
;; (add-hook! (c-mode c++-mode) #'google-set-c-style))

;; (def-package! clang-format
;;   :after (ccls)
;;   :commands (clang-format-region clang-format-buffer))

(defvar C-PROJECT (> 1 0))

(def-package! cmake-project
  :after cc-mode
  :commands (cp-project-refresh cp-project-new cp-project-debug)
  :config
  (add-hook! (c-mode c++-mode) #'cp-project-refresh)
  (defun +my-cc-gen-template()
    (concat
     (format "cmake_minimum_required(VERSION %s)" cp-cmake-minimum-version)
     (format "\nset(PROJECT_NAME \"%s\")" (file-name-nondirectory (directory-file-name cp-project-root-cache)))
     (if C-PROJECT
         (format "\nproject(${PROJECT_NAME} C)")
       (format "\nproject(${PROJECT_NAME})"))
     (format "\nset(CMAKE_EXPORT_COMPILE_COMMANDS ON)")
     (format  "\nset(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)")
     (format "\nset(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)")
     (if C-PROJECT
         (format "\n\nadd_executable(main main.c)")
       (format "\n\nadd_executable(main main.cpp)"))
     ))
  (setq cp-project-template-function '+my-cc-gen-template)
  (when (and (not IS-WINDOWS) (featurep! :private lsp))
    (add-hook
     'cp-after-new-project-hook
     #'(lambda()
         (shell-command
          (concat
           (if C-PROJECT
               (format "echo \"\nint main(int argc, char *argv[]) {\n  return 0;\n}\" > main.c && ")
             (format "echo \"\nint main(int argc, char *argv[]) {\n  return 0;\n}\" > main.cpp && ")
             )
           (format "touch %s/compile_commands.json && " cp-project-build-directory)
           (format "ln -sf %s/compile_commands.json compile_commands.json" cp-project-build-directory)))
         (cp-project-gen))))
  (map!
   (:mode (c-mode c++-mode)
     :gnvime "<f7>" #'cp-project-build
     :gnvime "<f8>" #'cp-project-run)))

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
(setq tramp-default-method "ssh")
(setq tramp-shell-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>] *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*")
