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
;(lt)
(lu)
(require :trivial-shell)
;defun tshell-command (str)
(defun ts (str)
 (trivial-shell:shell-command (to-str str)))
;alt2 cl-python:
(defun tpy (s) (ts (str-cat "python t.py " s)))
;USER(1): (tpy "2+3")
;
;"['t.py', '2+3']
;eval:2+3
;5
;"
(defun jl1 (s)
  (trivial-shell:shell-command (format nil "julia -E \"~a\"" s)))

;there is a julia ipython connection so use clpython instead
;https://github.com/JuliaLang/IJulia.jl  though uses zmq, which I'd love to just go to directly
;julia> Pkg.add("IJulia")
;USER(2): (jl1 "1+1")
;
;"2
;"
;"Using pipes/files as STDIN is not yet supported. Proceed with caution!
;Aborted (core dumped)
;"
;134
;USER(3):
;-improved in jl.cl
;==================
;plotting:    if not rcl2ggplot
;https://github.com/yhat/ggplot
;http://blog.leahhanson.us/julia-calling-python-calling-julia.html
;
;try to get jl.cl going, as this isn't working yet, even directly from python:
;
;>>> j = julia.Julia()
;Traceback (most recent call last):
;  File "<stdin>", line 1, in <module>
;  File "julia/core.py", line 86, in __init__
;    % (jpath_so, jpath_dylib))
;ValueError: Julia release library not found
;  searched /Users/bobak/dwn/sci/math/env/julia/Julia-0.2.0-pre-afd47d8ba8.app/Contents/Resources/julia/lib/libjulia-release.so
;  and /Users/bobak/dwn/sci/math/env/julia/Julia-0.2.0-pre-afd47d8ba8.app/Contents/Resources/julia/lib/libjulia-release.dylib
;>>> j.run("2+2")
;Traceback (most recent call last):
;  File "<stdin>", line 1, in <module>
;  NameError: name 'j' is not defined
;>>>
;
;might start calling out to: https://github.com/halgari/clojure-py ;could still go mq comm route too
;     _maybe http://docs.hylang.org/en/latest/ instead of clj-py
;  _maybe nrepl/slime or even easier start to send code2it, &then have it run other py code
;http://cjelupton.wordpress.com/2013/09/26/hacking-d-wave-one-in-common-lisp/
;http://cjelupton.wordpress.com/2013/11/12/hacking-d-wave-one-in-common-lisp-introducing-silver-sword/
;https://github.com/pinterface/burgled-batteries
;http://www.talyarkoni.org/blog/2013/11/18/the-homogenization-of-scientific-computing-or-why-python-is-steadily-eating-other-languages-lunch/ but wish it was4lisp
;wf: https://github.com/birc-aeh/gwf
;check on sb-posix on linux &get trivial-shell &/or pipe code to get ipy working
;
;tried rpy but had probs
;
;try interacting w/: https://github.com/msiemens/tinydb
;
;http://stackoverflow.com/questions/20226663/timing-problems-in-lisp-and-python-programs-communicating-over-sockets
;slime/swank nREPL like comm
;like: http://asciinema.org/a/1148 https://github.com/lmacken/pyrasite
;
;Installed: https://github.com/redsh/IPyXMPP &on the lisp side:
;  #<SYSTEM cl-xmpp-tls / cl-xmpp-0.8.1 / quicklisp 2014-03-17>
