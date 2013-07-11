(cl:in-package :cl-kme) 
;tsp.cl
(defun remove-nils (l) (remove-if #'null l)) 
(defun nth+ (ns ls)
  "nth from a list vs a single int"
  (remove-nils ;assume nils only at end
   (mapcar #'(lambda (n) (nth n ls)) ns)))
;
(defun nop (a) a)
;
;pass in keys, so can send: :test #'string-equal, &generlize beyond str2seq
(defun split-str2by (str by) ;can generalize, think there is something already
  "str by char get cons"
  (when (position by str)
    (let ((p (position by str)))
      (cons (subseq str 0 p) 
            (subseq str (+ p 1)))))) 
(defun last-str2by (str by) 
  "str from char on"
  (let ((p (position by str)))
    (when p (subseq str p ))))
(defun first-str2by-end (str by) 
  "str till char"
  (let ((p (positions by str)))
    (when p (subseq str 0 (1+ (last_lv p))))))
(defun between-str2by (str by by2) 
  "between first by and last by2"
  (first-str2by-end (last-str2by str by) by2))
(defun last-str2by-end (str by) 
  (let ((p (positions by str)))
    (when p (subseq str (last_lv p)))))
;or for now   ;oh could mv let up
#+ignore
(defun split-strs2at (strs by) ;mv let up
  (when (position by strs :test #'string-equal)
    (let ((p (position by strs :test #'string-equal)))
      (cons (apply #'str-cat (subseq strs 0 p)) 
            (apply #'str-cat (subseq strs (+ p 1))))))) 
(defun split-strs2at (strs by) 
  (let ((p (position by strs :test #'string-equal)))
    (when p (cons (subseq strs 0 p) (subseq strs (+ p 1))))))
;(defun split-at (seq by) 
;  (let ((p (position by seq :test #'equal)))
;    (when p (list (subseq seq 0 p) (subseq seq (+ p 1))))))
#+ignore-w-km
(defun split-at (seq by) 
  (let ((p (position by seq :test #'equal)))
    (when p (values (list (subseq seq 0 p) (subseq seq (+ p 1))) p))))
(defun split-at_p (p seq) 
  (when (< 0 p (len seq))
    (list (subseq seq 0 p) (subseq seq (+ p 1)))))
(defun split-nth (p seq) 
  (when (< 0 p (len seq))
    (list (subseq seq 0 p) (nth p seq) (subseq seq (+ p 1)))))
;from lx2.cl
(defun cdr- (cns)     
  (if (full cns) (cdr cns) ""))
(defun split-second (line &optional (splt #\:))     
   (cdr- (split-str2by line splt)))
;(split-str2by "C0030705:Patients" #\:) ;("C0030705" . "Patients") 
;yes, utl-.lsp's csv-parse-string
;started as oba parsing routines, but breaking out utils
;==> ab.cl <== ;Start using s-query so the xml can change
;     (:|obs.common.beans.AnnotationBean| (:|score| "122") 
;   (:|concept| (:|localConceptID| "CSP/C0006826") (:|preferredName| "cancer")
;    (:|synonyms| (:|string| "neoplasm/cancer")) (:|isTopLevel| "false")
;    (:|localOntologyID| "CSP")
;    (:|localSemanticTypeIDs| (:|string| "T191") (:|string| "T000")))
;   ((:|context| :|class| "obs.common.beans.MappingContextBean")
;    (:|contextName| "MAPPING") (:|isDirect| "false")
;    (:|mappedConceptID| "CST/C0006826") (:|mappingType| "inter-cui")))
;    -write some spath like code to find elts by tag, basically an assoc/but not dotted
;    I really do NOT like list acessors
;    ==I'd really like auto-mapping to CLOS obj/ins, but it is so embedded, I'll still look.
(defun secondt (tv pr)
  (when (and (listp pr) (eq (first pr) tv)) (second pr)))
(defun second-t (tv pr &optional (dflt nil))
  (if (and (listp pr) (eq (first pr) tv)) (second pr)
    dflt))
(defun rest-t (tv pr &optional (dflt nil))
  (if (and (listp pr) (eq (first pr) tv)) (rest pr)
    dflt))
;=====utl.lsp
(defun fulll (l)
  (and (listp l) (> (length l) 0)))
(defun first-lv (lv)
  (if (fulll lv) (first lv) lv))
(defun rest-lv (lv)
  (if (fulll lv) (rest lv) lv))
(defun second-lv (lv) (if (fulll lv) (second lv) lv))
(defun third-lv (lv) (if (fulll lv) (third lv) lv))
(defun fourth-lv (lv) (if (fulll lv) (fourth lv) lv)) 
(defun nth-lv (n lv)
  (if (fulll lv) (if (>= n (len lv)) (progn (format t "nth-lv:~a ~a" n lv) (last-lv lv))
		    (nth n lv)) 
      lv))
(defun last-lv (lv)
  (if (fulll lv) (last lv) lv))
(defun last_lv (lv) ;so not a list
  (first-lv (last-lv lv)))
(defun car_lv (lv) (when (consp lv) (car lv))) 
(defun car-lv (lv) (if (consp lv) (car lv) lv))
(defun car_eq (l v) (when (consp l) (when (eq (car l) v) l))) 
(defun cdr-lv (lv) (if (consp lv) (cdr lv) lv))
;
;(defun assoc-v (k a)  (let ((v (assoc k a))) (when (consp v) (cdr v))))
;(defun assoc-v (k a)  (let ((v (assoc k a :test #'equal))) (when (consp v) (cdr v))))
(defun assoc-v (k a)  (let ((v (assoc k a :test #'equal))) (if (consp v) (cdr v) v))) ;or assoc_v
;mk more gen vers of:
(defun mapcar- (f l) (when (fulll l) (mapcar f l)))
(defun mapcar_ (f l) (if (fulll l) (mapcar f l)
		       (funcall f l)))
(defun mapcar_2 (f l l2) (if (and (fulll l) (fulll l2)) (mapcar f l l2)
		       (funcall f l l2)))
;
(defun list+ (ml)
    (if (listp ml) ml (list ml)))
;
(defun flat1onlys (l)
  "get rid of all (((a)) till just (a)"
    (if (and (listp l) (eq (len l) 1) (listp (first-lv l))) (flat1onlys (first-lv l))
          l))
(defun first_lv (lv)
  (if (fulll lv) (first (flat1onlys lv)) lv))
;
(defun nn (n) (if (numberp n) n 0))
(defun nn> (&rest args) (apply #'> (mapcar #'nn args)))
(defun first-nn (lv) (nn (first-lv lv)))
(defun full (a)
  "clips leftover not needed in lsp"
  (if (stringp a) (> (length a) 0)
          (not (null a))))
(defun nul (a)
  (not (full a)))
;=====
(defun str-trim (s)
  (string-trim '(#\Space #\Tab #\Newline) s))
(defun intern-trim (s)  ;consider:  (intern (string-upcase ))
  (intern (str-trim s)))
(defun str_trim (s)
  (if (stringp s) (str-trim s) s))

(defun safe-trim (s)
      (string-trim '( #\( #\) #\tab #\newline #\space #\; #\\) s)) 
 
;;; with apologies to christophe rhodes ...
(defun split (string &optional max (ws '(#\Space #\Tab)))
  (flet ((is-ws (char) (find char ws)))
    (nreverse
     (let ((list nil) (start 0) (words 0) end)
       (loop
        (when (and max (>= words (1- max)))
          (return (cons (subseq string start) list)))
        (setf end (position-if #'is-ws string :start start))
        (push (subseq string start end) list)
        (incf words)
        (unless end (return list))
        (setf start (1+ end)))))))
 
(defun explode- (string &optional (delimiter #\Space))
  (let ((pos (position delimiter string)))
    (if (null pos)
        (list string)
        (cons (subseq string 0 pos)
              (explode- (subseq string (1+ pos))
                       delimiter)))))
(defun explode-2 (string &optional (delimiter #\Space) (offset nil))
  (let ((pos (position delimiter string)))
    (if (or (null pos) (eq pos 0)) (list string)
	(let ((npos (if (integerp offset) (+ pos offset) pos)))
	  (cons (subseq string 0 npos)
		(explode-2 (subseq string (1+ npos))
			  delimiter offset))))))
(defun str-cat2 (a b)
    (format nil "~a~a" a b))
(defun str-cat (&rest args)
    (reduce #'str-cat2 args))
;-langband:
(defun strcat (&rest args)
    (apply #'concatenate 'string args))

;when you need spaces between
(defun str-cat_2 (a b)
      (format nil "~a ~a" a b))
(defun str-cat+ (&rest args)
      (reduce #'str-cat_2 args))
;(defun implode-l (l)
;  (apply #'strcat (mapcar #'to-str l)))
(defun implode-l (l &optional (insert-spaces t))
  (let* ((f (if insert-spaces #'to-str+ #'to-str))
	 (s (apply #'strcat (mapcar f l))))
    (if insert-spaces (str-trim s) s)
  ))
(defun implode_l (l &optional (insert-spaces t))
  (string-downcase (implode-l l insert-spaces)))

(defun sym-cat (&rest args)
  ;(intern (str-cat @args))
   (intern (reduce #'str-cat2 args)))

(defun break2lines (s) 
  (explode- s #\Newline))
(defun break-by-bar (s) 
  (explode- s #\|))
;defun split-by (d s) (explode- s :delimeter d)
(defun split-by (d s) 
  (explode- s d))

(defun split-by-slash (s) 
  (explode- s #\/))
(defun split-by_ (s) 
  (explode- s #\_))

(defun rm-commas (s)
  (remove #\, s))
(defun trim-commas (s)
  (string-trim '(#\, #\Space #\Tab #\Newline ;#\no-break_space ;#\NO-BREAK_SPACE
                 ) s))
#+ignore
(defun rm-space (s)
  (remove #\NO-BREAK_SPACE (remove #\space s)))
(defun rm-space (s) (remove #\space s))

(defun rm-ws-parens (s)
  ;(when (full s) (remove-if #'(lambda (x) (member x "( )")) s))
  (when (stringp 
	  (if (listp s) (first s) s)) (string-trim '(#\Space #\Tab #\Newline #\( #\)) s)))
;had list, but can't trim everything, or can't break it
;  -there are times if 1char long you want to keep it, even make it a char-

(defun rm-star (s) (remove #\* s)) 
(defun rm-parens (s) (remove #\( (remove #\) s))) 
(defun no* (str) (csv-trim2 '( #\*) str)) ;utl
(defun noparens (str) (csv-trim2 '( #\( #\)) str)) ;utl 

;either get something 1before the split-by, or just regular explode& filter/remove-if-not prefix ed (
;  then make sure paren-strings are combined/collected into one list (no sublists) of strs
;so need prefix-p  ;use string= ;fix
(defun prefix-p (pre s) ;prefixp is better below
  (and (stringp s) ;(sequence-p s) 
       (eq 0 (position pre s))))
(defun paren-str-p (s)
  (prefix-p #\( s))
;problem is the explode doesn't keep multi word paren-strs together
;could look for postfix-p too, &terms between
;Basically for every input string only want str between the parens, or paren-on
(defun paren_on (s) 
  "only substrs w/parens"
  (remove-if-not #'paren-str-p (explode- s) ;s
  ))  ;(paren_on "a (b) (c)") ;("(b)" "(c)") 
;  probably easier to just go back one
;  or just add on where needed
(defun set-prefix (pre s)
  "prefix if a string"
  (if (stringp s) (str-cat pre s)
    s))
(defun preparen (s) 
  "balance out paren-str"
  (str_trim
   (set-prefix #\( s)
  ))

(defun paren-on (s)
  "ret from paren on in the str"
    (let ((l (split-by #\( s)))
          ;when (listp l) (preparen (rest l)) ;s
          (when (listp l) (preparen (second l)) 
          ;(when (listp l) (rm-ws-parens (rest l)) 
	          )))
;not reall a rm-
(defun rm_comma (s)
      (substitute #\Space #\, s))
(defun rm-comma (s)
      (substitute #\_ #\, s))
(defun rm-colon (s)
      (substitute #\_ #\: s))
(defun rm-dash (s)
      (substitute #\Space #\- s))
(defun rm-bslash (s)
      (substitute #\Space #\/ s))

(defun underscore (s)
  (substitute #\_ #\Space s))
;(defun underscore_ (s) (string-downcase (underscore s)))
(defun underscore_ (s-) 
  (let ((s (if (symbolp s-) (symbol-name s-) 
	     s-)))
    (string-downcase (underscore s))))
(defun under_ (s) (string-downcase (underscore s)))
(defun str-cat_ (a) (under_ (str-cat a))) ;try
(defun str-cat_l (l) (str-cat_ (implode-l l)))
(defun has-space-p (s)
  (find #\Space s))

(defun rm-pd (s) "rm post -dashed like -pos" (butlast (explode- (rm-dash s))))
(defun under-pd (s) "under_ of all but -pos" (str-cat_l (rm-pd s))) 
(defun under-pd-l (l) (str-cat_l (mapcar- #'rm-pd l))) ;could overload above

(defun rm-underscore (s)
  (substitute #\Space #\_ s))

(defun hyphenate (s)
  (substitute #\- #\Space s))

(defun under2hyphen (s)
  (substitute #\- #\_ s))
(defun under2sp (s)
  (substitute #\Space #\_ s))
(defun hyphen2under (s)
  (substitute #\_ #\- s))

(defun replace-commas (s)
  (substitute #\; #\, s))

(defun slash2hyphen (s)
  (substitute #\- #\\ s))

(defun all2hyphen (s cl)
  "all in changeList2hypens"
 (if (not (fulll cl)) s
  (all2hyphen
     (substitute #\- (first cl) s)
 	(rest cl))))

(defun plusify-str (s)
  (substitute #\+ #\Space s))

(defun no-retlines (s)
  (substitute #\Space #\Newline s))

;(defun len (l) (when (listp l) (length l)))
;(defun len (l) (when (or (listp l) (stringp l)) (length l)))
;(defun len (l) (if (or (listp l) (stringp l)) (length l)
;		 (when (arrayp l) (first (array-dimensions l)))))
(defun len (l) (typecase l 
                 (list  (length l))
                 (string  (length l))
                 (symbol  (length (symbol-name l)))
                 (array  (first (array-dimensions l)))))
(defun nnlen (l) 
  "0 vs nil, if can't get length"
  (nn (len l)))
(defun len= (l n) (when (listp l) (eq (length l) n)))
(defun tree-size (tree) ;http://tehran.lain.pl/stuff/diff-sexp.lisp
  "Computes the number of atoms contained in TREE."
  (if (atom tree) 
      1 
      (reduce #'+ tree :key #'tree-size))) 
;------
(defun lexemep (s) (or (stringp s) (symbolp s)))
(defun lens1 (s) (if (lexemep s) 1 (len s)))
;------
(defun lens (l)
  (mapcar #'len l))
;------
(defun substr (txt from to)
  "subseq for str w/test"
  (when  (>= (length txt) to from 0) (subseq txt from to)))

(defun substr- (txt from to)
  ;(substr txt (1- from) (1- to)) ;should be this
  (when (full txt)
    (substr txt (1- from) to)
  ))

#+ignore
(defun tree-depth (tree) 
  (cond ((atom tree) 0)
	(t (1+ (reduce #'max (mapcar #'tree-depth tree)))))) 
;==was tree-depth but already in km
(defun tree_depth (tree)
   (cond ((atom tree) 0)
         (t (1+ (reduce #'max (mapcar #'tree_depth tree))))))

(defun list+2depth (a d)
  (if (<= d 0) a
    (list+2depth (list a) (1- d))))
(defun list2depth (a wd) ;only adds to wd, could flat-1/flat1 the other way, &/or start w/flat1onlys
  (let ((pd (tree_depth a)))
    (list+2depth a (- wd pd))))
(defun list++ (ml &optional (assure-depth 1)) ;starts out just like list+ but can modify
   ;(if (listp ml) ml (list ml))
   (let ((td (tree_depth ml)))
	 (if (< td assure-depth) (list+2depth ml (- assure-depth td))
	   ml)))
(defun list+2 (ml) (list++ ml 2))
 
(defun tree-stats (tree)
 ;(format t "~&width:~a depth:~a size:~a" (len tree) (tree-depth tree) (tree-size tree))
  ;let ((wid (len tree)) (dep (tree-depth tree)) (siz (tree-size tree))) ;works either way/?
  (let ((wid (len tree)) (dep (tree_depth tree)) (siz (tree-size tree)))
   (format t "~&width:~a depth:~a size:~a" wid dep siz)
   (if (> siz (* wid dep)) (format t " > ~a "  (* wid dep)))
  ))
;=====
(defun str_cat (&rest args)  
  (apply #'concatenate 'simple-string args))
;rest already above
;(defun str-cat2 (a b)  
;  (format nil "~a~a" a b))
;(defun str-cat (&rest args)  
;  (reduce #'str-cat2 args))
;=====
;-in utl.lsp now
;CL-USER(7): (read-delimited-list #\, (make-string-input-stream "1,2,3"))
;(1)  ;see o13a for more
;--
;(with-input-from-string (s "6") (read s))  -> 6
;--
;(parse-integer "word" :junk-allowed t)
;--
(defun alpha-start (str)
  "does it start w/an alpha"
  (alpha-char-p (char str 0))
  )
(defun has-alpha-p (str)
  (alpha-start str);for now
  )
;--
;it might be better to alter explode str, to have numbers go to numbers; as easier to look@separated?
;find-if #'alpha-char-p  ;but don't know if it fits in there?
;--
(defun num-str (numstr)
  (let ((n (parse-integer numstr :junk-allowed t)))
    (if n n numstr))
  )
(defun numstr (numstr)
  "get num from a str"
  (if (equal numstr "") 0 
    (if (or (numberp numstr) (alpha-start numstr) ) numstr
      (read-from-string (remove #\: numstr)) ;(num-str numstr) 
      )
    ))
;--
(defun has-date-p (s) (len-gt (positions #\: s) 1))
;(defun numstr- (s) ;put in mb3 
;  (if (has-date-p s) (prs-univ-time- s)  (numstr s)))
;--
;I'd like to be able to rm a : at the end of what is read..
;--
  ;whish I could READ-FROM-STRING w/a format ;look@ make-string-input-stream
;;;just USE:   READ-DELIMITED-LIST ...!!!but needs a stream, still
;-garnet
;;; Read and return the numbers at the end of a line on stream bitstream
;;;
(defun get-nums (bitstream) ;garnet/opal/mac.lisp
       (do ((ch (peek-char t bitstream) (peek-char t bitstream)))
	          ((digit-char-p ch))
		            (read-char bitstream))
            (parse-integer (read-line bitstream)))
;-langband: ;already above
;(defun strcat (&rest args)
;    (apply #'concatenate 'string args))
;----- csv.lisp simplification
(defun csv-trim (whitespace string)
    "Trim the string argument from the whitespace."
      (let ((clean (string-trim whitespace string)))
	    (if (zerop (length clean)) nil clean))
      )
(defun csv-trim2 (whitespace string)
 (let ((c2 (csv-trim whitespace string)))
   (if c2 c2 " ")))
(defvar *punct* "[]();.")
(defvar *punct2* "[]();., ")
(defun punct-p (str)
 (position (aref str 0) *punct*))
(defun punctp (str)
  (and (eq (length str) 1) (not (alphanumericp (aref str 0)))))
(defvar +whitespace+ " ")
;(defvar +whitespace+ " \0")  ;mmtx tagger puts out \0's ;but it's dangerous

(defun csv-parse-string (string &key (separator #\,) (whitespace +whitespace+))
  "Parse a string, returning a vector of strings."
  (loop :with num = (count separator string :test #'char=)
    :with res = (make-array (1+ num))
    :for ii :from 0 :to num
    :for beg = 0 :then (1+ end) 
    :for end = (or (position separator string :test #'char= :start beg)
                   (length string))
    :do (setf (aref res ii)
              (when (> end beg) ; otherwise NIL = missing
                (csv-trim whitespace (subseq string beg end))))
    :finally (return res)))  
;---(read-from-string " 1 3 5" t nil :start 2)
;==new==
;defun csv-parse-str (string &key (separator #\t) (whitespace +whitespace+))
(defun csv-parse-str (string &key (separator #\Tab) (whitespace +whitespace+))
  "Parse a string, returning a vector of strings."
  (loop :with num = (count separator string :test #'char=)
    :with res = (make-array (1+ num))
    :for ii :from 0 :to num
    :for beg = 0 :then (1+ end) 
    :for end = (or (position separator string :test #'char= :start beg)
                   (length string))
    :do (setf (aref res ii)
              (when (> end beg) ; otherwise NIL = missing
                (csv-trim whitespace (subseq string beg end))))
    :finally (return res)))  
;==
;my try
(defun read-from-csv-str (str &key (start 0) (separator #\,))
    (if (>= start (length str)) nil
      (let ((pn (position separator str)))
        (if (not pn) nil
          (cons (read-from-string str t nil :start start)
	        (read-from-csv-str str :start (+ start pn))))))
    )
;--from clhp: 
(defmacro if-bind ((&rest bindings) test if else)
    "An IF wrapped in a LET"
      `(let (,@bindings) (if ,test ,if ,else))
      )
(defmacro explode-string (string)
    "Converts a string to a list of chars, this is an aux function used
  for string processing.
  ex: (EXPLODE-STRING (\"Hello\") --> (#\H #\e #\l #\l #\o)"
		        `(concatenate 'list ,string)
			)
(defun implode-string (char-list)
    "Converts EXPLODEd CHAR-LIST into string, used as an aux function
  for string processing.
  ex: (IMPLODE-STRING '(#\H #\e #\l #\l #\o)) --> \"Hello\"
      (IMPLODE-STRING (EXPLODE-STRING \"Hello\")) --> \"Hello\""
        (coerce char-list 'string)   ;maybe allow other types?
	)
(defun implode- (cl)
  "kludge"
  (if (listp cl) (implode-string cl) 
    (numstr cl)  ;(eval cl) ;need to get it to turn "1"->1
    )
  )
;; ex:  ;this is the explode that I'm used to, but explode-str w/opt #\Space does the same
;; (mapcar #'implode-string
;;      (split-char-list #\Space
;;                       (explode-string "In God We Trust" ))) -->
;; ("In" "God" "We" "Trust")  
(defun split-char-list (char char-list)
  "Splits a char-list (EXPLODEd string) on CHAR."
  (labels
      ((split
        (char-list split-list)
        (if-bind ((position (position char char-list)))
           (null position)
              (remove nil (nreverse (cons char-list split-list)))
            (split (nthcdr (1+ position) char-list)
                   (cons (butlast char-list (- (length char-list) position))
                         split-list)))))
    (split char-list nil))
  ) 
(defun explode-str (str &key (sep #\,))
  "explode-str-by"
   (mapcar #'implode-  ;#'implode-string
        (split-char-list sep (explode-string str)))
   )
; (explode-str "1,2,3") -->("1" "2" "3")
 ;i'd like to change implode- to eval
(defun explode-bar (str) (explode-str str :sep #\|))
;--from clhttp headers:
;define-macro char-position (char string  &optional (start 0) end from-end)
(defmacro char-position (char string  &optional (start 0) end from-end)
  "Returns the position of CHAR in string from START upto END.
when FROM-END is non-null, the string is scanned backward."
  (case from-end
    ((t)
     `(let ((ch ,char))
        (with-fast-array-references ((string ,string string))
          (loop for idx fixnum downfrom (1- (the fixnum ,(or end '(length string)))) to (the fixnum ,start)
                when (eql ch (aref string idx))
                  return idx
                finally (return nil)))))
    ((nil)
     `(let ((ch ,char))
        (with-fast-array-references ((string ,string string))
          (loop for idx fixnum upfrom (the fixnum ,start) below (the fixnum ,(or end '(length string)))
                when (eql ch (aref string idx))
                  return idx
                finally (return nil)))))
    (t (if end
           `(char-position-2-case ,char ,string ,start ,end ,from-end)
           `(let ((string ,string))
              (char-position-2-case ,char ,string ,start (length string) ,from-end)))))
  ) 
(defconstant +white-space_chars+ '(#\Space #\Tab)
	     )
(defmacro with-fast-array-references (bindings &body body)
  "Declares the arrays in bindings (var value &optional type)
as type and sets speed to 3 with safety 0 within its scope."
  (loop for (var val type) in bindings
        collect `(,var ,val) into n-bindings
        when type
          collect `(type ,type ,var) into type-dcls
        finally (return `(let ,n-bindings
                          (declare (optimize (speed 3) (safety 0)) . ,type-dcls)
                          ,@body)))
  ) 
(declaim (inline white-space-charp) ;was white-space-char-p
	 ) 
;define white-space-char-p (char)
(defun white-space-charp (char)
    (member char +white-space_chars+)
    )
;define fast-position-if-not (predicate string start end from-end)
(defun fast-position-if-not (predicate string start end from-end)
  (declare (fixnum start end))
  (with-fast-array-references ((string string string))
    (if from-end
        (loop for idx fixnum downfrom (1- end) to start
              unless (funcall predicate (aref string idx))
                return idx
              finally (return nil))
        (loop for idx fixnum upfrom start below end
              unless (funcall predicate (aref string idx))
                return idx
              finally (return nil))))
  ) 
;define-macro position-if-not* (predicate string &key (start 0) (end nil end-supplied-p) from-end)
(defmacro position-if-not* (predicate string &key (start 0) (end nil end-supplied-p) from-end)
  (if end-supplied-p
      `(fast-position-if-not ,predicate ,string ,start ,end ,from-end)
      `(let ((string ,string))
         (fast-position-if-not ,predicate string ,start (length string) ,from-end)))
  ) 
(defun parse-comma-separated-header (string &optional (start 0) (end (length string)) (header-value-parser #'subseq))
  "Applies header-value-parser to each comma separated header-value in STRING.
If HEADER-VALUE-PARSER return multiple values, they are concatenated together into the returned list."
  (flet ((first-non-blank (start end)
           (position-if-not* #'white-space-charp string :start start :end end)))
    (declare (inline first-non-blank))
    (loop for s = (first-non-blank start end) then (first-non-blank (1+ idx) end)
          while s
          for idx fixnum = (or (char-position #\, string s end) end)
          for last = (position-if-not* #'white-space-charp string :start s :end idx :from-end t)
          when last
            nconc (multiple-value-list (funcall header-value-parser string s (1+ (the fixnum last))))
          while (< idx end)))
  ) 
;(parse-comma-separated-header "1,2,3") --> ("1" "2" "3") 
;==================================================== 
;(defcustom *csv-separator* character #\,
;  "The separator in the CSV file, normally the comma.")
(defvar *csv-separator*  #\,)

(defun csv-print-vector (vec &optional (out *standard-output*))
  "Print a vector as a comma-separated line."
  (declare (type vector vec) (stream out))
  (loop :with len = (length vec) :for val :across vec :and ii :from 1
        :when val :do (write val :stream out :escape nil)
        :unless (= ii len) :do (write-char *csv-separator* out))
  (terpri out))

;(defcustom *csv-whitespace* (or null string) +whitespace+
;  "The string of characters to trim from the values.")
;(defcustom *csv-progress* integer 1000
;  "*How often the progress report should be made")
(defvar *csv-whitespace* +whitespace+)
(defvar *csv-progress*  1000)
#+IGNORE ;already above
(defun csv-parse-string (string &key
                         ((:separator *csv-separator*) *csv-separator*)
                         ((:whitespace *csv-whitespace*) *csv-whitespace*))
  "Parse a string, returning a vector of strings."
  (loop :with num = (count *csv-separator* string :test #'char=)
    :with res = (make-array (1+ num))
    :for ii :from 0 :to num
    :for beg = 0 :then (1+ end)
    :for end = (or (position *csv-separator* string :test #'char= :start beg)
                   (length string))
    :do (setf (aref res ii)
              (when (> end beg) ; otherwise NIL = missing
                (csv-trim *csv-whitespace* (subseq string beg end))))
    :finally (return res)))

;I should take out csv stuff, esp if :cl-csv is loaded

;;;###autoload
;(defun csv-read-file (inf)
; "Read comma-separated values into a list of vectors."
;====================================================
(defun parse-csv- (str)
 ;(mapcar #'numstr (parse-comma-separated-header str))
 ;(mapcar #'numstr (csv-parse-str str))
 (csv-parse-str str)
 )
;maybe give an alt arg of how many/which to numstr?
; or better just fix numstr to avoid anything starting w/a alphabetic-char
;====================================================fix/skip
;;;; -*-Mode:LISP; Package:LISP; Base:10; Syntax:ISLISP -*-
;;;; Date:	2003/03/19
;;;; Title:	csv.lsp
;;;; Author:	C. Jullien

;;;
;;; Read CSV (Comma Separated Value) File Format
;;;

;(defglobal *separator* #\;)
;(defglobal *separator* #\t)
(defvar *separator* #\Tab)

;defun read-csv (file &optional (cfnc #'convert-to-list))
;#-cl-csv
#+mycsv
(defun read-csv (file &optional (cfnc #'prs-csv-nums))
   ;; read a CVS into a list of lines.
   ;with-open-input-file (si file)
   (with-open-file (si file) 
	 (let ((tree nil))
	      (do ((line (read-line si () 'eof) (read-line si () 'eof)))
		   ((eq line 'eof))
		   (push (funcall cfnc line) tree)) ;broken?
	      (nreverse tree))))

;(defun format-fresh-line (strm) ;when couldn't find
;  (format strm "~&"))
;; ~&, CLTL p.397, CLtL2 p. 596
(defun format-fresh-line (stream ;colon-modifier atsign-modifier
                          &optional (count 1))
  (declare (ignore colon-modifier atsign-modifier))
  (if (null count) (setq count 1))
  (when (plusp count)
    (fresh-line stream)
    (dotimes (i (1- count)) (terpri stream))))

;#-cl-csv
#+mycsv
(defun write-csv (file tree)
   ;; write a CVS from a list of lines.
   ;with-open-output-file (so file)
   (with-open-file (so file)
	 (dolist (line tree)
		 (dolist (item line)
			 (format so "~a~c" (or item "") *separator*))
		 (format-fresh-line so))))

(defun subseq- (seq a b)
  (if (< a b) (subseq seq a b)
              (subseq seq b a)))
  ;check this!
;defun convert-to-list (line) ;still finding problem w/this
(defun convert-to-list (line &optional (sep *separator*))
   ;; convert  a  single  line with CSV into a list.  Empty items are
   ;; set to nil.
   (let ((len (length line))
	 (last- 0)
	 (res nil))
	(do ((i 0 (1+ i)))
	     ((= i len))
	     (when (char= (char line i) sep) ;*separator*
		   (if (= i last-)
		       (push nil res)
		       (push 
			   (subseq- line last- (- i last-))
			   res))
		   (setf last- (1+ i))))
	(nreverse res))) 
;====================================================
;asdf: (defun* split-string (string &key max (separator '(#\Space #\Tab)))
;
;"int/ffi/cl-objc/src/utils.lisp" 104 lines --33%--     35,8-15       72%
;defun split-string (string separator &key (test-fn #'char-equal))
;defun split-string (string &optional (separator " ") &key (test-fn #'char-equal)) ;soCanReplace other
(defun split_string (string &optional (separator " ") &key (test-fn #'char-equal)) ;soCanReplace other
  "Split STRING containing items separated by SEPARATOR into a list."
  (let ((ret)
        (part))
    (loop
       for el across string
       for test = (funcall test-fn el separator)
       do
       (cond
         ((not test) (setf part (if part
                                    (format nil "~a~c" part el)
                                    (format nil "~c" el))))
         (test (setf ret (append ret (list part))) (setf part nil))))
    (when part (setf ret (append ret (list part))))
    ret))
;
(defun search-str (a b) (search a b :test #'string-equal))
;
;should have save version &send fnc in
(defun len-gt (l n) (> (len l) n)) ;make sure safe to access
(defun len-lt (l n) (< (len l) n)) ;make sure safe to access
;
(defun len> (a b) (> (len a) (len b)))
(defun len< (a b) (< (len a) (len b)))
(defun sort-len-lol (lol) (sort lol #'len>))
;(defun max-len (&rest lol) (sort lol #'len>))
(defun max-len (&rest lol) (first-lv (sort-len-lol lol)))
;
(defun simple-replace-string (old new string) ;some replacements could be get it stuck/?
  "Replace OLD with NEW into STRING."
  (loop
     with changed = t
     while changed
     do (setf string
              (let ((match (search old string :test #'string-equal ;equal
				   )))
                (if match
                    (prog1
                        (concatenate 'string (subseq string 0 match) new (subseq string (+ match (length old))))
                      (setf changed t))
                    (prog1
                        string
                      (setf changed nil)))))
       finally (return string)))
;--- 
(defun simple-replace-strings (alst str)
  "alst(old . new) "
 (if (not (full alst)) str
  (let* ((aon1 (first alst))
	 (old (car aon1))
	 (new (cdr aon1))
	 (nstr (replace-substrings str old new)))
    (when *dbg-ut* (format t "~%~a" nstr))
    (simple-replace-strings (rest-lv alst) nstr))))
;(simple-replace-strings '((":" . ": ") ("\"{" . "{") ("}\"" . "}")) str)
;defun replace-substrings (string substring replacement) ;replace-string
    	 
;--- 
(defun rm-str (rs s)
  (simple-replace-string rs "" s)) 

(defun rm-strs (rsl s)
  ;reduce #'rm-str
  (if (and (full rsl) (> (len rsl) 1)) (rm-str (first rsl) (rm-strs (rest rsl) s))
    (rm-str (first rsl) s) ))
;--- 
(defun no-dbl-spaces (s)
  (simple-replace-string "  " " " s)) 
;--- 
;--- find- .. fnc also of possible use
;(defun simple-hyphenate-str (s str)
;     (simple-replace-string s (hyphenate s) str)) 
;     already worked though
(defun simple-hyphenate-str (s str &optional (dc t))
  "hyphen word w/in str, ret whole str"
  (let ((s- (if dc (string-downcase s) s)))
     (simple-replace-string s- (hyphenate s-) str))) 
;
(defun simple-hyphenated-str (s str &optional (dc t))
  "hyphen word w/in str, ret it& rest of str"
  (let* ((s- (if dc (string-downcase s) s))
	 (sh (hyphenate s-))
	 (nstr (simple-replace-string s- sh str))) 
   ;(cons sh (rm-str sh nstr))
    (list nstr sh (rm-str sh nstr))
    ))
(defun simple-hyphenated-strs (sl str)
  "take strings &hyphenate all of them in str, w/o glomming"
    (mapcar #'(lambda (s) (simple-hyphenated-str s str)) (sort sl #'len>))) ;finish, use new ret
(defun find-merge-hyphens (lwl str)
  "hyphenate all longestwords, w/removal so no glomming of hyphens"
  (let* ((shs (simple-hyphenated-strs (list+ lwl) str))
	 (allp (find "" shs :test #'equal :key #'cdr))
	;(hp (reduce #'union (mapcar #'hyphens-at shs)))
	 ) ;finish
    (if allp (progn (format t "~&hyphenated whole str:~a" allp) allp) ;check
      (let ((hp (reduce #'union (mapcar #'hyphens-at (mapcar #'first shs))))) ;still want2use cdr..?
	   (replace-chars-at str #\- hp)))
    ))
;could rm-dups after downcase but don't have to ;positions to find spaces&cmp w/- positions
; don't just remove, as it's ok if >1 hyphen comes from 1src, which is a reason to sort-len
;;len>, sort was good, but we said we'd try to anchor from the right, so sort by position/hit in str*
;; but it's position+len-of-match str, to see which is most right;I should try it by hand 1st:
;; ;; well if 2go all the way, it's the longer of the 2
;
;;w/simple-hyphenated-strs if crd=="" then done, could look@others b4 a reduce
(defun simple-hyphenate-strs (sl str)
  "take strings &hyphenate all of them in same str" ;used longest 1st, not helpful here?
    (mapcar #'(lambda (s) (simple-hyphenate-str s str)) (sort sl #'len>)))
;--;above ret >1, while below only 1
(defun find+merge-hyphens (lwl str)
  (let ((hp (reduce #'union (mapcar #'hyphens-at (simple-hyphenate-strs lwl str)))))
    (replace-chars-at str #\- hp)))
;(find+merge-hyphens '("Illicit drug use" "drug use" "Drug use" "illicit drug") "Illicit drug use")
;"Illicit-drug-use"
;--- 
(defun replace-w-hyphens (sl txt) 
  (let ((hsl (mapcar #'hyphenate sl)))
    (mapcar #'(lambda (o n) (simple-replace-string o n txt)) sl hsl)))
    ;shouldn't it be reduced though/?
;(trace replace-w-hyphens) 
;--- 
;defun hyphens (s)
(defun hyphens-at (s)
  (positions #\- s))
(defun spaces-at (s)
  (positions #\Space s))
;--- 
(defun digit-prefixp (str)
 (digit-char-p (aref str 0)))

(defun trim-whitesp (str)
 (csv-trim +whitespace+  str))

(defun trim-punct (str)
 (csv-trim *punct*  str))
(defun trim-punct2 (str)
 (csv-trim *punct2*  str))

;try to trim everything
(defun not-ALPHANUMERICP (c)
  (not (ALPHANUMERICP c)))
;use: string-downcase 

(defun alpha_char-p (c)
  (or (eq c #\_) (alpha-char-p c)))
(defun alph_char-only (s)
  (remove-if-not #'alpha_char-p s))

(defun digit_prefixp (str)
 ;(digit-char-p (aref (csv-trim +whitespace+  str) 0))
 (digit-char-p (aref (trim-whitesp str) 0))
 )
;(digit_prefixp "    123  ") ;1 

;==from mmtx parsing files originally
;(defgeneric positions (a b &key start sum test))
;--was otp.cl now tp.cl 
(defgeneric positions (a b &key start sum test))

(defmethod positions (c  b &key (start 0) (sum 0) (test #'equal))
  (let* ((p (position c b :start start :test test))
         (s (if p (subseq b (+ p 1)) nil))
         (np (if p (+ sum p) 0)))
    (if p (cons np (positions c s :sum (1+ np) :test test)) nil)))

(defmethod positions ((c string) b &key (start 0) (sum 0) (test #'prefixp))
  (let* ((p (position c b :start start :test test))
         (s (if p (subseq b (+ p 1)) ""))
         (np (if p (+ sum p) 0)))
    (if p (cons np (positions c s :sum (1+ np) :test test)) nil)))
 

(defmethod positions ((c character) b &key (start 0) (sum 0) (test #'equal))
  (let* ((p (position c b :start start :test test))
         (s (if p (subseq b (+ p 1)) ""))
         (np (if p (+ sum p) 0)))
    (if p (cons np (positions c s :sum (1+ np) :test test)) nil)))
 
(defmethod positions ((pl list) b &key (start 0) (sum 0) (test #'equal))
  (mapcar #'(lambda (x) (position x b :start start :test test)) pl))
 
(defun tst-posit () (positions #\- "Women with a positive urine beta HCG-pregnancy-test"))
 
;--
(defun positions- (a  b)
  (remove-nils (positions a b)))

(defun mapappend (fun &rest lists)
    "A non-destructive mapcan."
      (reduce #'append (apply #'mapcar fun lists)))
;-
(defun positionsl (pl l)
  "find each pl in l, &give all#s"
  (sort (mapappend #'(lambda (p) (positions- p l)) pl) #'<)) 

;better than prefix-p above
;#+sbcl ;or #-acl
#+sbcl ;already in acl
(defun prefixp (pre str)
 (and (stringp pre) (stringp str) (> (length str) (length pre)) ;(equal (subseq str 0 (length pre)) pre))
         (string= pre str :end2 (length pre))))
;-
(defun prefix (pre str &optional (trim t)) 
  "if not a prefix already, then add it"
 (let ((ret (if (prefixp pre str) str 
	      (str-cat pre str))))
   (if trim (str-trim ret)
     ret)))

;-
;tried as method, but messed up cui-p, so give as alt:
(defgeneric s-prefixp (pre str))
(defmethod s-prefixp (pre (s Symbol))
  (s-prefixp pre (symbol-name s)))
(defmethod s-prefixp (pre (str String))
; (and (> (length str) (length pre)) (equal (subseq str 0 (length pre)) pre))
 (and (stringp pre) ;(stringp str) 
      (> (length str) (length pre)) ;(equal (subseq str 0 (length pre)) pre))
         (string= pre str :end2 (length pre))
  ))
(defun sprefixp (pre s) ;will handle non-strs incl symbols  ;downcase all of these too?
  (prefixp (to_str pre) (to_str s))) ;just did this for prefixp though
(defun prefix_p (pre str)
  (or (equal pre str) (prefixp pre str)))
(defun suffixp (post str) ;postfixp
 (and (stringp post) (stringp str) (> (length str) (length post)) 
         (string= post str :start2 (- (length str) (length post)))
  ))
; (suffixp "Tagging" ">>>>> Tagging") ; T
 
 ;from sr-init.lisp
(defun list-lines (filename)
  "file2list of lines"
 (when (file-exists-p filename)
  (with-open-file (stream filename :direction :input)
    (loop for line = (read-line stream nil)
        while line
        collect line))))
(defun list_lines (filename)  ;see if can get unicode
  ;with-open-file (stream filename :direction :input :external-format :iso-8859-)
  (with-open-file (stream filename :direction :input :element-type '(unsigned-byte 8))
    (loop for line = (read-line stream nil)
        while line
        collect line)))
;-
(defun read-file-to-string (fn)
  (let ((l (list-lines fn)))
    (when (full l)  (reduce #'str-cat l))))
;-
(defun save-lines (l filename)
 (when (fulll l)
  (with-open-file (stream filename :direction :output)
    (mapcar #'(lambda (x) (write-line x stream)) l))))
 
(defun map-lines (filename linefnc)
  (with-open-file (stream filename :direction :input)
    (loop for line = (read-line stream nil)
        while line
        collect (funcall linefnc line))))

(defun map-lines2 (filename linefnc)
 (with-open-file (stream2 (str-cat filename ".out") :direction :output)
  (with-open-file (stream filename :direction :input)
    (loop for line = (read-line stream nil)
        while line
        collect (funcall linefnc line stream2)))))
 

;-------------------------------------
(defun eval-str (s) 
  (eval (read-from-string s))) 
(defun eval-str2 (s) ;1st in nlp.cl
    (eval-str (str-cat "'" s)))
;-------------------------------------in s.lisp, to mv2 mb2.lisp
(defun symbol-name-sort (symbol-list)
    (sort (copy-list symbol-list) #'string-lessp :key #'symbol-name))

(defun symbol_name (s) (string-downcase (symbol-name s)))

;;; from Pierre R. Mai
(defun replace-substrings (string substring replacement) ;replace-string
  (declare (optimize (speed 3))
           (type simple-string string substring replacement))
  (assert (> (length substring) 0) (substring)
    "Substring ~A must be of length ~D > 0" 
    substring (length substring))
  (with-output-to-string (stream)
    (loop with substring-length = (length substring)
        for index = 0 then (+ match-index substring-length)
        for match-index = (search substring string :start2 index)
        do   
          (write-string string stream :start index :end match-index)
          (when match-index
            (write-string replacement stream)) 
        while match-index)))
 
(defun subst-at (str ch at)
  (setf (aref str at) ch)
  str)

(defun replace-chars-at (str ch atl)
  "atlist mask of where to subst ch"
   (mapc #'(lambda (a) (subst-at str ch a)) atl)
   str)
 
;look at find*comparator ben/new/choice-params-ff3-new.lisp
;ben's files
(defun safer-read-from-string (s)
  (read-from-string (string-trim '( #\( #\) #\newline #\space #\; #\\) s)))
 
;(string s) ;does the same thing
(defun to-str (s)  ;could have symbolp then symbol-name, but this ok
  (if (stringp s) s
    (format nil "~a" s)))
(defun to_str (s)
  (string-downcase (to-str s)))

(defun to-str+ (s)  
  "to str with a space"
  (str-cat s " "))
 ;(if (stringp s) s
 ;  (format nil "~a " s))

(defun safer-string (s)
 ;(if s (safer-read-from-string (to-str s)) "")
 ;(if s (string-trim '( #\( #\) #\newline #\space #\; ) (to-str s)) " ") ;was "" still stripped so:
  (if s (csv-trim2 '( #\( #\) #\newline #\space #\; #\\) (to-str s)) " ")
  )
;tsp.cl
;(defun remove-nils (l) (remove-if #'null l)) ;already above

;from tle.cl
(defun quote-str (s) (format nil "\"~a\"" s))
(defun quote-str2 (s) (if (stringp s) (format nil "\"~a\"" s) s))
(defun quote-str3 (s) ;new ;quote if it has space, ok?
  (if (and (stringp s) (position #\Space s)) (format nil "\"~a\"" s) 
    (quote-char s)))
;(defun quote-char (c) (format nil "\"#\\~a\"" c))
(defun quote-char (c) 
  (if  (characterp c) 
    (format nil "#\\~a" c) ;(format nil "\"#\\~a\"" c)
    (if (and (stringp c) (< (length c) 4) (prefixp "#" c))
      (quote-char (aref c (1- (length c)))) 
      c)))
(defun clean-punct (s)  ;should check len=1 or..
  (if (not (punctp s)) (quote-alpha s)
    (quote-char (aref s 0)) ;case (aref s 0)
    ))
(defgeneric quote- (s))
(defmethod quote- ((s STRING))
   (format nil "\"~a\"" s))
(defmethod quote- ((s CHARACTER))
   (format nil "#\\~a" s))
(defmethod quote- ((s LIST))
  (mapcar #'quote- s))
      

(defun quote-alpha (s) 
  (if (alpha-start s) (quote-str s) s))
(defun ins-alpha (s) 
  (if (alpha-start s) (format nil "*~a" (string-downcase s)) 
    (quote-str s)))
(defun ins-alpha2 (s) 
 (if (eq (len s) 1) (clean-punct s)
  (if (alpha-start s) (format nil "*~a" (string-downcase s)) 
    (quote-str2 (num-str s)))))

;many more intersting fncs in the km utils/etc, &in the other gigs of opensrc code I have around.
;(defun split-strbybar (l)  (split-string l #\|)) 
(defun split-strbybar (l)  (split_string l #\|)) 
;-------------------------------------
;-move even more of mb3 here:
(defun rm-nil (l)
  (if (listp l) (remove 'nil l)
    l))
;-
(defun mkhl (h l) 
  "alst of:csv header&list of values for a line"
  (rm-nil (mapcar #'(lambda (a b) (when b (cons a b))) h l)))

;-
(defun getnum (str)
  (if (and (stringp str) (len-gt str 0)) ;new
    (numstr (trim-punct str))
    (when (numberp str) str)))

(defun numericp (sn) (numberp (getnum sn))) 
