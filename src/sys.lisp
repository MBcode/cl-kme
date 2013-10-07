(cl:in-package #:cl-user)
;Have had warning that I just go through, but have needed some(load)debugging, have also had thoughts of bigger reorg.
;have to interively just go at it; maybe by having ground of things that are loaded, w/when member 'ml 'sw 'pd ..etc
(defvar *t* '())
(defvar *tst* nil)
;  might have subtopics, /could do a prefix match, but just start w/a bit of this.
;Should still get more of this in an asd, w/dependancies, Such that un-needed thing won't be loaded if not needed.
;
;also looking at xcvb  /an agent-based view could have different instances w/diff makeups
;Might start w/much more simple km core, &just load that /then ..
;
;should move more of this to the asd file, might start w/another skelton&go more agent oriented
; ~workflow, maybe something like vistrails; redo in kme soon ..
;
;too many directions, started: https://venture-lab.org/designthinking hope to get focus
;   class won't have special pprj till late aug, but still before sept soc deadline
;   still I have to shorten my exploratory bents, &get more commited here
;See what other http://mike.bobak.googlepages.com/classes I can work in.
;.. 
;something like: https://github.com/machinalis/quepy would be cool quepy.machinalis.com
;
;; Want2start thinking apps, influences:(metadata/network/recommender)classes,&new metamap13 install
;;   which could pull some km3 src out for use.
;
; 4news ones, need2start commiting from home server/hope i goes through under right login this time
;Probably have *tst* so some libs not being used can be skipped
;look@using gbbopen ql pprjs
;(ql 'lisa) ;miss this, km can do some of it
; also: minimal-production-system gbbopen ..
;(lt) ;was test for new u2.lisp fncs
(ql 'cl-csv) ;for io ;look@ data-table, not yet
(ql 'trivial-shell) ;for io
;cl-ace works w/the osx git version of cxml /ql v has had probs4awhile
;s-xml xmls for sparql-w:
(when (member 'rdf *t*)
 (ql 'xmls) ;might get rid of
 (ql 's-xml) ;might get rid of
 (ql 'cl-rdfxml)
 )
(ql 'cl+ssl)
;(al '4store) ;or the sbcl-4store file ;was considering virtuoso/but this is faster
;(load "workspace.lisp" :print t) ;from sbcl-4store ;in asd file now
(defparameter *server-url* "http://localhost:8000/")
(defparameter *graph* "<http://ox.electronic-quill.net/4store-test>")
;get sbcl-4store workspace.lisp libs in too
             ;prob
  ;was almost just going to use lsp2basically curl for it, but cl-4store works
;no twinql yet, but sicl can parse a qry
;(ql '(drakma cxml fare-matcher))
(ql '(#:drakma #:cl-json #:alexandria #:babel)) ;then could load generized sparql.lisp
(when (member 'sicl *t*)
 (ql 'puri)
;(import 'puri::render-uri)
;(import 'puri::uri-p)
;(al 'dbpedia-sparql) ;try: https://github.com/daimrod/dbpedia-sparql.git
 (ql 'lexer)
;(ql 'rdf) https://github.com/turbo24prg/rdf/ ;try cl-rdfxml
 (al 'rdf-utils)
 (al 'yacc) ;http://www.pps.univ-paris-diderot.fr/~jch/software/cl-yacc/
 (ql 'cl-ppcre)
 (ql 'cl-interpol)
 (al 'sicl) ;https://github.com/turbolent/sicl
 )
;mix sicl w/other sparql code/maybe even simple factQL like ql,ultimately from KM qry
;(al 'future) &/or:
;(ql 'lfarm-test) ;which uses: (ql 'lparallel)
(when *tst* (al 'erlisp))  ;also sbcl has native mailboxes  
; try erlisp/&/or agt/mailbox formalism, might be best to start earlier w/this
;  also easier if diff componts only work on diff platforms 
;  workflow(eng)interop could be cool as well
;(al 'par-eval) ;uses mpi
;(al 'cl-gui) ;https://github.com/mathematical-systems/cl-gui
;io, consider a dir, have some sqlite, also use lq
;(al '4store) ;for io
;(al 'ontolisp)
;(lq) ;in my .sbclrc ;pnathan/cl-linq
;ML/stat.. libs   ;start w/mlcl(w/it's cl-kb)&abstraction of techniques&get mgl then others w/in it
; -having some issues w/some of these between osx&linux, might scale back ml while working on sparql
(when (member 'ml *t*) ;*tst*
 (ql 'mgl-example)  ;next as easiest2share via QL         ;http://cliki.net/MGL
                    ;http://quotenil.com/Introduction-to-MGL-(part-2).html http://quickdocs.org/mgl/
 (al 'ml) ;https://github.com/MBcode/LispUtils/tree/master/stat/ml-progs/ml Mooney UT-Austin
 (ql 'cl-store) ;for mlcl    ;ck-kb for protege(4now)&it's files readable by lisa.sf.net
 (al 'mlcl)  ;malecoli  ;has protege.stanford.edu link;also algernon-tab ;maybe2km.(2?).look@i/o /use
)
;Notes:   /another protege interaction w/:lsw2.googlecode.com is also possible
;Malecoli heavier on protege data-mng, light on algo(though maybe a nice framework)
;  still I'll probably do w/KM 1st, vs clos/protege,  also want meta-data on array/grids;focusOnAlgo:
;Start w/quicklisp loadable mgl,  &maybe a little ml if easy to deal w/a stnd-i/o for that as well.
;Also looking at ml-progs      will put in test runs, and trace, &get call graphs, docs/etc lacking
;
;look@ http://www.cs.ubc.ca/labs/beta/Projects/autoweka/papers/autoweka.pdf opt+ml
 
;arff input(@least), pmml description of models
;  mlcl has a arff parser if not cl version &lots of data, dwn/ai/disc/ml/app/pmml/pmml if useful
 
;(ql 'alexandria) ;for clml
;(al 'clml) ;https://github.com/mathematical-systems/clml ;statistics loads,rest needs full acl/look@
;  might port all/parts, but look@getting others going 1st; 
;http://www.cs.utexas.edu/users/qr/QR-software.html sfs,algernon,qsim,qpc

;https://github.com/masatoi/clrl https://github.com/masatoi/clml-svm https://github.com/masatoi/clml
 
;(ql 'cl-bayesnet) ;get into dne or get around

;(al 'sapa)
;(ql 'cl-mathstats) ;have cls on linux, miss xlispstat/vista viz
(when (member 'graph *t*) 
 (ql 'cl-graph) (al 'graph-utils) ;might need linux
 ;(al 'vivace-graph-v2) ;not loading anymore
 ;consider looking at/4 an agraph like interface
 (ql 'epigraph)
;(ql 'fgraph)
;(ql 'graph)
)
;(ql 'rcl) ;also (ql 'clpython)
;(al 'cl-octave) ;or just redo Ng's ML in other e.g.:
;(ql 'clpython)
;(ql 'zeromq) ;also a way2ipython, &then maybe octave/R /?
;(ql 'hunchentoot) ;should think of web interface,  ..svg.
; ;get back to some sparql/lod even old kmql/kif..new cl
; looked@ https://github.com/MBcode/sfmishras http://www.cliki.net/semantic%20web
; will get this &/or malecoli(w/protege-links)going, might link2 any old sparql client
;Maybe clpython calling: SPARQLWrapper as a start ;get this going
; https://github.com/MBcode/LispUtils/blob/master/tsparql.cl does this;generalize for any qry.
;(ql 'lisp-matrix) ;gsll, etc..  ;maxima (w/in sage w/py)
;(ql 'zeromq) ;or similar to ipython if possible
;(ql 'screamer) ;try on optimization assignments ;soon
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
;langutils cl-nlp /tagger
;cl-ace nlp+owl http://www.cs.rpi.edu/~tayloj/CL-ACE/
(defun in () (in-package :cl-kme))
(defun out () (in-package :user))
;(defun lu () (load "/home/bobak/lsp/util_mb"))
;(defun cl-kme:lu () (lu)) ;my init fnc to load mb_utils
;A breakdown of a few MachineLearning/Parallel&Distributed/SemanticWeb Libraries:
;ml/cl-bayesian@            pd/Eager-Future2@          sw/cl-mql@
;ml/cl-bayesnet@            pd/Starlisp-simulator@     sw/cl-ntriples-2012.12.16@
;ml/cl-decision-tree@       pd/Starsim-f20@            sw/cl-rdfxml_0.9@
;ml/cl-decisiontree@        pd/chanl@                  sw/cl-semantic@
;ml/cl-libsvm-0.0.7@        pd/cl-muproc@              sw/dbpedia-sparql@
;ml/cl-simple-neuralnet@    pd/cl-simd@                sw/dydra-cl@
;ml/cl-svm@                 pd/erlisp@                 sw/n3@
;ml/clml@                   pd/hevent@                 sw/ontolisp-0.9@
;ml/clml-svm@               pd/lfarm@                  sw/porky@
;ml/clrl@                   pd/lparallel@              sw/rdf-serialiser_0.3@
;ml/decisiontree@           pd/patron@                 sw/rdf-store@
;ml/icbr@                   pd/pcall@                  sw/rdf-utils@
;ml/malecoli@               pd/philip-jose@            sw/rdf-wilbur-redis@
;ml/mgl@                    pd/sb-concurrency@         sw/sbcl-4store@
;ml/mgl-0.0.6@              pd/starsim@                sw/scoli@
;ml/micmac@                 pd/stmx@                   sw/semantic-wikipedia@
;ml/ml-progs@               sw/SWCLOS@                 sw/sicl@
;ml/mulm@                   sw/SWCLOS2@                sw/twinql_0.3.1@
;ml/pulcinella@             sw/SWCLOSforILC2005@       sw/reasoner-3.2@
;pd/Common-Lisp-Actors@     sw/cl-4store@              sw/cl-ace@
;cl-graph graph-utils epigraph ;vivace-graph-v2           cl-nlp langutils /cl-registry  /tagger
;clpython  rcl rclg rclmath;looked@lsp/clj-hdf5/sci-db /but R-sci-db might be better  so rcl/etc
