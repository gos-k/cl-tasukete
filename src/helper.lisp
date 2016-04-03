#|
This file is a part of cl-tasukete project.
Copyright (c) 2015 gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-tasukete.helper
  (:use :cl
        :asdf
        :cl-annot))
(in-package :cl-tasukete.helper)

(syntax:use-syntax :annot)

@export
(defun make-loaded-packages ()
  (loop for name in (already-loaded-systems)
        collecting (cons name
                         (component-version (find-system name)))))

