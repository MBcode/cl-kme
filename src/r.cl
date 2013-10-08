(ql 'rcl-test)
(use-package :rcl)
(r-init)
(r "R.Version")

;USER(2): (r "+" 2 2)
;(4)
;USER(3): (r "+" 20 '(2 3 4))
;(22 23 24)
;USER(4): (r "list" '("A" "B") '("C" "D")) 
;(("A" "B") ("C" "D"))
;USER(5): (r "matrix" '(1 2 3 4) :nrow 2 :byrow t)
;#<RCL::R-MATRIX #2A((1 2) (3 4)) NIL {1005B6B973}>
;USER(6): (rcl::matrix *)
;#2A((1 2) (3 4))
;maybe http://cran.r-project.org/web/packages/snow/index.html vs cl-pvm
