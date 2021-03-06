#|
This file is a part of cl-tasukete project.
Copyright (c) 2015 gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-tasukete
  (:nicknames :tasukete)
  (:use :cl
        :asdf
        :cl-annot
        :jonathan)
  (:import-from :cl-tasukete.key-value
                :tasukete-key-value
                :tasukete-condition
                :tasukete-time
                :tasukete-machine
                :tasukete-operating-system
                :tasukete-lisp-implementation
                :tasukete-loaded-packages
                :tasukete-stack
                :key
                :value
                :get-key
                :get-value))
(in-package :cl-tasukete)

(syntax:use-syntax :annot)

(defvar *default-debugger-hook* nil)
(defvar *debug-information-stock* nil)
(defvar *debug-information-stock-output* nil)
(defvar *use-standard-output* nil)
(defvar *use-gist* nil)

@export
(defvar *system-information-list* '(tasukete-time
                                    tasukete-machine
                                    tasukete-operating-system
                                    tasukete-lisp-implementation
                                    tasukete-loaded-packages))

@export
(defvar *debug-information-list* (append '(tasukete-condition
                                           tasukete-stack)
                                         *system-information-list*))

@export
(defun make-debug-information (condition)
  (mapcar #'(lambda (type)
              (case type
                ('tasukete-condition (make-instance type :condition condition))
                (t (make-instance type))))
          *debug-information-list*))

(defun make-system-information ()
  (mapcar #'make-instance *system-information-list*))

@export
(defmethod debug-information-to-json (debug-information)
  (with-output-to-string*
    (with-object
      (write-key-value "cl-tasukete" debug-information))))

@export
(defun print-json (&optional condition)
  (let* ((information (if condition
                          (make-debug-information condition)
                          (make-system-information)))
         (json (debug-information-to-json information)))
    (princ json)))

@export
(defun debug-information-output ()
  (when *debug-information-stock*
    (let* ((debug-information (pop *debug-information-stock*))
          (tasukete-json (debug-information-to-json debug-information)))
      (when *use-standard-output*
        (format t "~a~%" tasukete-json))
      (when *use-gist*
        (let* ((gist (send-to-gist tasukete-json)))
          (format t "sent to gist : ~a~%" (gist-url gist))))
      (push debug-information *debug-information-stock-output*))))

(defun debugger-hook (condition me-or-my-encapsulation)
  (push (make-debug-information condition) *debug-information-stock*)
  (debug-information-output)
  (funcall *default-debugger-hook* condition me-or-my-encapsulation))

@export
(defun start (&key (use-standard-output t) (use-gist nil))
  (when *default-debugger-hook*
    (error "cl-tasukete has already started."))
  (setf *default-debugger-hook* *debugger-hook*)
  (setf *debugger-hook* #'debugger-hook)
  (setf *use-standard-output* use-standard-output)
  (setf *use-gist* use-gist)
  t)

@export
(defun stop ()
  (unless *default-debugger-hook*
    (error "cl-tasukete has not started."))
  (setf *DEBUGGER-HOOK* *default-debugger-hook*)
  (setf *default-debugger-hook* nil)
  t)
