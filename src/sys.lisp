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
; _tieing in to some of the sci/ml/nlp/etc workflow setups, might save time/look@protocols/etc
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
;xml: https://github.com/Shinmera/plump/
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
(ql 'cxml)
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
;(ql 'lfarm-test) ;which uses: (ql 'lparallel) *try soon*
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
;used in bne.cl

;(al 'sapa)
;(ql 'cl-mathstats) ;have cls on linux, miss xlispstat/vista viz
;-want more plotting, look at vecto/sparklines, as well as links to ext plotting
(when (member 'graph *t*) 
 (ql 'cl-graph) (al 'graph-utils) ;might need linux
 ;(al 'vivace-graph-v2) ;not loading anymore ;v3 did load/but not@moment
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
;(ql 'cl-graph) ;might want2try
;Cnstr:
;(ql 'screamer) ;try on optimization assignments ;soon
;(ql 'kr) ;km has most of ;miss garnet
;&tie in to protege cnstr description(for interchange)&http://www.w3.org/2005/rules/wg/wiki/CIF
;
;-also ModelBasedReasoning, look back at compositional-modeling-language, can be used4web-srves
;
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
; started this page: http://cliki.net/machine%20learning showing a few top ML libs
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
;ml/mgl-0.0.6@              pd/starsim@                sw/scoli 
;ml/micmac@                 pd/stmx@                   sw/semantic-wikipedia 
;ml/ml-progs@               sw/SWCLOS@                 sw/sicl 
;ml/mulm@                   sw/SWCLOS2@                sw/twinql_0.3.1 
;ml/pulcinella@             sw/SWCLOSforILC2005@       sw/reasoner-3.2 
;pd/Common-Lisp-Actors@     sw/cl-4store@              sw/cl-ace restricted-nl
;                           sw/de.setf.resource (incl cassandra)
;pd/cl-p2p liquid-sim  wolfcoin ..chirp ;get linda/tuple blackboard  w/lisa /gbbopen
;    http://www.cliki.net/csp Calispel chanl https://github.com/jessealama/cl-parallel.git
;  have been waiting for streaming sparql: https://github.com/aaltodsg/instans.git /get it going
;                              wilbur        http://ap5.com/doc/ap5-man.html
;pd: https://github.com/cpc26/netclos    sw: http://ap5.com/ http://ap5.com/ap5-20120509.zip
;pd: http://www.cliki.net/concurrency http://www.cliki.net/distributed
;pd: https://github.com/mikelevins/apis.git  a worker bee for building application hives
                            ;Apis is a library that supports shared-nothing concurrency 
;pd: PCall, or parallel call, is a Common Lisp library intended to simplify 'result-oriented'
 ;parallelism. It uses a thread pool to concurrently run small computations without spawning a new
 ;thread. This makes it possible to exploit multiple cores without much extra fuss
;pd:lfarm is a Common Lisp library for distributing work across machines
    ;using the [lparallel] (http://lparallel.org) API.
 ;lparallel is a library for parallel programming in Common Lisp, featuring
 ;10: simple model fine-grain ||, map/reduce/sort/rm,.., .. ..  tasks priority/category..
;cl-graph graph-utils epigraph ;vivace-graph-v2           cl-nlp langutils /cl-registry  /tagger
;clpython  rcl rclg rclmath;looked@lsp/clj-hdf5/sci-db /but R-sci-db might be better  so rcl/etc
;pd(parallel/distributed)stuff might be able to be done via the R/Py pkgs
;   r.cl py.cl (jl.cl, but ijulia, or just mq);ql: zeromq|zmq|pzmq
;pd: https://github.com/mikelevins/apis
;lots of math/stat,  &data-table cl-linq
;https://github.com/tpapp/cl-data-frame/
;pd:LispDaily (@LispDaily) tweeted at 10:59am - 23 Mar 15: ;
;Common #Lisp Parallel Programming - bit.ly/1HqzFio (https://twitter.com/LispDaily/status/580107236418142209?s=17

;ml/nlp @RainerJoswig  Dec 26 #lisp book for download: Common Lisp Modules http://link.springer.com/book/10.1007/978-1-4612-3186-8 …

;ml/pd RainerJoswig  #lisp #ai book for download Parallel Computation and Computers for Artificial Intelligence http://link.springer.com/book/10.1007/978-1-4613-1989-4 …

;pd: http://link.springer.com/book/10.1007/BFb0024148  Parallel Lisp: Languages and Systems

; @RainerJoswig  #lisp books: the mentioned downloadable Lisp books published by Springer, listed: http://lispm.de/springer-lisp-books …

;Paul Khuong @pkhuong  .@GaborMelis asked me about http://www.pvk.ca/Blog/Lisp/Pipes/introducing_pipes.html … and I had to rediscover the domain specific type system I wrote 4 years ago :|
 
;m/Maxima-CAS        m/gnoem             m/mma               m/rclmath
;m/cl-mathstats      m/gsll              m/mulm              m/simlab
;m/cl-octave_0.1     m/lassie            m/nlisp_0.8.2       m/soundlab
;m/cl-rsm-fuzzy      m/linear-algebra    m/numerical-lisp    m/units
;m/cl-sparsematrix   m/lisp-matrix       m/nurarihyon        m/vmath
;m/clem              m/lisphys           m/pythononlisp      m/wiz-util
;m/common-lisp-stat  m/maxima            m/r                 m/data-table *
;m/embeddable-maxima m/micmac            m/rcl
;m/fsvd              m/minpack           m/rclg              axiom
;Starlisp-simulator Starsim-f20 starsim /also lush.sf &xlsipstat/vista
; https://github.com/barak/lush lnx not osx ;vista osx not lnx
;* cl-data-frame data-objects cl-num-utils
; interact w/rcl cl-octave py etc bridges
;NLP
;nl/EPILOG                    nl/cl-earley-parser_0.9.2    nl/langutils
;nl/basic-english-grammar-1.0 nl/cl-inflector              nl/lassie
;nl/cl-ace                    nl/cl-nlp
;lots of other reasoning/aid beyond KM; have considered ML via workflow or even blackboar;;gbbopen
(ql 'gbbopen)  ;will stay w/km, but look@ &at ap5   ;also look@roslisp again
(ql 'hunchentoot) ;now (for: http://notional.no-ip.org) but
;(ql 'caveman) ;(or wuwei toot), to get a nicer front end on notional.no-ip.org
;like hunchentoot-1.2.21/www static pages
;look@ https://github.com/fukamachi/ningle http://8arrow.org/ningle/ dispatch on get/post/put/...
;https://github.com/3b/clws for websockets & https://github.com/e-user/hunchensocket.git
;https://twitter.com/MBstream iswc2013.semanticweb.org work worth looking@
;Document this more:
;
;-rw-r--r-- 1 bobak bobak 3.1K Oct 16 23:51 bne.cl bayes example
;-rw-r--r-- 1 bobak bobak 1.6K Oct 15 14:41 load-lib.lisp load km components (mini cyc)
;-rw-rw-r-- 1 bobak bobak  48K Oct 15 14:26 util-mb2.lisp part of full utils
;-rw-rw-r-- 1 bobak bobak 101K Oct 15 14:25 util_mb.lisp main utils cleaned up
;-rw-r--r-- 1 bobak bobak  889 Oct 15 14:25 fx
;-rw-rw-r-- 1 bobak bobak 3.2K Oct 14 14:17 py.cl  calling python code
;-rw-rw-r-- 1 bobak bobak  445 Oct 13 23:54 jl.cl  calling julia code
;-rw-rw-r-- 1 bobak bobak 1.6K Sep 19 22:51 io.lisp io/load ML dataset
;-rw-rw-r-- 1 bobak bobak  222 Sep 18 23:54 t.cl tmp file
;-rw-rw-r-- 1 bobak bobak 4.5K Sep 17 23:04 sparql.lisp one set of sparQL examples
;-rw-rw-r-- 1 bobak bobak  14K Sep 17 22:44 lists.lisp
;-rw-rw-r-- 1 bobak bobak 6.4K Sep  5 19:12 workspace.lisp another rdf example
;-rw-r--r-- 1 bobak bobak  31K Sep  4 21:10 llkm.lisp specific load-lib files
;recently played w/emacs+evil+slime, vagrant(core-os/docker) ;ilse.org mbr code, then sejits.org too
; slime works well in linux, still some problems in osx ;incl meta key ;will focus on lnx but fix4osx
;look@acl2 optimization routines, &ast-transforms ;also look back@lush lang mixing;&sbcl-llvm
;also slime/swank use beyond editing(eg. editing live event loop)&enanched dbg/stack/profile output
;lots of interesting eecs.berk research present/past:incl distrib-os sprite ;look@MLbase autoweka..
;Math, r/py/jl .cl also bridges to hdf5&scidb,doing matrix/array math@the data/base,look back@
; xldb/vldb talks, &old use of MUMPS, persistant Lisp in memory|store like that could be cool
; _ https://www.google.com/search?q=mumps-language+postgress w/rules/etc..
;turns out mumps is also the name of a Multifrontal Massively Parallel sparse direct Solver
;  there is a persistent lisp w/prolog: http://picolisp.com/5000/!wiki?Home which might be good4IoT2
;_I want both the persistance/working on in mem or not &matrix op/libs ;sparse4graph algorithms too
;Looked at workflow/mq/lang-interop incl some shmem/file(as mem) &maybe a little msg-passing
;_also seeing a few osx/lnx differences, might run via vagrant(etc)if need be ;also ccl/(c)lisp etc
;Still trying lang interop: java w/: http://sourceforge.net/projects/jacol/ &zmq to ipy... w:
;  _also tried abcl, but no c/ffi w/jni; I'd rather keep the lang interop via web/mq msgs _
;#https://github.com/fperez/zmq-pykernel Simple interactive Python kernel/frontend with ZeroMQ
;#This is the code that served as the original prototype for today's IPython client/server model.
;#86     278    2783 completer.py
;#194     551    6296 frontend.py this file, load from py.cl/?  to call w/lisp code
;#270     733    8717 kernel.py could still run on other side/&later iPy proper/?
;#119     333    3150 session.py 
;  _after this look@: https://github.com/JuliaLang/IJulia.jl &try2do4lsp
;#mb: I want to have a lisp client for (something)Ipython(like) ;I'll add the files if it works
; maybe like: https://github.com/tkf/emacs-ipython-notebook
;Trying:docs.docker.io/en/latest/installation/vagrant/ github.com/finitud/vagrant-common-lisp.git b4
;Think about how2mv parts of http://notional.no-ip.org fwd;still following confs,incl amia../py inter
;i want: http://www.talyarkoni.org/blog/2013/11/18/the-homogenization-of-scientific-computing-or-why-python-is-steadily-eating-other-languages-lunch/ but4lisp
;maybe http://stackoverflow.com/questions/2353353/how-to-process-input-and-output-streams-in-steel-bank-common-lisp
;new https://github.com/ros/roslisp.git &pip install:
;sudo pip install -U wstool rosdep rosinstall rosinstall_generator rospkg catkin-pkg Distribute
;More clj soon/few things I want2learn from/incl: http://clojurefun.wordpress.com/2013/12/07/enter-the-matrix 
;simple Service-wise pipe or ~like: https://github.com/joewalnes/websocketd ..
;tried2get de.setf going wilbur does, but not thrift/cassandra yet
; still think of pg (scidb) &hdf which now had a lighter more db like connection: Supporting a Light-Weight Data Management Layer over #HDF5: HDF5_SQL #tweet: Supporting a Light-We... http://bit.ly/1dmwqK8 
; hdf-table is cl-ana works now; see: https://github.com/ghollisjr/cl-ana data-analysis
;http://architects.dzone.com/articles/openstack-meets-lisp-cl & http://bit.ly/TP8gfz has more..
;Look@lisp for different chips/mem-size/etc. eg. clozure, ecl  ;also on android other than clj
;Look@even more background IoT work,comm&semantics, try kmp exmpl w/what I have,@same time
