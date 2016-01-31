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
        :cl-annot.class
        :jonathan)
  (:import-from :local-time
                :get-universal-time
                :universal-to-timestamp
                :format-timestring)
  (:import-from :cl-gists
                :make-gist
                :gist-url
                :create-gist))
(in-package :cl-tasukete)

(syntax:use-syntax :annot)

(defvar *default-debugger-hook* nil)
(defvar *debug-information-stock* nil)
(defvar *debug-information-stock-output* nil)
(defvar *use-standard-output* nil)
(defvar *use-gist* nil)

@export
(defvar *debug-information-list* '(<condition>
                                   <time>
                                   <machine>
                                   <operating-system>
                                   <lisp-implementation>
                                   <loaded-packages>
                                   <stack>))

@export-class
(defclass <key-value> ()
  ((key :initarg :key)
   (value :initarg :value)))

(defmethod get-key ((key-value <key-value>))
  (slot-value key-value 'key))

(defmethod get-value ((key-value <key-value>))
  (slot-value key-value 'value))

(defmethod %to-json ((key-value <key-value>))
  (with-object
    (write-key-value (get-key key-value)
                     (get-value key-value))))

@export-class
(defclass <condition> (<key-value>)
  ((key :initform "condition")
   (value :initarg :condition
          :initform nil)))

(defmethod get-value ((condition <condition>))
  (format nil "~s" (slot-value condition 'value)))

@export-class
(defclass <time> (<key-value>)
  ((key :initform "time")
   (value :initform (format-timestring nil (universal-to-timestamp
                                            (get-universal-time))))))

@export-class
(defclass <machine> (<key-value>)
  ((key :initform "machine")
   (value :initform (list :instance (machine-instance)
                          :type (machine-type)
                          :version (machine-version)))))

@export-class
(defclass <operating-system> (<key-value>)
  ((key :initform "operating-system")
   (value :initform (list :type (software-type)
                          :version (software-version)))))

@export-class
(defclass <lisp-implementation> (<key-value>)
  ((key :initform "lisp-implementation")
   (value :initform (list :type (lisp-implementation-type)
                          :version (lisp-implementation-version)))))

@export-class
(defclass <loaded-packages> (<key-value>)
  ((key :initform "loaded-packages")
   (value :initform (make-loaded-packages))))

@export-class
(defclass <stack> (<key-value>)
  ((key :initform "stack")
   (value :initform (dissect:stack))))

(defmethod get-value ((stack <stack>))
  (mapcar #'prin1-to-string (slot-value stack 'value)))

@export
(defun make-debug-information (condition)
  (mapcar #'(lambda (type)
              (case type
                ('<condition> (make-instance type :condition condition))
                (t (make-instance type))))
          *debug-information-list*))

@export
(defun make-loaded-packages ()
  (mapcar #'(lambda (name)
              (make-instance '<key-value>
                             :key name
                             :value (component-version (find-system name))))
          (already-loaded-systems)))

@export
(defmethod debug-information-to-json (debug-information)
  (with-object
    (write-key-value "cl-tasukete" debug-information)))

@export
(defun send-to-gist (content)
  (let* ((gist (make-gist :description "This is cl-tasukete output."
                          :public t
                          :files `((:name "cl-tasukete"
                                    :content ,content)))))
    (create-gist gist)))

(defun tasukete (condition me-or-my-encapsulation)
  (push (make-debug-information condition) *debug-information-stock*)
  (debug-information-output)
  (funcall *default-debugger-hook* condition me-or-my-encapsulation))

@export
(defun debug-information-output ()
  (when *debug-information-stock*
    (let* ((debug-information (pop *debug-information-stock*))
          (tasukete-json (debug-information-to-json debug-information)))
      (when *use-standard-output*
        (format t "~s~%" tasukete-json))
      (when *use-gist*
        (let* ((gist (send-to-gist tasukete-json)))
          (format t "sent to gist : ~a~%" (gist-url gist))))
      (push debug-information *debug-information-stock-output*))))

@export
(defun start (&key (use-standard-output t) (use-gist nil))
  (when *default-debugger-hook*
    (error "cl-tasukete has already started."))
  (setf *default-debugger-hook* *debugger-hook*)
  (setf *debugger-hook* 'tasukete)
  (setf *use-standard-output* use-standard-output)
  (setf *use-gist* use-gist)
  t)

@export
(defun stop ()
  (unless *default-debugger-hook*
    (error "cl-tasukete has not started."))
  (setf *DEBUGGER-HOOK* *default-debugger-hook*)
  (setf *default-debugger-hook* nil))
