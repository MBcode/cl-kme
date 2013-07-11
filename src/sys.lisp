(cl:in-package #:cl-user)

;(ql 'lisa) ;miss this, km can do some of it
;(lt) ;was test for new u2.lisp fncs
(ql 'cl-csv) ;for io ;look@ data-table, not yet
(ql 'trivial-shell) ;for io
;(al 'future) &/or:
;(ql 'lfarm-test) ;which uses: (ql 'lparallel)
;(al 'erlisp)  ;also sbcl has native mailboxes
;(al 'par-eval) ;uses mpi
;(al 'cl-gui) ;https://github.com/mathematical-systems/cl-gui
;io, consider a dir, have some sqlite, also use lq
;(al '4store) ;for io
;(al 'ontolisp)
;(lq) ;in my .sbclrc ;pnathan/cl-linq
;ML/stat.. libs
(ql 'mgl-example)
(al 'ml) ;https://github.com/MBcode/LispUtils/tree/master/stat/ml-progs/ml Mooney UT-Austin
(ql 'cl-store) ;for mlcl
(al 'mlcl)  ;malecoli  ;has protege.stanford.edu link;also algernon-tab
;(ql 'alexandria) ;for clml
;(al 'clml) ;https://github.com/mathematical-systems/clml ;statistics loads,rest needs full acl/look@
;http://www.cs.utexas.edu/users/qr/QR-software.html sfs,algernon,qsim,qpc
 
;(ql 'cl-bayesnet) ;get into dne or get around

;(al 'sapa)
;(ql 'cl-mathstats) ;have cls on linux, miss xlispstat/vista viz

;(ql 'rcl) ;also (ql 'clpython)
;(al 'cl-octave) ;or just redo Ng's ML in other e.g.:
;(ql 'lisp-matrix) ;gsll, etc..
;(ql 'zeromq) ;or similar to ipython if possible
;(ql 'screamer) ;try on optimization assignments
;(ql 'cl-graph) ;might want2try
;(ql 'kr) ;km has most of ;miss garnet
;(ql 'arnesi) ;for dt
;(al 'cl-decision-tree) ;https://github.com/kroger/cl-decision-tree
;or: ;might skip these soon:
 
;(ql 'lisp-unit)
;(al 'decisiontree)        ;https://github.com/reubencornel/cl-decisiontree

;or
;http://www.cc.gatech.edu/classes/cs3361_99_spring/projects/project3/decision-tree.lisp or
;http://www.cs.cmu.edu/afs/cs/project/theo-11/www/decision-trees.lisp but algo right on km ins
;or
;(al 'cl-decision-tree)   ;https://github.com/kroger/cl-decision-tree.git
;&/or start by integrating a pkg w/a wider variety of routines
;=deciding on how to interface the km/e data w/the present dt data

;https://github.com/pieterw cl-arff-parser.asd cl-framenet.asd cl-network.asd
;langutils cl-nlp
