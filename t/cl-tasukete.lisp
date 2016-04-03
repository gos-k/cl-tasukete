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
                :send-to-gist
                :make-debug-information
                :make-loaded-packages)
  (:import-from :cl-tasukete.key-value
                :tasukete-key-value
                :value
                :get-key
                :get-value))
(in-package :cl-tasukete-test)

(plan 3)

(subtest "make-debug-information"
  (let ((debug-information (make-debug-information nil)))
    (is-type debug-information 'list "can create debug-information list"))
  (with-stub-asdf
    (let* ((debug-information (make-debug-information nil))
           (value (slot-value (find-type '<loaded-packages> debug-information)
                              'value)))
      (is (length value) 2 "2 elements")
      (is-type (nth 0 value) 'tasukete-key-value "type tasukete-key-value")
      (is-type (nth 1 value) 'tasukete-key-value "type tasukete-key-value")))
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
    (let ((packages (make-loaded-packages)))
      (is (length packages) 2)
      (is (get-key (nth 0 packages)) "dummy")
      (is (get-value (nth 0 packages)) "0.0.0")
      (is (get-key (nth 1 packages)) "dummy-test")
      (is (get-value (nth 1 packages)) "1.2.3"))))

(subtest "send-to-gist"
  (with-stub-cl-gists
    (let ((gist (send-to-gist "dummy")))
      (is (cl-gists:gist-url gist) "https://api.github.com/gists/dummy"
          "can call send-to-gist"))))

(finalize)
