#|
This file is a part of cl-tasukete project.
Copyright (c) 2015 gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-tasukete-test.init
  (:use :cl
        :cl-annot
        :cl-tasukete))
(in-package :cl-tasukete-test.init)
(syntax:use-syntax :annot)

@export
(defmacro with-stub-asdf (&body body)
  (let ((already-loaded-systems (gensym "already-loaded-systems"))
        (find-system (gensym "find-system"))
        (component-version (gensym "componet-version")))
    `(let ((,already-loaded-systems (symbol-function 'asdf:already-loaded-systems))
           (,find-system (symbol-function 'asdf:find-system))
           (,component-version (symbol-function 'asdf:component-version)))

       (setf (symbol-function 'asdf:already-loaded-systems)
             (lambda () (list "dummy" "dummy-test")))
       (setf (symbol-function 'asdf:find-system)
             (lambda (x) (cdr (assoc x `(("dummy" . "dummy") ("dummy-test" . "dummy-test"))))))
       (setf (symbol-function 'asdf:component-version)
             (lambda (x) (cdr (assoc x `(("dummy" . "0.0.0") ("dummy-test" . "1.2.3"))))))

       (unwind-protect
            (progn ,@body)
         (progn
           (setf (symbol-function 'asdf:already-loaded-systems) ,already-loaded-systems)
           (setf (symbol-function 'asdf:find-system) ,find-system)
           (setf (symbol-function 'asdf:component-version) ,component-version)
           t)))))

@export
(defmacro with-stub-dissect (&body body)
  (let ((stack (gensym "stack")))
    `(let ((,stack (symbol-function 'dissect:stack)))
       (setf (symbol-function 'dissect:stack)
             (lambda () (list (make-instance 'dissect:call
                                             :pos 1
                                             :call "DUMMY-FUNCTION"
                                             :args '(2)
                                             :file "dummy-file.lisp"
                                             :line 3
                                             :form "(defun dummy-function ())"))))
       (unwind-protect
            (progn ,@body)
         (progn
           (setf (symbol-function 'dissect:stack) ,stack)
           t)))))

@export
(defmacro with-stub-cl-gists (&body body)
  (let ((create-gist (gensym "create-gist")))
    `(let ((,create-gist (symbol-function 'cl-gists:create-gist)))
       (setf (symbol-function 'cl-gists:create-gist)
             (lambda (x)
               (declare (ignore x))
               (cl-gists:make-gist :url "https://api.github.com/gists/dummy")))
       (unwind-protect
            (progn ,@body)
         (progn
           (setf (symbol-function 'cl-gists:create-gist) ,create-gist)
           t)))))

@export
(defun find-type (type sequence)
  (find-if #'(lambda (x) (typep x type)) sequence))
