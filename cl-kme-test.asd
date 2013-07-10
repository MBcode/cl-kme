#|
  This file is a part of cl-kme project.
  Copyright (c) 2013 Mike Bobak (bobak@balisp.org)
|#

(in-package :cl-user)
(defpackage cl-kme-test-asd
  (:use :cl :asdf))
(in-package :cl-kme-test-asd)

(defsystem cl-kme-test
  :author "Mike Bobak"
  :license "LLGPL?"
  :depends-on (:cl-kme
              ;:cl-test-more
               )
  :components ((:module "t"
                :components
                ((:file "cl-kme"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
