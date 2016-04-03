#|
This file is a part of cl-tasukete project.
Copyright (c) 2015 gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-tasukete-test.helper
  (:use :cl
        :prove
        :cl-tasukete-test.init)
  (:import-from :cl-tasukete.helper
                :make-loaded-packages))
(in-package :cl-tasukete-test.helper)

(plan nil)

(subtest "make-load-packages"
  (with-stub-asdf
    (let ((packages (make-loaded-packages)))
      (is (length packages) 2)
      (is (car (nth 0 packages)) "dummy")
      (is (cdr (nth 0 packages)) "0.0.0")
      (is (car (nth 1 packages)) "dummy-test")
      (is (cdr (nth 1 packages)) "1.2.3"))))

(finalize)
