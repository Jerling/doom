;;; private/my-cc/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun my-gdb-executable (debuggee-path)
  "Start debugging an executable at DEBUGGEE-PATH in the current session.
If no session is available, one is automatically created."
  (interactive
   (list (expand-file-name (read-file-name "Select executable to debug: " "build/bin"
                                           gdb--previous-executable t nil 'file-executable-p))))
  (let ((session (or (gdb--infer-session) (gdb-create-session))))
    (setq gdb--previous-executable debuggee-path)
    (setf (gdb--session-debuggee-path session) debuggee-path)

    (with-selected-frame (gdb--session-frame session)
      (gdb--command (concat "-file-exec-and-symbols " (gdb--escape-argument (gdb--local-path debuggee-path))))
      (gdb--command "-file-list-exec-source-file" 'gdb--context-initial-file)
      (gdb--rename-buffers-with-debuggee debuggee-path))

    (cl-loop for frame in (frame-list)
             when (eq (frame-parameter frame 'gdb--session) session)
             do (gdb--rename-frame frame))))
