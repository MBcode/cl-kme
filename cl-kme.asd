#|
  This file is a part of cl-kme project.
  Copyright (c) 2013 Mike Bobak (bobak@balisp.org)
|#
(defun al (l) "asdf load" (asdf:oos 'asdf:load-op l))
#|
  Author: Mike Bobak (bobak@balisp.org)
|#
(al 'ml)

(in-package :cl-user)
(eval-when (:compile-toplevel :load-toplevel :execute)
    (unless (find-package :cl-kme-asd) ;added
    (defpackage cl-kme-asd
      (:use :cl :asdf))
    ))
(in-package :cl-kme-asd)

(defsystem cl-kme
  :version "0.1"
  :author "Mike Bobak"
  :license "LLGPL?"
 ;:depends-on (:km)
  :depends-on (:ml)
  :components ((:module "src"
                  :serial t
                :components
                (
                 (:file "cl-kme") ;defpackage cl-kme, &rest use it
                 (:file "sys")
               ; (:file "util_mb") ;split into 3 parts:
                 (:file "util-mb1")
                 (:file "util-mb2")
                ;(:file "util-mb3")  ;still an error/might be ok
                 (:file "km_2-5-33") ;can go back to (ql 'km) latter  ;recompiles when shouldn't
                 (:file "u2")
                 (:file "tml") ;https://github.com/MBcode/LispUtils/blob/master/tml.cl
                 (:file "kmb")
                ;(:file "load-lib") ;if we want km components ;www.cs.utexas.edu/users/mfkb/RKF/clib.html
                 (:file "llkm") ;if we want km components
                 (:file "io") ;try
                 (:file "workspace") ;try
                 (:file "sparql-w") ;try
                 (:file "lists") ;try
                 (:file "sparql") ;try
                 )))
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
  :in-order-to ((test-op (load-op cl-kme-test))))
