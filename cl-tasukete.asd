#|
This file is a part of cl-tasukete project.
Copyright (c) 2015 gos-k (mag4.elan@gmail.com)
|#

(defsystem "cl-tasukete"
  :version "0.1"
  :author "gos-k"
  :license "MIT"
  :depends-on ("cl-gists"
               "cl-annot"
               "dissect"
               "jonathan"
               "local-time")
  :components ((:module "src"
                :components
                ((:file "helper")
                 (:file "key-value")
                 (:file "cl-tasukete"))))
  ;; :long-description #.(read-file-string (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "cl-tasukete-test"))))
