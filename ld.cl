;(lu) from my .sbclrc to load util_mb
(defun in () (in-package :cl-kme))

(al 'cl-kme)
(in)
;(al 'cl-kme-test) ;or:
(load-kb "kme.km")
(sv-cls "it" "data")
(taxonomy)
(show "it")

;(defun READ-FILE-TO-STRING (f) (READ-FILE-STRING f)) ;put in
(load "src/util_mb.lisp" :print t) ;asdf load problems otherwise 
 
;w/io.lisp can try
;(cl-kme::read-data-csv)
;(taxonomy)

;;will work this in as a test of ml-progs
;(al 'ml)
;(trace make-saved-tests) ;this creates a file that has to be removed before the next run
;(make-saved-tests "sample-dna-saved-tests.lisp" 10 80 '(10 25 40 80) nil "ml/dna-standard.lisp")
;;(make-saved-tests "sample-dna-saved-tests.lisp" 10 80 '(10 25 40 80) nil "/Users/bobak/dwn/lang/lsp/code/project/src/ml-progs/ml/dna-standard.lisp") 
