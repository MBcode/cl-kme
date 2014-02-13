;-----------------------julia too
;(require :trivial-shell)
(ql 'trivial-shell)
(lu)
(defun jl (s)
  (trivial-shell:shell-command (format nil "julia -E \"~a\"" s)))

(defun jl1 (s &optional (ret nil))
 (let ((r (trivial-shell:shell-command (format nil "julia -E \"~a\"" s))))
   (if ret r
    (when (stringp r) (eval-str r)))))

(defun jl0 (s)
 ;let ((r (trivial-shell:shell-command (format nil "julia -E \"~a\"" s))))
 (let ((r (trivial-shell:shell-command (format nil "julia-release-basic -E \"~a\"" s))))
   (when (stringp r) (eval-str r))))

;USER(4): (jl1 "1+1")
;2

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
;=this works now:
;
;USER(1): (jl0 "3 + 9 + 8 * 9")
;
;84
;USER(2): (jl0 "3 + 9")
;
;12
;

(defun jlp (s)
 (let ((r (trivial-shell:shell-command (format nil "julia -E \"~a\" --print" s))))
   (when (stringp r) (eval-str r))))

;USER(1): (jlp "3 + 5")
;
;8
;USER(2): (jlp "3 + 9")
;
;12
;USER(3): (jlp "3 + 9 + 8 * 9")
;
;84
;USER(4): (jlp "x = 1; x")
;
;1
;USER(5): (jlp "x = 1;y=2; x+y")
;
;3
;

;;http://blog.leahhanson.us/julia-calling-python-calling-julia.html
;If I can get a direct call going, then try the julia2py part
;
;which will work from the julia prompt:
;julia> using PyCall
;
;julia> pyeval("2+2")
;4
;
;julia> pyeval("str(5)")
;"5"
;
;julia> math = pyimport(:math)
;PyObject <module 'math' from '/Users/bobak/dwn/lang/py/m/anaconda/lib/python2.7/lib-dynload/math.so'>
;
;julia> pycall(math["sin"],Float64,1)
;0.8414709848078965
;
;julia> @pyimport pylab
;Warning: imported binding for transpose overwritten in module __anon__
;
;julia> x = linspace(0,2*pi,1000); y = sin(3*x + 4*cos(2*x));
;
;julia> pylab.plot(x, y; color="red", linewidth=2.0, linestyle="--")
;1-element Array{Any,1}:
; PyObject <matplotlib.lines.Line2D object at 0x10bd64bd0>
;
; julia> pylab.show() 
;
; julia> 
;
;USER(2): (jl1 "help()" t)
;
;"Loading help data...
; Welcome to Julia. The full manual is available at
;
;     http://docs.julialang.org
;
;      To get help on a function, try help(function). To search all help text,
;       try apropos(\"string\"). To see available functions, try help(category),
;        for one of the following categories:
;
;\"ArgParse\"
;\"Getting Around\"
;\"All Objects\"
;\"Types\"
;\"Generic Functions\"
;\"Iteration\"
;\"General Collections\"
;\"Iterable Collections\"
;\"Indexable Collections\"
;\"Associative Collections\"
;\"Set-Like Collections\"
;\"Dequeues\"
;\"Strings\"
;\"I/O\"
;\"Text I/O\"
;\"Memory-mapped I/O\"
;\"Mathematical Functions\"
;\"Data Formats\"
;\"Numbers\"
;\"Random Numbers\"
;\"Arrays\"
;\"Sparse Matrices\"
;\"Linear Algebra\"
;\"Combinatorics\"
;\"Statistics\"
;\"Signal Processing\"
;\"Parallel Computing\"
;\"Distributed Arrays\"
;\"System\"
;\"Errors\"
;\"Tasks\"
;\"BLAS\"
;\"cpp.jl\"
;\"GLPK\"
;\"GZip\"
;\"OptionsMod\"
;\"profile.jl\"
;\"Base.Sort\"
;\"Sound\"
;\"strpack.jl\"
;\"TextWrap\"
;\"Zlib\"
;nothing
;"
;USER(3): 
;USER(4): (jl1 "5+6" t)
;
;"11
;"
;USER(5):;but still str 
;-using jl instead, also see:
;"Using pipes/files as STDIN is not yet supported. Proceed with caution!
;Aborted (core dumped)
;-this is only w/lnx v: Version 0.0.0+107474290.reffd.dirty
;while osx w/v: Version 0.2.0-prerelease+4000 is ok
;USER(3): (jl0 "1+2+3")
;
;6
;
;http://strata.oreilly.com/2014/01/ipython-a-unified-environment-for-interactive-data-analysis.html 
; http://3.bp.blogspot.com/-QpPwDBSrJvk/UtXWB8j0KdI/AAAAAAAADh8/m6egJ2vhkE0/s1600/ipython2.jpg
; http://nbviewer.ipython.org/url/jdj.mit.edu/~stevenj/IJulia%20Preview.ipynb
;
; julia> help("I/O")
; Loading help data...
; Help is available for the following items:
; Base.STDOUT Base.STDERR Base.STDIN Base.open Base.open Base.memio Base.fdio Base.flush Base.close Base.write Base.read Base.read Base.position Base.seek Base.seek_end Base.skip
;
; julia> help("Base.STDIN")
; Base.STDIN
;
;  Global variable referring to the standard input stream.
;
; julia> help("Base.STDOUT")
; Base.STDOUT
;
;    Global variable referring to the standard out stream.
;
;&much more in cdjulia j27; in julia/src/flisp found parser is done in a scheme:
; https://groups.google.com/forum/#!topic/julia-users/qHRDj80rIvA
;
; https://github.com/o-jasper/parse-c-header has to-julia code
