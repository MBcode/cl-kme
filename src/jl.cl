;-----------------------julia too
;(require :trivial-shell)
(ql 'trivial-shell)
(lu)
(defun jl1 (s)
 (let ((r (trivial-shell:shell-command (format nil "julia -E \"~a\"" s))))
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
; fix:
; USER(3): (jl1 "help()")
;
; debugger invoked on a UNBOUND-VARIABLE in thread
; #<THREAD "main thread" RUNNING {1002AC3613}>:
;   The variable LOADING is unbound.
