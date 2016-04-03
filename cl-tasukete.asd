#|
This file is a part of cl-tasukete project.
Copyright (c) 2015 gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-tasukete-asd
  (:use :cl :asdf))
(in-package :cl-tasukete-asd)

(defsystem cl-tasukete
  :version "0.1"
  :author "gos-k"
  :license "MIT"
  :depends-on (:cl-gists
               :cl-annot
               :dissect
               :jonathan
               :local-time)
  :components ((:module "src"
                :components
                ((:file "helper")
                 (:file "key-value")
                 (:file "cl-tasukete"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op cl-tasukete-test))))
