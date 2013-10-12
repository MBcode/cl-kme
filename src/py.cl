(ql 'clpython.test)
(use-package :clpython) ;make a use-new so uses original symbols from main pks if overlaps

(defun ps (s &optional (one-expr nil)) ;from test
    (values (parse s :one-expr one-expr)))

(parse "0.5")
;USER(6): (parse "0.5")
;
;(CLPYTHON.AST.NODE:|module-stmt|
;   (CLPYTHON.AST.NODE:|suite-stmt|
;       ((CLPYTHON.AST.TOKEN:|literal-expr| :NUMBER 0.5d0))))
;USER(7): 
;
;(defun ps (s &optional (one-expr nil))
;    (values (parse s :one-expr one-expr)))
;
;PS
;USER(8): (ps "0.5")
;
;(CLPYTHON.AST.NODE:|module-stmt|
;   (CLPYTHON.AST.NODE:|suite-stmt|
;       ((CLPYTHON.AST.TOKEN:|literal-expr| :NUMBER 0.5d0))))
;USER(9): (ps "x[1](2).a3" t)
;
;(CLPYTHON.AST.NODE:|attributeref-expr|
;   (CLPYTHON.AST.NODE:|call-expr|
;       (CLPYTHON.AST.NODE:|subscription-expr|
;            (CLPYTHON.AST.NODE:|identifier-expr| CLPYTHON.USER::|x|)
;               (CLPYTHON.AST.TOKEN:|literal-expr| :NUMBER 1))
;         ((CLPYTHON.AST.TOKEN:|literal-expr| :NUMBER 2)) NIL NIL NIL)
;    (CLPYTHON.AST.NODE:|identifier-expr| CLPYTHON.USER::|a3|))
;USER(10):  (ps "x[1](len=2).a3" t)
;
;(CLPYTHON.AST.NODE:|attributeref-expr|
;   (CLPYTHON.AST.NODE:|call-expr|
;       (CLPYTHON.AST.NODE:|subscription-expr|
;            (CLPYTHON.AST.NODE:|identifier-expr| CLPYTHON.USER::|x|)
;               (CLPYTHON.AST.TOKEN:|literal-expr| :NUMBER 1))
;         NIL
;           (((CLPYTHON.AST.NODE:|identifier-expr| CLPYTHON.USER.BUILTIN.FUNCTION:|len|)
;                 (CLPYTHON.AST.TOKEN:|literal-expr| :NUMBER 2)))
;             NIL NIL)
;    (CLPYTHON.AST.NODE:|identifier-expr| CLPYTHON.USER::|a3|))
;USER(11): (ps "f(1, 2, y=3, *args, **kw)" t)
;
;(CLPYTHON.AST.NODE:|call-expr|
;   (CLPYTHON.AST.NODE:|identifier-expr| CLPYTHON.USER::|f|)
;    ((CLPYTHON.AST.TOKEN:|literal-expr| :NUMBER 1)
;       (CLPYTHON.AST.TOKEN:|literal-expr| :NUMBER 2))
;     (((CLPYTHON.AST.NODE:|identifier-expr| CLPYTHON.USER::|y|)
;          (CLPYTHON.AST.TOKEN:|literal-expr| :NUMBER 3)))
;      (CLPYTHON.AST.NODE:|identifier-expr| CLPYTHON.USER::|args|)
;       (CLPYTHON.AST.NODE:|identifier-expr| CLPYTHON.USER::|kw|))
;USER(12): (run "1")
;1
;USER(13): (run "import math; assert 3.14 < math.pi < 3.15")
;NIL
;USER(14): (run "import math; assert 2.71 < math.e < 2.72")
;NIL
;;look@ https://github.com/doomcat/pySpark  &RRDs ..
;;       &then go http://py4j.sourceforge.net/ 2java libs more easily?
;http://spark.incubator.apache.org/docs/0.7.2/api/pyspark/pyspark.rdd.RDD-class.html
;Still interested in amplab MLBase like work;maybe build off base RRD ops vs some old code
; &/or compose as much as possible&..
;-----------------------julia too
;(require :trivial-shell)
(ql 'trivial-shell)
;(lu)
(defun jl1 (s)
  (trivial-shell:shell-command (format nil "julia -E \"~a\"" s)))

;there is a julia ipython connection so use clpython instead
;USER(2): (jl1 "1+1")
;
;"2
;"
;"Using pipes/files as STDIN is not yet supported. Proceed with caution!
;Aborted (core dumped)
;"
;134
;USER(3):