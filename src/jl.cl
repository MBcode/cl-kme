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
; https://github.com/o-jasper/parse-c-header has to-julia code (to wrap c code)
; https://github.com/o-jasper/julia-ffi.git &re:
; USER(3): (j-commandline:command  "julia -E \"~a\" --print" "3 + 5")
;
; "8
; "
; ""
; 0
;
;http://www.meetup.com/Bay-Area-Julia-Users/events/157317652 on http://juliaopt.org/ &parts of
; 2nd talk also possibly applicable to scipm work. Might be a place to try a larger call2julia.
;
;Retweeted by Fernando Perez
; Matthew Frazier ‏@LeafStorm  16h
;Yo dawg, I heard you like Julia, so we put Julia in IPython (and interleaved the call stacks) so you can Julia while you Python. #PyCon2014 
;
;Might use http://forio.com/products/julia-studio/ and then www.nicklevine.org/claude to get lisp
;also try it's web interfaces: https://github.com/JuliaLang/HttpServer.jl /WebSockets.jl
;
;https://github.com/lindahua/MATLAB.jl (so jl->octave?) but so far cl-octave is better?/=ly bad
 
;http://lambda-the-ultimate.org/node/4990 -> http://graydon2.dreamwidth.org/189377.html
;me: would love a f2cl for julia, call-it: jl2cl
 
;http://p-cos.blogspot.be/2014/07/a-lispers-first-impression-of-julia.html
 
;;https://news.ycombinator.com/item?id=8216321 julia0.3  
;* Very efficient interaction with C and Fortran libraries is a core Julia feature, with the ability to pass arrays and structs directly between C and Julia.
;Calling C: http://docs.julialang.org/en/latest/manual/calling-c-and-for...
;* Python libraries can be used through PyCall.jl, which is used most famously to call matplotlib (PyPlot.jl) but also other libraries like pandas (Pandas.jl).
;PyCall.jl: https://github.com/stevengj/PyCall.jl
;PyPlot.jl: https://github.com/stevengj/PyPlot.jl
;Pandas.jl: https://github.com/malmaud/Pandas.jl
;* Java libraries can be used through JavaCall.jl, which is used in Taro.jl to call Apache Tika and Apache POI
;JavaCall.jl: https://github.com/aviks/JavaCall.jl
;Taro.jl: https://github.com/aviks/Taro.jl
;* R libraries can be called through Rif.jl
;Rif.jl: https://github.com/lgautier/Rif.jl
 
;http://mth229.github.io
 
;https://github.com/svaksha/Julia.jl/blob/master/AI.md 

; Viral B. Shah ‏@Viral_B_Shah  6h
;#julialang 0.4-dev on an #ARM #Chromebook. Thanks Isaiah Norton. Next step: world domination. ;-)  
;http://en.wikipedia.org/wiki/Julia_(programming_language) 
 
;http://radar.oreilly.com/2013/10/julias-role-in-data-science.html
; https://github.com/stevengj/PyCall.jl 
; https://github.com/lindahua/MATLAB.jl
;
; @newsyc100  Julia: A fresh approach to numerical computing http://arxiv.org/abs/1411.1607  (http://bit.ly/1siEpNY )
;
; http://www.meetup.com/Bay-Area-Julia-Users/events/218098882/ amos used fortran2julia ;more in news recently &a few new thoughts
;
; http://en.wikipedia.org/wiki/Julia_(programming_language)

; http://www.meetup.com/Multithreaded-Data/events/220356115/ reminded me of:
;@planarrowspace · Feb 25 "the Lisp version is 380 times faster than R and 150 times faster than Python." #Lisp #Rstats #python http://www.springer.com/cda/content/document/cda_downloaddocument/9783790820836-c2.pdf?SGWID=0-0-45-596302-p173832348 …
;as the same sort of claims are being made for julia now

;@JuliaLanguage: .@filipstachura but #JuliaLang _is_ a Lisp! @JeffBezanson's FemtoLisp, to be precise. https://t.co/EcYZ5McZLp
;julia --lisp
;@filipstachura: “Like Lisp, #julialang represents its own code as a data structure of the language itself.” – Metaprogramming https://t.co/Mn0mXPMOas

;=/cl-kme/src> grep julia .note
;cientific Computing and the Joy of Language Interop: http://technicae.cogitat.io/2015/01/scientific-computing-and-joy-of.html … #erlang #python #java #lisp #julia -  
;TextMining_r  Dataframes – Julia, R, Python: https://www.reddit.com/r/textdatamining/comments/3fsxvc/dataframes_julia_r_python/ … #textmining
;python3 ./install-cl-jupyter.py ;setup via: http://totoprojects.blogspot.com/2015/06/installing-ipython-v31-with-r-julia.html?m=1 ;os-x activestate.com/activepython
;ttp://junolab.org/ julia ide, using lightable(originally for clojure); look for lang interop here(still would be nice); still use https://github.com/oakes/Nightcode for clojure ide
;KirkDBorne  Jan 26 Maryland, USA Julia Programming Language Tutorials: http://bit.ly/1lPyO5Q  #abdsc #DataScience #JuliaLang ; http://p-cos.blogspot.com/2014/07/a-lispers-first-impression-of-julia.html
;= 
;Pkg.add("LispSyntax") mentioned above, &use: Pkg.add("RCall") Pkg.add("PyCall") Pkg.add("JavaCall") Pkg.add("Polyglot") https://github.com/wavexx/Polyglot.jl
;    try Lisp syn/repl polygot(but have to make json init files for lisp) & https://github.com/wavexx/Expect.jl Synchronous comm w/interactive programs
; expect would be like the sys-call code above unless I can keep the other process open; so I've also looked @named-pipes other comm,slime,beaker-notebooks...
; beaker said better interlang interop than julia-notebooks(which has lisp kernal), but so far not much works out of the box/is a clear win.
;re:slime https://github.com/jpalardy/vim-slime w/screen,tmux,or whimrepl      ;would be happy going from Rstudio/if possible https://github.com/armgong/rjulia
; if rjulia compiled I could use r.cl techniques to go lsp->R->julia
;if Pkg.add("Redis") loaded maybe try it as a ~blackboard   ;more to look@/try from http://pkg.julialang.org/
;clasp also uses llvm, might be interesting to mix the two, in some way               
;https://github.com/swadey now has https://github.com/swadey/LispREPL.jl over https://github.com/swadey/LispSyntax.jl

;> library("rjulia", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.2") 
;> julia_init() 
;> julia_eval("1+1") 
;[1] 2
