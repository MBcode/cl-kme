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

;(finalize)
