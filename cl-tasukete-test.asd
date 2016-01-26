#|
This file is a part of cl-tasukete project.
Copyright (c) 2015 gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-tasukete-test-asd
  (:use :cl :asdf))
(in-package :cl-tasukete-test-asd)

(defsystem cl-tasukete-test
  :author "gos-k"
  :license "MIT"
  :depends-on (:cl-tasukete
               :dissect
               :prove)
  :components ((:module "t"
                :components
                ((:file "init")
                 (:test-file "cl-tasukete"))))
  :description "Test system for cl-tasukete"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))