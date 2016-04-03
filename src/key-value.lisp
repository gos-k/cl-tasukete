#|
This file is a part of cl-tasukete project.
Copyright (c) 2015 gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-tasukete.key-value
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
(in-package :cl-tasukete.key-value)

(syntax:use-syntax :annot)

@export-class
(defclass tasukete-key-value ()
  ((key :initarg :key)
   (value :initarg :value)))

@export
(defmethod get-key ((key-value tasukete-key-value))
  (slot-value key-value 'key))

@export
(defmethod get-value ((key-value tasukete-key-value))
  (slot-value key-value 'value))

(defmethod %to-json ((key-value tasukete-key-value))
  (with-object
    (write-key-value (get-key key-value)
                     (get-value key-value))))

@export-class
(defclass tasukete-condition (tasukete-key-value)
  ((key :initform "condition")
   (value :initarg :condition
          :initform nil)))

(defmethod get-value ((condition tasukete-condition))
  (format nil "~s" (slot-value condition 'value)))

@export-class
(defclass tasukete-time (tasukete-key-value)
  ((key :initform "time")
   (value :initform (format-timestring nil (universal-to-timestamp
                                            (get-universal-time))))))

@export-class
(defclass tasukete-machine (tasukete-key-value)
  ((key :initform "machine")
   (value :initform (list :instance (machine-instance)
                          :type (machine-type)
                          :version (machine-version)))))

@export-class
(defclass tasukete-operating-system (tasukete-key-value)
  ((key :initform "operating-system")
   (value :initform (list :type (software-type)
                          :version (software-version)))))
