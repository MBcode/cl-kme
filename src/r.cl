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
;
;https://github.com/VincentToups/rcl/blob/master/examples/ggplot-book.lisp
;https://github.com/VincentToups/rcl/blob/master/examples/ggplot.lisp
;
;plotting:
;USER(2): (in-package :rcl)
;
;#<PACKAGE "RCL">
;R(3): (r-init)
;WARNING: R already running
;
;:RUNNING
;R(4): (enable-rcl-syntax)
;
;R(5): [library 'ggplot2]
;WARNING: string attribute: profmem
;;R! Loading required package: reshape
;;R! Loading required package: plyr
;;R! 
;;R! Attaching package: ‘reshape’
;;R! 
;;R! The following object(s) are masked from ‘package:plyr’:
;;R! 
;;R!     rename, round_any
;;R! 
;;R! Loading required package: grid
;;R! Loading required package: proto
;("ggplot2" "proto" "grid" "reshape" "plyr" "stats" "graphics" "grDevices"
; "utils" "datasets" "methods" "base")
;R(6): [print [_qplot 'mpg 'wt :data 'mtcars :size 'cyl :geom '("smooth" "point")]]
;
;http://www.r-bloggers.com/r-fiddle-an-online-playground-for-r-code/ other more web based interaction
;
;cl->r then rJava ;might be easier than cl-j  ;also clj over java libs, then make a websrvc 
;
;https://amplab.cs.berkeley.edu/2014/01/26/large-scale-data-analysis-made-easier-with-sparkr/
;
;use of sparql:
;http://events.linkeddata.org/ldow2014/papers/ldow2014_paper_07.pdf 
;
;http://paddytherabbit.com/exploring-telenovela-with-dbpedia-r-and-gephi/
;http://www.reddit.com/r/semanticweb/comments/21w5cr/rfc_reproducible_statistics_and_linked_data/
;
;data-cube
;http://www.w3.org/TR/vocab-data-cube/ http://www.w3.org/2011/gld/wiki/Data_Cube_Implementations

;https://www.google.com/search?q=R+to+octave  or might just try:
;http://www.sagemath.org/doc/reference/interfaces/sage/interfaces/octave.html

;Jeroen Janssens ‏@jeroenhjanssens  5h
;Rio (#rstats from the command line) has been updated to correctly output vectors | http://bit.ly/RioScript 
;http://jeroenjanssens.com/2013/09/19/seven-command-line-tools-for-data-science.html 
;https://github.com/jeroenjanssens/command-line-tools-for-data-science 
;
;http://www.r-bloggers.com/controlling-rstudio-python-child-processes
; if not mq try json interop w/R's rjson or RJSONIO
; https://github.com/jeroenooms/jsonlite http://arxiv.org/abs/1403.2805 
; The jsonlite Package: A Practical and Consistent Mapping Between JSON Data and R Objects
; http://arxiv.org/abs/1401.7372 RProtoBuf: Efficient Cross-Language Data Serialization in R
; https://www.opencpu.org/ &parenscript/?

;Scientific Python ‏@SciPyTip  see if easier to just py interface?
;Calling R from Python with RPy http://rpy.sourceforge.net/  
;
;http://rpython.r-forge.r-project.org loaded in rstudio&examples work
;> library("rPython", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
;Loading required package: RJSONIO
;> python.call( "len", 1:3 )
;[1] 3
;> a <- 1:4
;> b <- 5:8
;> python.exec( "def concat(a,b): return a+b" )
;> python.call( "concat", a, b)
;[1] 1 2 3 4 5 6 7 8
;> python.assign( "a",  "hola hola" )
;> python.method.call( "a", "split", " " )
;[1] "hola" "hola" 
 
;http://databricks.com/blog/2014/08/27/statistics-functionality-in-spark.html SparkR?
