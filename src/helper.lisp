#|
This file is a part of cl-tasukete project.
Copyright (c) 2015 gos-k (mag4.elan@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-tasukete.helper
  (:use :cl
        :asdf
        :cl-annot)
  (:import-from :cl-gists
                :make-gist
                :gist-url
                :create-gist))
(in-package :cl-tasukete.helper)

(syntax:use-syntax :annot)

@export
(defun make-loaded-packages ()
  (loop for name in (already-loaded-systems)
        collecting (cons name
                         (component-version (find-system name)))))

@export
(defun send-to-gist (content)
  (let* ((gist (make-gist :description "This is cl-tasukete output."
                          :public t
                          :files `((:name "cl-tasukete"
                                    :content ,content)))))
    (create-gist gist)))
