#|
This file is a part of cl-tasukete project.
Copyright (c) 2015 gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-tasukete-test
  (:use :cl
        :prove
        :cl-tasukete-test.init)
  (:import-from :cl-tasukete
                :<loaded-packages>
                :<stack>
                :value
                :send-to-gist
                :make-debug-information
                :make-loaded-packages))
(in-package :cl-tasukete-test)

(plan 3)

(subtest "make-debug-information"
  (let ((debug-information (make-debug-information nil)))
    (is-type debug-information 'list "can create debug-information list"))
  (with-stub-asdf
    (let ((debug-information (make-debug-information nil)))
      (is (slot-value (find-type '<loaded-packages> debug-information)
                      'value)
          `(("dummy" . "0.0.0") ("dummy-test" . "1.2.3"))
          "can get loaded-packages")))
  (with-stub-dissect
    (let ((debug-information (make-debug-information nil)))
      (let ((stack (slot-value (find-type '<stack> debug-information)
                               'value)))
        (is-type stack 'list "can get stack list.")
        (is-type (car stack) 'dissect:call "can get call object.")
        (let ((x (car stack)))
          (is (dissect:pos x) 1 "can get pos.")
          (is (dissect:call x) "DUMMY-FUNCTION" "can get call.")
          (is (dissect:args x) '(2) "can get args.")
          (is (dissect:file x) "dummy-file.lisp" "can get file.")
          (is (dissect:line x) 3 "can get line.")
          (is (dissect:form x) "(defun dummy-function ())" "can get form."))))))

(subtest "make-load-packages"
  (with-stub-asdf
    (is (make-loaded-packages) `(("dummy" . "0.0.0") ("dummy-test" . "1.2.3"))
        "can call make-loaded-packages")))

(subtest "send-to-gist"
  (with-stub-cl-gists
    (let ((gist (send-to-gist "dummy")))
      (is (cl-gists:gist-url gist) "https://api.github.com/gists/dummy"
          "can call send-to-gist"))))

(finalize)