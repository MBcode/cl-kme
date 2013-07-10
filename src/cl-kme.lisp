#|
  This file is a part of cl-kme project.
  Copyright (c) 2013 Mike Bobak (bobak@balisp.org)
|#

(in-package :cl-user)
(defpackage cl-kme
  (:use :cl))
(in-package :cl-kme)

#+sbcl (defun lo () (sb-ext:exit)) ;better one in my .sbclrc
#+sbcl (defun bt (&optional (n 7)) (sb-debug:backtrace n))
;; blah blah blah.
;defun all (&optional (cls 'km::|data|))
(defun all (&optional (cls '|data|))
    (all-instances cls))
