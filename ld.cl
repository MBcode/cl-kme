;(lu)
(defun in () (in-package :cl-kme))

(al 'cl-kme-test)
;same as all below:
;(al 'cl-kme)
;(in)
;(load-kb "kme.km")
;(sv-cls "it" "data")
;(taxonomy)
;(show "it")
 
;w/io.lisp can try
;(cl-kme::read-data-csv)
;(taxonomy)

;will work this in as a test of ml-progs
(al 'ml)
(trace make-saved-tests) ;this creates a file that has to be removed before the next run
(make-saved-tests "sample-dna-saved-tests.lisp" 10 80 '(10 25 40 80) nil "ml/dna-standard.lisp")
;(make-saved-tests "sample-dna-saved-tests.lisp" 10 80 '(10 25 40 80) nil "/Users/bobak/dwn/lang/lsp/code/project/src/ml-progs/ml/dna-standard.lisp") 
