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
(defclass <key-value> ()
  ((key :initarg :key)
   (value :initarg :value)))

@export
(defmethod get-key ((key-value <key-value>))
  (slot-value key-value 'key))

@export
(defmethod get-value ((key-value <key-value>))
  (slot-value key-value 'value))

(defmethod %to-json ((key-value <key-value>))
  (with-object
    (write-key-value (get-key key-value)
                     (get-value key-value))))
