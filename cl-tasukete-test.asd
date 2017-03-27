#|
This file is a part of cl-tasukete project.
Copyright (c) 2015 gos-k (mag4.elan@gmail.com)
|#

(defsystem "cl-tasukete-test"
  :author "gos-k"
  :license "MIT"
  :depends-on ("cl-tasukete"
               "dissect"
               "prove")
  :components ((:module "t"
                :components
                ((:file "init")
                 (:test-file "helper")
                 (:test-file "cl-tasukete"))))
  :description "Test system for cl-tasukete"

  :defsystem-depends-on ("prove-asdf")
  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
