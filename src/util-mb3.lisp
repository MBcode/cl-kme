(cl:in-package :cl-kme) 

;-from rsc2.cl /kick of parsers
;#+sbcl ;or #-acl
;(defun run-shell-command (txt) (asdf:run-shell-command txt)) ;taken out:june24,2013
(defun rsc (txt) (asdf:run-shell-command txt))
;(trace rsc)
 
;-from tsp.cl  /access csv parses
;(defun nth+ (ns ls) ;already above
;  (remove-nils ;assume nils only at end
;   (mapcar #'(lambda (n) (nth n ls)) ns)))
;
(defun flatten- (x) ;km has another flatten
  (labels ((rec (x acc)
             (cond ((null x) acc)
                   ((atom x) (cons x acc))
                   (t (rec (car x) (rec (cdr x) acc))))))
    (rec x nil)))
;
(defun flat-1 (l) ;check on ;was flat1 but use below
  (reduce #'nconc (copy-list l))) ;safter, 

;ben/ocelot2obo.lisp
(defun flatten1 (vals)
    (apply #'append (mapcar (lambda (x) (if (listp x) x (list x))) vals))) 

;(defun flat1 (vals) (flatten1 vals))
(defun flat1 (vals) 
  (if (full vals) (flatten1 vals)
    (progn (warn "flat1 ~a" vals) vals)))

(defun shuffle (x y)
  "Interleave two lists."   ; LMH
  (cond ((null x) y)
        ((null y) x)
        (t (list* (car x) (car y)
                  (shuffle (cdr x) (cdr y)))))) 
;
;defun r-find (s tree)
(defun r_find (s tree)
  (if (fulll tree) 
    (let ((f1 (find s tree :test #'member)))
      (if f1 f1 (mapcar- #'(lambda (tr) (r-find s tr)) tree))))) 
(defun find-member (s l) (when (fulll l) (find s l :test #'member)))
;(defun r-find-all (s tree)
;  (if (fulll tree) 
;    (let ((f1 (find s tree :test #'member)))
;      (if f1 (cons f1 (mapcar- #'(lambda (tr) (r-find-all s tr)) tree))
;	(mapcar- #'(lambda (tr) (r-find-all s tr)) tree))))) 
;(defun r-find-all (s tree)
;  (mapcar- #'(lambda (tr) (cons (find-member s tree) (r-find-all s tr))) tree))
	   
;web-access/umls-mysql070507.lisp
(defun rfind (s tree)
  (cond ((null tree) nil)
        ((atom tree)
         (if (equal s tree) tree nil))
        ((listp tree)
         (if (find s tree :test #'equal)
             (assoc s (list tree) :test #'equal)
           (or (rfind s (car tree))
               (if (cdr tree) (rfind s (cdr tree)))))))) 
;also in web-access/bat-utilities111406.lisp 
(defun rfind-all (key alst)
  (let* ((tree (copy-tree alst))
         (temp-result (rfind key tree))
         (results
          (loop while (and tree temp-result)
              collect temp-result into list-of-sub-alsts
              do (setq tree
                   (let ((test-tree (remove temp-result tree
                                            :test #'equal)))
                            (if (equal test-tree tree)
                                nil test-tree))
                     temp-result (rfind key tree))
              finally (return list-of-sub-alsts))))
    results)) 

;(defun tree-depth (tree) ;mv to mb2
;  (cond ((atom tree) 0)
;	(t (1+ (reduce #'max (mapcar #'tree-depth tree)))))) 

(defun r-find (s tree)
  (cond ((null tree) nil)
        ((atom tree)
         (if (equal s tree) tree nil))
        ((listp tree)
         (if (find s tree :test #'prefix_p)
             (assoc s (list tree) :test #'prefix_p)
           (or (rfind s (first tree))
               (if (rest tree) (rfind s (rest tree)))))))) 
;code/msc/msc/lsp/onlisp.lisp (more2look@here)
(defun rfind-if (fn tree)
  (if (atom tree)
    (and (funcall fn tree) tree)
    (or (rfind-if fn (car tree))
	(if (cdr tree) (rfind-if fn (cdr tree)))))) 
;might also want a set of things to search &use member/etc
;also could try a prefix-p that deals w/symbol(-names)
; prefix_p only slight ext2 equal, needs symb-prefix-p/overloading
;web-access/CLOS-class-browser.lisp also has .. ;eg.
;defmethod CLOS-class-grapher ((url url:http-form) stream)
;-------------------------------------in s.lisp, to mv2 mb2.lisp
;-------------------------------------
#+sbcl ;or #-acl
(defun run-2 (cmndstr arglst)
 (let* ((sb-impl::*default-external-format* :utf-8)
       (process (run-program cmndstr arglst
                             :output :stream
                             :wait nil)))
  (prog1 (read-line (process-output process))
    (process-wait process)
    (process-close process))))

#+sbcl ;or #-acl
(defun run_2 (cmndstr arglst)
 (let* (;(sb-impl::*default-external-format* :utf-8)
       (process (run-program cmndstr arglst
                             :output :stream
                             :wait nil)))
  (prog1 (read-line (process-output process))
    (process-wait process)
    (process-close process))))

 
;/ros-0.4/core/experimental/roslisp/rosutils.lisp
#+sbcl ;or #-acl
(defun run-external (cmd &rest args)
          (let ((str (make-string-output-stream)))
            (sb-ext:run-program cmd args :search t :output str)
            (let ((s (get-output-stream-string str)))
              (delete #\Newline s))))  

;in my sbclrc now
;#+sbcl ;or #-acl
;#-sbcl ;for sbcl in vicl2  j24
(defun run-ext (cmd &rest args)
          (let ((str (make-string-output-stream)))
            #+sbcl (sb-ext:run-program cmd args :search t :output str)
	    ;#-sbcl (run-shell-command cmd args) ;finish ;rsc
	    #-sbcl (run-shell-command  (format nil "echo \"~a ~a\"|cat>.tmp" cmd args)) ;finish
            (let ((s #+sbcl (get-output-stream-string str)
		     #-sbcl (read-file-to-string ".tmp")
		     ))
              s ;(delete #\Newline s)
	      )))
#+IGNORE
(defun run-xml (cmd &rest args) 
  "run-ext&prs ret xml2s-expr"
  ;STRING-OUTPUT-STREAM {100AAC9DC1}> is not a character input stream
  (let ((str (make-string-output-stream))) ;just tried
      (sb-ext:run-program cmd args :search t :output str)
              (s-xml:start-parse-xml str)))

 
(defun eval-str2 (s) ;1st in nlp.cl
    (eval-str (str-cat "'" s)))

;(defun clean4echo (s) (rm-strs '("*") s))
;(defun clean4echo (s) (rm-strs '("(" "*" ")" "_nil" "nil_") s))
;(defun clean4echo (s) (rm-strs '("(" "*" ")" "_nil" "nil_" ">" "<") s))
(defun clean4echo (s) (rm-strs '("(" "*" ")" "_nil" "nil_" ">" "<" ":" ",") s))
(defun run_ext (cmd &rest args)
          (let ((str (make-string-output-stream)))
            #+sbcl (sb-ext:run-program (clean4echo cmd) args :search t :output str)
	    #-sbcl (run-shell-command (clean4echo cmd)) ;finish
            (let ((s (get-output-stream-string str)))
              s ;(delete #\Newline s)
	      )))  
 
;;;ros-0.4.3/core/experimental/roslisp/utils/utils.lisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Symbols

(defun build-symbol-name (&rest args)
  "build-symbol-name S1 ... Sn.  Each Si is a string or symbol.  Concatenate them into a single long string (which can then be turned into a symbol using intern or find-symbol."
  (apply #'concatenate 'string (mapcar (lambda (x) (if (symbolp x) (symbol-name x) x)) args)))

(defun intern-compound-symbol (&rest args)
  "intern-compound-symbol S1 ... Sn.  Interns the result of build-symbol-name applied to the S."
  (intern (apply #'build-symbol-name args))) 


(defmacro with-struct ((name . fields) s &body body)
  "with-struct (CONC-NAME . FIELDS) S &rest BODY 
 Example:
 with-struct (foo- bar baz) s ...
 is equivalent to
 let ((bar (foo-bar s)) (baz (foo-baz s)))...  
 Note that despite the name, this is not like with-accessors or with-slots in that setf-ing bar above would not change the value of the corresponding slot in s."

  (let ((gs (gensym)))
    `(let ((,gs ,s))
       (let ,(mapcar #'(lambda (f)
                         `(,f (,(intern-compound-symbol name f) ,gs)))
              fields)
         ,@body))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Strings
#+ignore 
(defun tokens (string &key (start 0) (separators (list #\space #\return #\linefeed #\tab)))
  (if (= start (length string))
      '()
      (let ((p (position-if #'(lambda (char) (find char separators)) string :start start)))
        (if p
            (if (= p start)
                (tokens string :start (1+ start) :separators separators)
                (cons (subseq string start p)
                      (tokens string :start (1+ p) :separators separators)))
            (list (subseq string start))))))
;http://www.mail-archive.com/stumpwm-devel@nongnu.org/msg01195.html
;(in-package :stumpwm-user)
#+sbcl ;or #-acl
(require :sb-posix)
;;; XXX This is only a workaround for SBCLs with a unreliable
;;; run-program implementation (every version at least until
;;; 1.0.21). If someone makes run-program race-free, this should be
;;; removed! - Julian Stecklina (Oct 23th, 2008)
#+sbcl
(progn
  (defun exec-and-collect-output (name args env)
    "Runs the command NAME with ARGS as parameters and return everything
the command has printed on stdout as string."
    (flet ((to-simple-strings (string-list)
             (mapcar (lambda (x)
                       (coerce x 'simple-string))
                     string-list)))
      (let ((simplified-args (to-simple-strings (cons name args)))
            (simplified-env (to-simple-strings env))
            (progname (sb-impl::native-namestring name))
            (devnull (sb-posix:open "/dev/null" sb-posix:o-rdwr)))
        (multiple-value-bind (pipe-read pipe-write)
            (sb-posix:pipe)
          (unwind-protect
               (let ((child 
                      ;; Any nicer way to do this?
                      (sb-sys:without-gcing 
                        (sb-impl::with-c-strvec (c-argv simplified-args)
                          (sb-impl::with-c-strvec (c-env simplified-env)
                            (sb-impl::spawn  progname c-argv devnull 
                                             pipe-write ; stdout
                                             devnull 1 c-env 
                                             nil ; PTY
                                             1 ; wait? (seems to do nothing)
                                             ))))))
                 (when (= child -1)
                   (error "Starting ~A failed." name))
                 ;; We need to close this end of the pipe to get EOF when the child is done.
                 (sb-posix:close pipe-write)
                 (setq pipe-write nil)
                 (with-output-to-string (out)
                   ;; XXX Could probably be optimized. But shouldn't
                   ;; make a difference for our use case.
                   (loop 
                      with in-stream = (sb-sys:make-fd-stream pipe-read :buffering :none)
                      for char = (read-char in-stream nil nil)
                      while char
                      do (write-char char out))
                   ;; The child is now finished. Call waitpid to avoid
                   ;; creating zombies.
                   (handler-case
                       (sb-posix:waitpid child 0)
                     (sb-posix:syscall-error ()
                       ;; If we get a syscall-error, RUN-PROGRAM's
                       ;; SIGCHLD handler probably retired our child
                       ;; already. So we are fine here to ignore this.
                       nil))))
            ;; Cleanup
            (sb-posix:close pipe-read)
            (when pipe-write
              (sb-posix:close pipe-write))
            (sb-posix:close devnull))))))

 ;(defun stumpwm::run-prog-collect-output (prog &rest args)
 ;  "run a command and read its output."
 ;  #+sbcl (exec-and-collect-output prog args (cons 
 ;	(stumpwm::screen-display-string (current-screen))
 ;    (remove-if (lambda (str)
 ;		 (string= "DISPLAY=" str :end2 (min 8 (length str)))) 
 ;(sb-ext:posix-environ)))))
 (defun run2 (name args)
   "compare w/run-2 etc"
  #+sbcl (exec-and-collect-output name args nil))
  #-sbcl (run-shell-command name args)
  ) 
 
;(defun eval-str (s) 
;  (eval (read-from-string s))) 

#+ignore
(defun string-list->keyword-vector (string-list)
    (loop for string
          in (copy-list string-list)
          collect (intern (string-downcase string) :keyword)
          into keywords
          finally (return (apply #'vector keywords))))

#+ignore
(defun record->list (delimiter seq) ;explode could also do this
  (let ((end (length seq)))
    (loop for left = 0 then (+ right 1)
          for right = (or (position delimiter seq :start left) end)
          if (< left right)
          collect (subseq seq left right)
          until (eq right end))))

;=look at using a bit more from: choice-params-ff3e-new.cl
;; (find-elt-in-string "Age greater than 18 years" *english-arithmetic-comparators-vector*)
;; (find-elt-in-string "pulmonary hypertension due to congenital heart disease" *semantic-connectors-vector*)
#+ignore
(defun find-elt-in-string (string vector)
  (loop with downcase-string = (string-downcase string)
      with res = nil
      for v across vector
      thereis (when (setq res
                      (let ((s (string-downcase v)))
                        (or (and (find #\space s)
                                 (search s downcase-string
                                         :test #'string-equal)
                                 s)
                            (and (not (find #\space s))
                                 (find s (record->list #\space downcase-string)
                                       :test #'string-equal)
                                 s))))
                (return res))))

#+ignore
(defun find-elt-n-string (s v)
  "if key-vect in str, ret (substr str)"
  (let ((ps (find-elt-in-string s v)))
    (when ps (list ps s))))
 
#+ignore
(defun find-substring-in-string (string list)
  (loop with downcase-string = (string-downcase string)
      with tokens = (record->list #\space downcase-string)
      for elt in list
      thereis (when (loop for token in tokens
                        thereis (when (string-equal token elt)
                                  (return elt)))
                (return elt))))
 
#+ignore
(defun seq-cmp (seq1 seq2 cmp) ;this is wrong, use len
; (and (eq (type-of seq1) (type-of seq2))
;      (or (stringp seq1) (listp seq1))
;      (funcall cmp (length seq1) (length seq2)))
       (funcall cmp (nnlen seq1) (nnlen seq2)))
;broke out to allow other comparisions
;(defun seq-longerp (seq1 seq2)
;  (seq-cmp seq1 seq2 #'>))
;(defun seq-shorterp (seq1 seq2)
;  (seq-cmp seq1 seq2 #'<))
 
;; (direct-siblings 'Quantitatively_Restricted_Term)
#+ignore
(defun direct-siblings (class)
  (when (ignore-errors (find-class class))
    (let* ((superclasses (direct-superclasses class))
           (siblings (loop for superclass in superclasses
                       append (direct-subclasses superclass))))
      siblings)))
 
(defun list->choice-list (list-of-elements &key (index-p nil)
                                                (splice-keywords t)
                                                (space-char-replacement #\_)
                                                (max-strlen 110)
                                                )
  "elements may be pair-lists or individual strings - processed accordingly"
   (declare (optimize (speed 3))
            (type cons list-of-elements))
   (if (choice-list-p list-of-elements)
       list-of-elements
   (let (display-string)
     (loop for element in list-of-elements
         for i from 1
         do (let* ((string1 (typecase element
                              (symbol (string element))
                              (string element)
                              (list (first element))))
                   (string1-len (length string1)))
              (setq display-string
                (format nil "~a~a~a"
                        (if (not index-p) "" i)
                        (if (not index-p)
                            ""
                          (if (> i 9) "&nbsp;" "&nbsp;&nbsp;&nbsp;"))
                        (subseq string1
                                0
                                (min max-strlen (length string1 ))))))
         collect (list display-string
                       :value
                       (or (intern
                            (if (listp element)
                                (second element)
                              (if splice-keywords
                                  (substitute
                                   space-char-replacement #\space
                                   (string-trim '( #\space )
                                                display-string))
                                display-string))
                            :keyword)))
         into 3-tuples
         finally (return (remove-duplicates 3-tuples :test #'equalp))))))
 
(defun has-more-tokens-p (string1 string2)
  (when (and (stringp string1) (stringp string2))
    (cond ((and (not (search " " string1))
                (not (search " " string2)))
           nil)
          ((not (search " " string1)) nil)
          ((not (search " " string2)) t)
          (t (let ((token-list1 (record->list #\space string1))
                   (token-list2 (record->list #\space string2)))
               (> (length token-list1) (length token-list2)))))))
 
(defgeneric siblings-choice-list (s))
;; (siblings-choice-list 'Quantitatively_Restricted_Term)
(defmethod siblings-choice-list ((s symbol))
  (when (ignore-errors (find-class s))
    (list->choice-list (direct-siblings s))))
 
(defun choice-list-p (x)
  (and (listp x)
       (or (and (listp (car x))
                (eq (second (car x)) :value)
                (keywordp (third x)))
           (consp (car x)))))

(defun string->upcase-keyword (s)
  (intern (substitute #\_ #\space (string-upcase s)) :keyword))
 
;-
(defun getnum (str)
  (if (and (stringp str) (len-gt str 0)) ;new
    (numstr (trim-punct str))
    (when (numberp str) str)))

(defun numericp (sn) (numberp (getnum sn)))

(defun get_nums (line)
      (collect-if #'numberp (mapcar #'getnum (remove-if-not #'full (explode- line)))))
(defun first-num (line)
    (first-lv (get_nums line)))
(defun second-num (line)
    (second-lv (get_nums line)))


(defun subseqs (lst snl &key (start nil) (end nil))
  "start# end=t subseq  maps over offset lst of positions"
 (let ((snl1 (if start (cons start snl) snl))
       (snl2 (if end (append snl (list (len lst)))  snl)))
    (when *dbg-ut* (format nil "~&~a ~a" snl1 snl2))
    (mapcar #'(lambda (a b) (subseq lst a b)) snl1 (rest snl2))))
 
;;==from lexA.cl 2fncs:
;defgeneric wordize (fn) ;would have to differentiate str&path, which i can do later
(defun wordize (fn) ;or list of lines now
  (let* ((l (if (listp fn) fn (list-lines fn)))
         (lc (mapcar #'string-downcase l)) ;added
         (le (mapcar #'explode- lc))
         (re (reduce #'union le))
         (ret (mapcar #'(lambda (x) (string-trim " ()./[]:;,\\\"" x)) re)) ;added
        )
    ;now reduce by getting intersection (basically doing a sortu)  ;also rm all nonalphnum
(remove-duplicates ret :test #'string=)))

(defun phraseize (fn)
  "keep as phrases this time"
  (let* ((l (list-lines fn))
         (lc (mapcar #'string-downcase l)) ;added
         (ret (mapcar #'(lambda (x) (string-trim " ()./[]:;,\\\"" x)) lc)) ;added
         )
    (remove-duplicates ret :test #'string=)))
 
(defun mklist (l) (list+ l))
;; (insert-into-seq 'new '((1 2) 'a ((5 6))) 1)
;; => ((1 2) NEW ((5 6)))
;; (insert-into-seq 'new '((1 2) 'a ((5 6))) 1 :replace-existing t)
;; (insert-into-seq 'new '((1 2) 'a ((5 6))) 1 :replace-existing t :splicep t)
;; (insert-into-seq 'new '((1 2) 'a ((5 6))) 1 :replace-existing nil)
;; => ((1 2) 'A NEW ((5 6)))
(defun insert-into-seq (new seq pos &key replace-existing splicep)
  (loop for item in (mklist seq)
      for i from 0 below (length seq)
      if (= i pos)
      append (if replace-existing
                 (if (and splicep (listp new))
                     new
                   (list new))
               (list new item))
      else
      collect item))
 

(defun insert-char (char string pos &key (excluded-char char))
  (when (stringp string)
    (let* ((string-len (length string))
           (preceding-char (if (= pos 0) nil (char string (1- pos))))
           (next-char (if (= pos (1- string-len)) nil (char string (1+ pos)))))
      (cond ((= (length string) 0) (string char))
            ((< pos 0)
             (coerce (cons char (coerce string 'list)) 'string))
            ((and (> pos 0)
                  (< pos string-len)
                  excluded-char
                  (eq (char string (1- pos)) excluded-char))
             string)
            ((>= pos string-len)
             (coerce (append
                      (coerce string 'list)
                      (list char))
                     'string))
            (t (coerce (insert-into-seq char (coerce string 'list) pos)
                       'string))))))
 
;try ;given month how many days to add, to get get days through year; assume same yr2start
(defparameter +month2days+ '(("Jan" .  0) ("Feb" . 31) ("Mar" . 59) 
			     ("Apr" . 90) ("May" . 120) ("Jun" . 151)
			     ("Jul" . 181) ("Aug" . 212) ("Sep" . 243)
			     ("Oct" . 273) ("Nov" . 304) ("Dec" . 334)))
(defun file-date (file)
  (subseq (explode- (run-ext "ls" "-l" file)) 8 11))

(defun month2day (mstr)
  (let ((a (assoc mstr +month2days+ :test #'equal)))
    (if (full a) (cdr a) 0)))

(defun file-day+time (file)
  (let* ((mdt-l (file-date file))
	 (m (first mdt-l))
	 (d (parse-integer (second mdt-l)))
	 (tme (third mdt-l)))
    (cons (+ (month2day m) d) tme)))

(defun time> (t1 t2)
  ;finish
  )
(defun day+time> (tp1 tp2)
  (let* ((td1 (first tp1))
	 (td2 (first tp2)))
    (if (= td1 td2) (time> (cdr tp1) (cdr tp2))
      (> td1 td2))))

;---------------------mv to mb1
;(defun collect-if (predicate sequence) 
;  (when (full sequence)
;    (remove-if-not predicate sequence)))
;(defun collect-if-not (predicate sequence) 
;  (when (full sequence)
;    (remove-if predicate sequence)))
;
;(defun collect-if-eq (to seq &key (key #'nop)) 
;  (collect-if #'(lambda (it) (equal (funcall key it) to)) seq))
;
;(defun collect (fnc lst) ;== remove-nils on mapcar
;    (collect-if #'nop (mapcar fnc lst))) 
;;(collect #'(lambda (n) (when (evenp n) n)) '(1 2 3 4 5 6 7 8)) ;(2 4 6 8)
;---------------------

;from ruleed-tables1.lisp
(defun break-into-subseqs (list &key (subseq-len 2))
  (when (and (listp list)
             (numberp subseq-len))
    (let ((listlen (length list)))
      (cond ((< listlen subseq-len) nil)
            ((= listlen subseq-len) list)
            (t (cons (subseq list 0 subseq-len)
                     (break-into-subseqs
                      (subseq list subseq-len)
                      :subseq-len subseq-len)))))))
;USER(3): (break-into-subseqs '(0 0 1 1 0 0 1 1 0 1)) ;((0 0) (1 1) (0 0) (1 1) 0 1) ;last wrong?
;USER(4): (break-into-subseqs '(0 0 1 1 0 0 1 1 0 1) :subseq-len 3) ;((0 0 1) (1 0 0) (1 1 0))
 
;http://stackoverflow.com/questions/610680/linearly-recursive-list-difference-function-in-common-lisp
(defun list-diff (L1 L2)
  (cond
    ((null L1) nil)
    ((null (member (first L1) L2)) (cons (first L1) (list-diff (rest L1) L2)))
    (t (list-diff (rest L1) L2))
  )
);j8a see if this makes sense /useful for diff of nlp parses

(defun list-difference (a b) ;was in in/ssheet3
    (mapcar #'(lambda (e) (remove e b :count 1)) a)) 

;http://groups.google.com/group/comp.lang.lisp/browse_thread/thread/2d71b553b62e20b5?hl=en#
(defun mapconcat (fun list sep) 
   (when list 
      (let ((~sep (with-output-to-string (*standard-output*) 
                     (map nil (lambda (ch) (princ (if (char= #\~ ch) "~~" ch))) sep)))) 
       (format nil (format nil "~~A~~{~A~~A~~}" ~sep) 
               (funcall fun (first list)) 
               (mapcar fun (rest list))))))  
;(mapconcat 'identity '("one" "two" "three") "-") 
;--> "one-two-three" 
;(mapconcat (lambda (x) (concatenate 'string "[" x "]")) '("one" "two" "three") "~") 
;--> "[one]~[two]~[three]"
;-from: "s-acc.cl"
;#+IGNORE 
(progn ;redone elsewhere
(defun st (a b)
  "str w/in a str" ;make a str-intersection
  (search a b :key #'char-upcase))
(defun str_intersect (a b)
  (when (and a b)
    (cons (st a b) (st b a))))
(defun explode_ (s)
  (mapcar #'string-downcase (explode- s)))
(defun str-intersect (a b) ;have an eq that upcases everything 1st
  (intersection (explode_ a) (explode_ b) :test #'equal)) ;ok
(defun str+intersect (a b)
  (cons (str-intersect a b) (str_intersect a b)))
)
(defun first-numstr (l) (eval (numstr (first l)))) 
;-
(defun first_num-in-str (ps)
     (if (numberp ps) ps
           (numstr (second (explode- ps)))))
(defun first2num-in-str (l) (first_num-in-str (first l))) 
;-
(defun prs-datetime (dts)
    (let* ((dt2 (explode- dts))
           (ds (first dt2))
           (ts (second dt2))
           (dl (split-at-2nums ds))
           (tl (split-at-2nums ts ":"))
           )
      (append dl tl)))
(defun univ-time (l)
  (apply #'encode-universal-time (reverse l)))
(defun prs-univ-time (dts)
  (univ-time (prs-datetime dts)))
(defun prs-univ-time- (dts &optional (off 3155702400))
  (let ((ut (prs-univ-time dts)))
    (if (numberp off) (- ut off) ut)))
;-
(defun countInAlst (n alst)
  "fraction w/n"
  (let ((ncnct (sum-l (mapcar #'(lambda (l) (count n l)) alst)))
	(d+a (sum-l (mapcar #'len alst)))
	(a (len alst)))
    (/ ncnct (- d+a a))))
;-
(defun str-eq2 (a b) (equal (string-downcase a) (string-downcase b))) ;used in sort/ec
;could apply equal mapcar .. &call w/&rest
;-
(defun ssort (l &optional (cmp #'string<))
    "safe sort of a list of symbols"
   ;(sort (copy-list l) #'string< :key #'symbol-name)
    (sort (copy-list l) cmp :key #'symbol-name)
    )
;;printout.cl 
(defgeneric prins (a &optional s))
(defmethod prins ((arg string) &optional (strm t))
  (princ arg strm))
(defmethod prins ((arg number) &optional (strm t))
  (princ arg strm))
(defmethod prins ((arg symbol) &optional (strm t))
  (princ (symbol-name arg) strm))
(defmethod prins ((arg cons) &optional (strm t))
  ;(format nil "~{~a, ~}" arg)
  (dolist (a arg) do (princ a strm)))
(defmethod prins (arg &optional (strm t))
  (print-object arg strm)) 

(defun printout (strm &rest args)
  (if (eq strm t) (setf strm nil))
  (dolist (a args) do
    (prins a strm)))
;-eof
(defun format-list (list) (format t "~{~a~^, ~}" list))
(defun frmt-l (list) (format t "~{~a~^, ~}" list))
;;junk:
(defun first-num- (line) ;skip
  "pull 1st # from str"
  (when (full line)
    (getnum (first (remove-if-not #'full (explode- line))))))
;
(defun sum-l (the-seq &key (start 0) (end (length the-seq))) 
  (reduce #'+ the-seq :start start :end end))

(defun sum (&rest args) (sum-l args))

(defun posative-p (n) (and (numberp n) (> n 0)))
 
(defun ave-l (the-seq &key (start 0) (end (length the-seq))) 
 ;(/ (reduce #'+ the-seq :start start :end end) (- end start))
 (let ((num (- end start))) ;now get nil if input not fulll
   (when (posative-p num)
     (/ (reduce #'+ the-seq :start start :end end) num))))

(defun ave (&rest args) (ave-l args))
;-added test
(defun get1+ (key l)  ;get-key 
  "generic get value after key"
  (let ((p (position key l :test #'equal)))
    (when (and (numberp p) (< p (1- (len l)))) (elt l (1+ p)))))
(defun get2+ (key l)
  (let ((p (position key l :test #'equal)))
    (when (numberp p) (elt l (+ p 2)))))
;-http://groups.google.com/group/comp.lang.lisp/browse_thread/thread/f127c58d9ae193f2/770eb1ec95f606a5?hl=en&lnk=raot#770eb1ec95f606a5
;(show-tree '(animal (pet (cat (siamese) (tabby))  (dog (chihuahua)))(farm (horse (2)) (cow (2)))))
(defun show-tree (node) 
   (labels ((show (node prefix) 
              (format t "~S~%" (car node)) 
              (let ((next-prefix (format nil "~A |   " prefix))) 
                (mapl #'(lambda (nodes) 
                          (format t "~A +-- " prefix) 
                          (show (car nodes) 
                                (if (null (cdr nodes)) 
                                  (format nil "~A     " prefix) 
                                  next-prefix))) 
                      (cdr node))))) 
     (terpri) 
     (show node "") 
     (values)))  

(defun alst2 (al)
  "alist into 2 lists" ;op of pairlis
  (loop for e in al
	collect (car e) into a
	collect (cdr e) into b
	finally (return (list a b))))

;(defun max-l (l) (apply #'max l))
;(defun min-l (l) (apply #'min l))
;(defun max_l (l) (max-l (flat1onlys l)))
;(defun min_l (l) (min-l (flat1onlys l)))
;(defun max-fl (l) (max-l (flatten- l)))
;(defun min-fl (l) (min-l (flatten- l)))
;-
;(defun range- (start end)
;    (when (and (numberp start) (numberp end))
;          (loop for i from start to end collect i)))
;(defun range_ (end &optional (start 0))
;    (range- start (1- end))) 
;(defun range_1 (end &optional (start 0))
;  (range_ (1+ end) (1+ start)))
;-
(defun date- () (run-ext "date"))
;-
;http://groups.google.com/group/comp.lang.lisp/browse_thread/thread/917ec8f0a3fe30c7?hl=en# 
(defun print-subclasses (root &optional (indent 0)) 
  (dotimes (x indent) (princ "  ")) 
  (let ((class (typecase root 
                 (class root) 
                 (symbol (find-class root)) 
                 (t (class-of root))))) 
    (princ (class-name class)) 
    (terpri) 
    (dolist (sub 
	      #+sbcl (sb-mop:class-direct-subclasses class)
	      #-sbcl (clos:class-direct-subclasses class)
	      ) 
      (print-subclasses sub (1+ indent))))) 
;-
(defun butlast- (s)
  (subseq s 0 (1- (len s))))

(defun butlast-n (s n)
  (subseq s 0 (- (len s) n)))

(defun butfirst-n (s n)
  "everything after1st n in a seq"
    (subseq s n (len s))) 

(defun rm-ext (s)
  "rm extention"
  (let ((n (position #\. s :from-end t)))
    (when n (subseq s 0 n))))
;----
;-ut  ;how much better than ut/ fncs?
(defun rfind_ (s tree) ;work on
  (cond ((null tree) nil)
        ((atom tree)
         (if (equal s tree) tree nil))
        ((listp tree)
         (if (find s tree :test #'equal)
             (member s tree :test #'equal) ;(assoc s (list tree) :test #'equal)
           (or (rfind_ s (car tree))
               (if (cdr tree) (rfind_ s (cdr tree))))))))

(defun rfind_all (key alst)
  (let* ((tree (copy-tree alst))
         (temp-result (rfind_ key tree))
         (results
          (loop while (and tree temp-result)
              collect temp-result into list-of-sub-alsts
              do (setq tree
                   (let ((test-tree (remove temp-result tree
                                            :test #'equal)))
                            (if (equal test-tree tree)
                                nil test-tree))
                     temp-result (rfind_ key tree))
              finally (return list-of-sub-alsts))))
    results))
;-now not for member, but for naming of consecutive id's e.g. 1a 1b..
(defvar *alph* 
'(#\a #\b #\c #\d #\e #\f #\h #\i #\j #\k #\l #\m #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z))
(defvar *alphs* 
'("a" "b" "c" "d" "e" "f" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"))
;-
(defun equals (&rest l) (apply #'equal (mapcar_ #'(lambda (x) (under_ (to-str x))) l))) 
;-
(defun assocs (key alst &optional (ef #'equals))
  "assoc that can handle a str key, ret value, when it exists"
  (let ((v (assoc key alst :test ef))) ;was #'equalp
    (when v (cdr v))))
(defun assocs+ (s alst) (list+ (assocs s alst)))
;-
(defun assoc-w (l v)
  "assoc lst w/value"
  (mapcar_ #'(lambda (le) (cons le v)) l))
;-
(defun dash-p (s) (search "-" s))
;-
(defgeneric s2num (s))
(defmethod s2num ((sym SYMBOL))
  (s2num (symbol-name sym)))
(defmethod s2num ((str String))
 ;(mapcar #'string-to-number (split-at-dash str))
 (if (not (dash-p str)) (string-to-number str)
   (let ((s (rm-dash str)))
     ;(list (first-num s) (second-num s) 'pp)
     (list (first-num s) (second-num s))
     ))
  )
;(defmethod s2num (s)
;  (when *dbg-ut* (format nil "~&warn:s2num:~a,~a" s (type-of s)))
;  (s2num (to-str s)))
(defmethod s2num ((n Number))
  ;n
  (list n)
  )
(defmethod s2num ((l List))
  (mapcar_ #'s2num  l))
;-
(defun rm-nil (l)
  (if (listp l) (remove 'nil l)
    l))
;-
(defun range-list-p (l) 
  (when (eq (len l) 2)  (rm-nil l)))
(defun range-list2range (l)
  (let ((rl (range-list-p l)))
    (if (not rl) l
      (if (eq (len rl) 1) rl ;if part of range nil, 
	(loop for i from (first rl) to (second rl) collect i)))))
;-
(defun s2nums (s)
 ;(range-list2range (s2num s))
  (mapcar_ #'range-list2range (s2num s))
  )
;-
(defgeneric split-at-dash (s))
(defmethod split-at-dash ((sym SYMBOL))
  (split-at-dash (symbol-name sym)))
(defmethod split-at-dash ((str STRING))
  (let ((r (split-at1 str "-")))
    (if r (range-list2range r)  ;check:want ret ranges expanded
      (list str) ;so can map over single or ranges
      )))
;defmethod split-at- ((str STRING))
(defun split-at- (str)
  (split-at1 str "-"))
(defun split-at-2 (str &optional (by "-")) 
  (let* ((fs (split-at1 str by)) 
         (one (first fs)) 
         (dd (second fs)) 
         (lt (split-at1 dd by))) 
    (cons one lt)))
;USER(15): (split-at-2 "2010-08-18") ("2010" "08" "18")
(defun split-at-2nums (str &optional (by "-")) 
  (s2num (split-at-2 str by)))
;moved rest to p2.lisp till it settles down
(defun nth-eq (n l e)
  (when (listp l) (eq (nth n l) e)))
(defun first-eq (l e)
  (when (listp l) (eq (first-lv l) e)))

(defun list2alst (l)
  "pairlis"
  (when l 
    (let ((ln (len l)))
      (if (and (>= ln 2) (evenp ln))
	(cons
	  (cons (first l) (second l))
	  (list2alst (rest (rest l))))
	(warn "no alst of")))))

(defun s-num-str (s) (when s (num-str s)))
(defun s-to-str (s) (when s (to-str s)))

(defun csv_parse-str (string &key (separator #\Tab) (whitespace +whitespace+))
  "Parse a string, returning a vector of strings."
  (loop :with num = (count separator string :test #'char=)
    :with res = '() ;(make-array (1+ num))
    :for ii :from 0 :to num
    :for beg = 0 :then (1+ end)
    :for end = (or (position separator string :test #'char= :start beg)
                   (length string))
        ;setf (aref res ii)
    :do (push ;ref res ii
              (when (> end beg) ; otherwise NIL = missing
                (csv-trim whitespace (subseq string beg end)))
              res
              )
    :finally (return (nreverse res))))

(defun numstr- (s) ;from mb3 
  (if (has-date-p s) (prs-univ-time- s)  (numstr s)))

(defun prs-csv (str) (csv_parse-str str  :separator #\Comma))
(defun prs-csv-nums (str) 
  (mapcar- #'numstr- (prs-csv str)))
 
(defun under_f (str) ;better than cache version ;see m16_
  (let* ((wrds (string-to-words str))
         (iname (str-cat_l wrds)))
    iname))
 
(defgeneric s2num (s))
(defmethod s2num ((sym SYMBOL))
  (s2num (symbol-name sym)))
(defmethod s2num ((str String))
 ;(mapcar #'string-to-number (split-at-dash str))
 (if (not (dash-p str)) (string-to-number str)
   (let ((s (rm-dash str)))
     ;(list (first-num s) (second-num s) 'pp)
     (list (first-num s) (second-num s))
     ))
  )
;(defmethod s2num (s)
;  (when *dbg-ut* (format nil "~&warn:s2num:~a,~a" s (type-of s)))
;  (s2num (to-str s)))
(defmethod s2num ((n Number))
  ;n
  (list n)
  )
(defmethod s2num ((l List))
  (mapcar_ #'s2num  l))
 
(defun slot->defclass-slot (spec)
  (let ((name (first spec)))
    `(,name :initarg ,(as-keyword name) :accessor ,name))) 

(defun len-eq (l n) (and (listp l) (eq (len l) n)))
(defun len_gt (l n) (when (fulll l) (len-gt l n)))
(defun len_ge (l n) (when (fulll l) (len-gt l (1- n))))
(defun rm-nils (l) (collect-if #'full l))
(defun run-ext2s (s s2)
  "input1str&it breaks4you"
  (apply #'run-ext (append (tokens s) (list s2))))
 
(defun prefix-bar (s) (prefix-p #\| s)) 

;defun iso-time (&optional (time (get-universal-time)))
(defun iso-time- (&optional (time (get-universal-time)))
  "Returns the universal time TIME as a string in full ISO format."
  ;multiple-value-bind (second minute hour date month year)
  (multiple-value-bind (minute hour date month year)
      (decode-universal-time time)
    ;format nil "~4,'0d-~2,'0d-~2,'0d ~2,'0d:~2,'0d:~2,'0d"
    (format nil "~4,'0d-~2,'0d-~2,'0d-~2,'0d-~2,'0d"
            year month date hour minute ;second
	    )))
;prs-univ-time does the opposite 

;;from: http://www.cs.ut.ee/~isotamm/PKeeled/AllarOja_LISP/LISP/HangMan.cl
;USER(1): (explode "abc") -> (|a| |b| |c|) ;w/small cleaning 
(defun goexplode (word cur last fword)
   (cond ((equal cur last)
          (append fword
                  (list (prog1 (intern (string (char (string word) (1- cur)))))) ))
         (t  (goexplode word (+ cur 1) last
                        (append fword
                                (list (prog1 (intern (string (char (string word) (1- cur))))))) ))))

(defun explode2s (word &key (upper t))
   (let ((lenword (length (string word))))
    (cond ((null word) nil)
          (t (goexplode (if upper (string-upcase word) word) 
                        1 lenword '())))))
 
;set-difference reorders so
;need set_diff that doesn't reorder, picked small collect only if not memeber of it
(defun set_diff (a b)
  "set-difference that doesn't unorder the list"
  (collect-if-not #'(lambda (e) (member e b)) a))
;explode2s str2 list of symbol/letters
(defun implode2s (l)
  "l of sym/letters->str"
  (implode-l l nil))

(defun positivep (n) (> n 0)) ;put in utils

(defun rm-if-member (m lol)
  (remove-if #'(lambda (l) (member m l)) lol)) 

(defun no-nils (l) (not (member nil l))) 
(defun any-t (l) (len-gt (rm-nil l) 0))
 
(defmacro while (test &body body)
  `(do ()
     ((not ,test))
     ,@body))

;from my tfec.cl work
(defun i-lt-n-p (i n)
  (if (numberp n) (< i n)
    t))
(defun apply-lines-n (filename linefnc &optional (n nil))
  "apply to at most n lines"
 (let ((tot 0))
  (with-open-file (stream filename :direction :input)
    (loop for line = (read-line stream nil)
        while (and line (i-lt-n-p tot n))
        do 
        (incf tot)
        (funcall linefnc line)))))
;want to either collect csv lines, or mk km ins w/o collecting, which is preferable for large n
(defun csv-bar (l) (csv_parse-str l :separator #\|))

 
;-redone, to give class.txt mkclskm
;(defun 2l2alst (l1 l2) (mapcar #'cons l1 l2)) ;(defun mkhl (h l) (2l2alst h l))
(defun mkhl (h l) 
  "alst of:csv header&list of values for a line"
  (rm-nil (mapcar #'(lambda (a b) (when b (cons a b))) h l)))

(defun mkalst-n (a b n) 
  "mk alst except for nth vals"
  (loop for ia in a 
        for ib in b 
        for count = 0 then (+ count 1)
        unless (= count n) collect (cons ia ib)))


(defun first-nonnil (l) (first (rm-nil l)))
               ;(i (or (first l) (second l)))
(defun assoc2 (i a) 
  "val/2nd of assoc"
  (let ((as (assoc i a :test #'equal)))
    (when as (cdr as)))) ;was second

(defun assoc2nd (i a) 
  "val/2nd of assoc"
  (let ((as (assoc i a :test #'equal)))
    (when as (second as)))) ;was second 
;tried to do both assoc w/assoc-v above ;maybe better than tfec.cl attempt2do it.
(defun assoc_v (k a)  (let ((v (assoc k a :test #'equal))) (when v (first-lv (rest v))))) ;best
(defun assoc_v1 (k a)  (let ((v (assoc k a :test #'equal :key #'first-lv))) (if (consp v) (cdr v) v)))
;-
(defun rm-nohtm (s) (rm-str "><" s))

(defun link-disp-txt (s)
  "part of txt >that if visable in html<"
 (if (not (stringp s)) s
  (let ((ps (positionsl '(#\> #\<) (rm-nohtm s))))
   (if (fulll ps) (subseq s (1+ (second ps)) (third ps))
     s)))) 
;-
;(defgeneric safe_v (s)) ;rest in u2.lisp

;- 
(defun eq-len (a b) ;do for more
  (eq (len a) (len b)))
;- 
;defun subseqs (lst snl &key (start nil) (end nil)) ;orginal in mb_utils
(defun subseq-s (lst snl &key (start nil) (end nil) (add2 t))
  "start# end=t subseq  maps over offset lst of positions"
 (let ((snl1 (if start (cons start snl) snl))
       (snl2 (if end (append snl (list (len lst)))  snl)))
    (when *dbg-ut* (format nil "~&~a ~a" snl1 snl2))
    (mapcar #'(lambda (a b) (subseq lst a (if add2 (1+ b) b)))
        snl1 (rest snl2))))

(defun break-by-pair (s p)
  "seq broken in parts between brakets or whatever"
  (let ((pl (positionsl p s)))
    (subseq-s s pl)))

(defun break-by-brackets (s) ;no only if no embedding  ;finish&get2 json-decode quickly
  (break-by-pair s '(#\[ #\])))
;-have a version that gets from 1st in start to last from end-:ut/ascii.lisp between-str2curlys
(defun between-str2curlys (s) (between-str2by s #\{ #\})) ;better name 
(defun between-str2by2 (str by by2)
  "between (by+by2  by2-on)"
  (list (between-str2by str by by2)
        (last-str2by-end str by2)))
(defun between-str2curlys2 (s) (between-str2by2 s #\{ #\}))
;-
(defun lists2alst (l1 l2) (mapcar #'cons l1 l2)) ;not used yet
(defun l+v2alst (l v) (mapcar #'(lambda (e) (cons e v)) l))
;defun collect-curlys (s )
;-
;http://letoverlambda.com/index.cl/guest/chap5.html http://letoverlambda.com/lol-orig.lisp
(defun predicate-splitter (orderp splitp)
  (lambda (a b)
    (let ((s (funcall splitp a)))
      (if (eq s (funcall splitp b))
        (funcall orderp a b)
        s))))
;(sort '(5 1 2 4 3 8 9 6 7)  (predicate-splitter #'< #'evenp))
;        (2 4 6 8 1 3 5 7 9)

;============from: binary-types-0.90
(defun make-pairs (list)
  "(make-pairs '(1 2 3 4)) => ((1 . 2) (3 . 4))"
  (loop for x on list by #'cddr collect (cons (first x) (second x)))) 

;-
;(defun ls2 (p) (mapcar_ #'(lambda (f) (str-cat p f)) (ls p))) ;next txt-files2
(defun ls2 (&optional (p "")) 
  (if (full p)
    (mapcar_ #'(lambda (f) (str-cat p f)) (ls p))
    (ls)))

(defun explode-by-tab (s) (csv_parse-str s))  ;or csv-parse-str but that gives an array
(defun explode-by-space (s) (collect-if #'full (explode- s))) ;1or more spaces treated as one  
(defun explode-by-ctrl-a (s) (explode- s #\^A)) ;in mh2t will use csv-parse-str to get Tabs
 

(defun txt-p (s) (suffixp ".txt" s))
;defun txt-files2 (&optional (path nil)) 
(defun files-of-p (&optional (path nil) (filetype-p #'txt-p))
  (if path (mapcar_ #'(lambda (f) (str-cat path f)) (collect-if filetype-p (ls path)))
    (collect-if filetype-p (ls))))
(defun txt-files2 (&optional (path nil)) (files-of-p path #'txt-p)) 

(defun clean-htm (s) (replace-substrings s   "\">"   "_")) ;or simple-replace-strings w/alst 2chng;NO
 
;"utr2.lisp" 555 lines --69%- 
(defun tree-map (fn tree)
  "Maps FN over every atom in TREE."
  (cond
   ((null tree) nil)
   ((atom tree) (funcall fn tree))
   (t
    (cons
     (tree-map fn (car tree))
     (tree-map fn (cdr tree)))))) 

(defun split-strs2at2 (strs by)
 (let ((p (position by strs :test #'equal)))
  (when p
      (cons ;(apply #'str-cat 
           (subseq strs 0 p);)
            ;(apply #'str-cat 
               (subseq strs (+ p 1);)
               )))))
(defun rest-from (strs by)
  (rest (split-strs2at2 strs by)))
 
(defun run-ext2 (s)
  "input1str&it breaks4you"
  (apply #'run-ext (tokens s)))
(defun run-ext2ls (l s)
  "start run-ext2 off w/a pre-list"
  (apply #'run-ext (append l (tokens s)))) 

(defun postfix-if-not (post str)
  "make sure it ends w/post"
  (if (suffixp post str) str
    (str-cat str post))) 

(defun replace-all (string part replacement &key (test #'char=))
"Returns a new string in which all the occurences of the part 
is replaced with replacement."
    (with-output-to-string (out)
      (loop with part-length = (length part)
            for old-pos = 0 then (+ pos part-length)
            for pos = (search part string
                              :start2 old-pos
                              :test test)
            do (write-string string out
                             :start old-pos
                             :end (or pos (length string)))
            when pos do (write-string replacement out)
            while pos)))

(defun stream_lines (strm)
  "read stream->1str"
  (loop for line = (read-line strm nil)
        while line
        collect line)) 

(defun file2str (fn) (with-open-file (strm fn :direction :input) (stream_lines strm)))  

(defun warn-nil (nv str1 val1)
  (if nv nv
    (warn str1 val1))) 


(defun genstr (s)
  "unique-str GUID"
  (symbol-name (gensym s))) 

;http://compgroups.net/comp.lang.lisp/increment-hash-value-2/703023
(defun count-items (lst)
  "sum up lst occurances &print"
  (let ((ht (make-hash-table)))
    (loop :for item :in lst :do
       (incf (gethash item ht 0))
       :finally
       (maphash #'(lambda (k v) (format t "~A: ~A~%" k v)) ht))))

(defun count-alst (lst)
  "sum up alst vals &print"
  (let ((ht (make-hash-table)))
    (loop :for item :in lst :do
          ;maximizing 
       (incf (gethash (car item) ht 0) (cdr item))
          ;into mx
       :finally
       (maphash #'(lambda (k v) (format t "~A: ~A~%" k v)) ht)
       ;mx
       ))) ;get a loop max in there too ;have a version that does it
 
(defun assocp (cp)
  (when (consp cp)
    (and (atom (car cp)) (atom (cdr cp)))))

(defun lolp (cp)
  (when (listp cp)
    (and (listp (car cp)) (listp (cdr cp)))))

(defun tree-map2 (fn2 tree &optional (ancestor nil))
  "Maps FN over every atom in TREE." ;might change
  (cond
   ((null tree) nil)
   ((lolp tree) (funcall fn2 tree ancestor))
   ((assocp tree) (funcall fn2 tree ancestor))
   ((atom tree) (funcall fn2 tree ancestor))
   (t
    (cons
     (tree-map2 fn2 (car tree) tree)
     (tree-map2 fn2 (cdr tree) tree))))) 
 
(defun last- (l n)
    (let ((ln (len l)))
          (subseq l (- ln n) (len l)))) 

(defun tree-maps (fn tree &optional (stop nil))
  "Maps FN over every atom or..  in TREE."
  (cond
   ((null tree) nil)
   ((and stop (funcall stop tree)) (funcall fn tree))
   ((atom tree) ;(unless stop (funcall fn tree))
                )
   (t
    (cons
     (tree-maps fn (car tree) stop)
     (tree-maps fn (cdr tree) stop)))))  

;quickly check out a list
(defun plen (l) (if (stringp l) l (len l)))
(defun mplen (l) (mapcar #'plen l))
(defun mplen2 (l) (format t "~%~a" (plen l)) (mplen l)) 
;=added post start of SOC
;
;from: http://common-lisp.net/language.html
#+ignore
(defun explode (string &optional (delimiter #\Space))
  (let ((pos (position delimiter string)))
    (if (null pos)
        (list string)
        (cons (subseq string 0 pos)
              (explode (subseq string (1+ pos))
                       delimiter)))))

;http://xach.livejournal.com/316925.html
;defun :dot-every (count fun)
#+ignore
(defun dot-every (count fun)
  (let ((i 0))
    (lambda (&rest args)
      (when (< count (incf i))
        (setf i 0)
        (write-char #\. *trace-output*)
        (force-output *trace-output*))
      (apply fun args))))

