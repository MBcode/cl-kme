#|
  This file is a part of cl-kme project.
  Copyright (c) 2013 Mike Bobak (bobak@balisp.org)
|#

(in-package :cl-user)
(defpackage cl-kme-test
  (:use :cl
        :cl-kme
       ;:cl-test-more
        ))
;(in-package :cl-kme-test)
(in-package :cl-kme) ;for now

;(plan nil)

;; blah blah blah.
(load-kb "kme.km")
(sv-cls "it" "data")
(taxonomy)
(show "it")

;now test io.lisp
(read-data-csv)
(taxonomy)

;ml-prog test  ;have ln -s .... ml   ;sort out the package issues
;ftp://ftp.cs.utexas.edu/.snapshot/nightly.10/pub/mooney/ml-progs/sample-univ-tester-trace
;(cl:make-saved-tests "sample-dna-saved-tests.lisp" 10 80 '(10 25 40 80) nil "ml/dna-standard.lisp")

;(finalize)
