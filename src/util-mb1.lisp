(cl:in-package :cl-kme) 
;
#+ignore
(defun km-seqp+ (s)  ;mv2 kmb/u2.lisp
  (km-seqp (list+ s)))
 ;====start of sys.lisp
#|
Copyright (c) 2000-2006, Sunil Mishra All rights reserved. for99lines
|# ;;; $Id: system-standalone.lisp 97 2006-08-31 06:00:10Z smishra $

(defvar *source-file-extensions*
  (list "lisp" "cl" "lsp"))
(defvar *compiled-file-extension*
  #.(pathname-type (compile-file-pathname "foo")))

(defun file-newer-p (file1 file2)
  (> (or (file-write-date file1) 0) (file-write-date file2)))

(defun find-file-with-type (pathname types
			    &optional (if-does-not-exist :error))
  (or (cond ((pathname-type pathname)
	     ;; Must be the full file path
	     (when (probe-file pathname)
	       pathname))
	    ((stringp types)
	     (let ((pathname (make-pathname :type types :defaults pathname)))
	       (when (probe-file pathname)
		 pathname)))
	    (t (dolist (source-type types)
		 (let ((pathname
			(make-pathname :type source-type :defaults pathname)))
		   (when (probe-file pathname)
		     (return pathname))))))
      (ecase if-does-not-exist
	((nil :soft) nil)
	(:error (error "Source file corresponding to ~S does not exist."
		       pathname)))))

#-allegro
(defun compile-file-if-needed (source fasl verbose verbose-supplied-p
			       print print-supplied-p external-format force)
  #+clisp (declare (ignore external-format))
  (when (or force
	    (not (probe-file fasl))
	    (and source (file-newer-p source fasl)))
    (loop
     (multiple-value-bind (output-truename warnings-p failure-p)
	 (compile-file source :output-file fasl
		       :verbose (if verbose-supplied-p
				    verbose
				  *compile-verbose*)
		       :print (if print-supplied-p
				  print
				*compile-print*)
		       #-clisp :external-format #-clisp external-format)
       (if (or failure-p (and warnings-p (eql *break-on-signals* t)))
	   ;; Todo: Also need a skip compilation restart.
	   (cerror "Retry compile." "Problems compiling ~S." source)
	 (return output-truename))))))

(defun compile-load (file &key (verbose nil verbose-supplied-p)
		     (print nil print-supplied-p) (if-does-not-exist :error)
		     (external-format :default) output-file force)
  "Compile a file if source newer, and load."
  (let* ((source (find-file-with-type (pathname file) *source-file-extensions*
				      nil))
	 (fasl (apply #'compile-file-pathname (or source file)
		      (when output-file
			`(:output-file ,output-file)))))
    (cond ((or source (probe-file fasl))
	   (let ((compile-result
		  #+allegro
		  (apply #'compile-file-if-needed source
			 `(,@(when verbose-supplied-p `(:verbose ,verbose))
			     ,@(when print-supplied-p `(:print ,print))
			     ,@(when output-file `(:output-file ,output-file))
			     :external-format ,external-format
			     :force-recompile ,force))
		  #-allegro
		  (compile-file-if-needed
		   source fasl verbose verbose-supplied-p print
		   print-supplied-p external-format force)))
	     (values
	      (load fasl :print (if print-supplied-p print *load-print*)
		    :verbose (if verbose-supplied-p verbose *load-verbose*)
		    :if-does-not-exist if-does-not-exist)
	      compile-result)))
	  (t
	   (case if-does-not-exist
	     (:error (error "Could not locate source or fasl for ~S." file))
	     ((nil :soft) nil))))))
;rest in: ai/sw/sf/public/mcpat/trunk/system-standalone.lisp
(defun al (l) ;from my lisp init
  "asdf load"
  (asdf:oos 'asdf:load-op l))
;---------------------
(defun collect-if (predicate sequence) 
  (when (full sequence)
    (remove-if-not predicate sequence)))
(defun collect-if-not (predicate sequence) 
  (when (full sequence)
    (remove-if predicate sequence)))

(defun collect-if-eq (to seq &key (key #'nop)) 
  (collect-if #'(lambda (it) (equal (funcall key it) to)) seq))

(defun collect (fnc lst) ;== remove-nils on mapcar
    (collect-if #'nop (mapcar fnc lst))) 
;(collect #'(lambda (n) (when (evenp n) n)) '(1 2 3 4 5 6 7 8)) ;(2 4 6 8)
;---------------------
;new
(defun lsp-p (f) 
  (member (pathname-type f) *source-file-extensions* :test #'equal))
(defun ls-lsp (&optional (d nil))
  (collect-if #'lsp-p (ls d)))
;(defun asd-p (f) (suffixp ".asd" f))
(defun asd-p (f) (equal "asd" (pathname-type f)))
(defun ls-asd (&optional (d nil))  
  (collect-if #'asd-p (ls d)))
(defun asd1 (&optional (d nil))
  "1st/smallest asd file in dir"
  (first-lv (sort (ls-asd d) #'len<))) 
;need2 str-cat the d in
(defun a1 (&optional (d nil)) 
  "get root/sym of smallest asd file in dir"
  (let ((as (asd1 d)))
    (when as (intern (car-lv (split-strs2at as "."))))))
(defun la1 () 
  "load most likely .asd file in this dir"
 ;(al (a1))
  (let ((a1 (a1)))
    (format t "~%(al '~a)" a1)
    (al a1)))
;-
;(load-bps) ;mine is much nicer
(defun c-load (f) (compile-load f))
;(trace c-load)
(defun load-lsp (&optional (dir "tools/bps/"))
 (let ((lf (ls-lsp dir)))
  (when (full lf)
    (mapcar #'c-load (mapcar #'(lambda (f) (strcat dir (pathname-name f))) lf)))))
;(setq *reasoner-loaded* t)
 ;====end of sys.lisp
;(in-package "LISA")
;util_mb.cl (in v3) =util-mb.cl + path.cl (from v2);  Written/Collected by bobak@computer.org
;use: adjoin/pushnew, SET-EXCLUSIVE-OR, SUBSETP, getf/plist
(defun subl> (a b) (subsetp b a))
;==> /Users/bobak/Documents/downloads/lang/lsp/ai/ut/mfkb/km/run/two/ut/path.cl <== 
;;; *****************************************************************************

(defun list-directory (dirname)
  "Return a list of the contents of the directory named by dirname.
Names of subdirectories will be returned in `directory normal
form'. Unlike CL:DIRECTORY, LIST-DIRECTORY does not accept
wildcard pathnames; `dirname' should simply be a pathname that
names a directory. It can be in either file or directory form."
  (when (wild-pathname-p dirname)
    (error "Can only list concrete directory names."))

  (let ((wildcard (directory-wildcard dirname)))

    #+(or sbcl cmu lispworks)
    ;; SBCL, CMUCL, and Lispworks return subdirectories in directory
    ;; form just the way we want.
    (directory wildcard)
    
    #+openmcl
    ;; OpenMCl by default doesn't return subdirectories at all. But
    ;; when prodded to do so with the special argument :directories,
    ;; it returns them in directory form.
    (directory wildcard :directories t)
            
    #+allegro
    ;; Allegro normally return directories in file form but we can
    ;; change that with the :directories-are-files argument.
    (directory wildcard :directories-are-files nil)
            
    #+clisp
    ;; CLISP has a particularly idiosyncratic view of things. But we
    ;; can bludgeon even it into doing what we want.
    (nconc 
     ;; CLISP won't list files without an extension when :type is
     ;; wild so we make a special wildcard for it.
     (directory wildcard)
     ;; And CLISP doesn't consider subdirectories to match unless
     ;; there is a :wild in the directory component.
     (directory (clisp-subdirectories-wildcard wildcard)))

    #-(or sbcl cmu lispworks openmcl allegro clisp)
    (error "list-directory not implemented")))


(defun file-exists-p (pathname)
  "Similar to CL:PROBE-FILE except it always returns directory names
in `directory normal form'. Returns truename which will be in
`directory form' if file named is, in fact, a directory."

  #+(or sbcl lispworks openmcl)
  ;; These implementations do "The Right Thing" as far as we are
  ;; concerned. They return a truename of the file or directory if it
  ;; exists and the truename of a directory is in directory normal
  ;; form.
  (probe-file pathname)

  #+(or allegro cmu)
  ;; These implementations accept the name of a directory in either
  ;; form and return the name in the form given. However the name of a
  ;; file must be given in file form. So we try first with a directory
  ;; name which will return NIL if either the file doesn't exist at
  ;; all or exists and is not a directory. Then we try with a file
  ;; form name.
  (or (probe-file (pathname-as-directory pathname))
      (probe-file pathname))

  #+clisp
  ;; Once again CLISP takes a particularly unforgiving approach,
  ;; signalling ERRORs at the slightest provocation.

  ;; pathname in file form and actually a file      -- (probe-file file)      ==> truename
  ;; pathname in file form and doesn't exist        -- (probe-file file)      ==> NIL
  ;; pathname in dir form and actually a directory  -- (probe-directory file) ==> truename
  ;; pathname in dir form and doesn't exist         -- (probe-directory file) ==> NIL

  ;; pathname in file form and actually a directory -- (probe-file file)      ==> ERROR
  ;; pathname in dir form and actually a file       -- (probe-directory file) ==> ERROR
  (or (ignore-errors
        ;; PROBE-FILE will return the truename if file exists and is a
        ;; file or NIL if it doesn't exist at all. If it exists but is
        ;; a directory PROBE-FILE will signal an error which we
        ;; ignore.
        (probe-file (pathname-as-file pathname)))
      (ignore-errors
        ;; PROBE-DIRECTORY returns T if the file exists and is a
        ;; directory or NIL if it doesn't exist at all. If it exists
        ;; but is a file, PROBE-DIRECTORY will signal an error.
        (let ((directory-form (pathname-as-directory pathname)))
          (when (ext:probe-directory directory-form)
            directory-form))))


    #-(or sbcl cmu lispworks openmcl allegro clisp)
    (error "list-directory not implemented"))

(defun no-such-file (fn)
  "maybe more readable"
  (not (file-exists-p fn)))

(defun directory-wildcard (dirname)
  (make-pathname 
   :name :wild
   :type #-clisp :wild #+clisp nil
   :defaults (pathname-as-directory dirname)))

#+clisp
(defun clisp-subdirectories-wildcard (wildcard)
  (make-pathname
   :directory (append (pathname-directory wildcard) (list :wild))
   :name nil
   :type nil
   :defaults wildcard))


(defun directory-pathname-p (p)
  "Is the given pathname the name of a directory? This function can
usefully be used to test whether a name returned by LIST-DIRECTORIES
or passed to the function in WALK-DIRECTORY is the name of a directory
in the file system since they always return names in `directory normal
form'."
  (flet ((component-present-p (value)
           (and value (not (eql value :unspecific)))))
    (and 
     (not (component-present-p (pathname-name p)))
     (not (component-present-p (pathname-type p)))
     p)))


(defun file-pathname-p (p)
  (unless (directory-pathname-p p) p))

;; (pathname-as-directory "foo")
#+sbcl ;otherwise think already defined
(defun pathname-as-directory (name)
  "Return a pathname reperesenting the given pathname in
`directory normal form', i.e. with all the name elements in the
directory component and NIL in the name and type components. Can
not be used on wild pathnames because there's not portable way to
convert wildcards in the name and type into a single directory
component. Returns its argument if name and type are both nil or
:unspecific."
  (let ((pathname (pathname name)))
    (when (wild-pathname-p pathname)
      (error "Can't reliably convert wild pathnames."))
    (if (not (directory-pathname-p name))
      (make-pathname 
       :directory (append (or (pathname-directory pathname) (list :relative))
                          (list (file-namestring pathname)))
       :name      nil
       :type      nil
       :defaults pathname)
      pathname)))

#+sbcl ;otherwise think already defined
(defun pathname-as-file (name)
  "Return a pathname reperesenting the given pathname in `file form',
i.e. with the name elements in the name and type component. Can't
convert wild pathnames because of problems mapping wild directory
component into name and type components. Returns its argument if
it is already in file form."
  (let ((pathname (pathname name)))
    (when (wild-pathname-p pathname)
      (error "Can't reliably convert wild pathnames."))
    (if (directory-pathname-p name)
      (let* ((directory (pathname-directory pathname))
             (name-and-type (pathname (first (last directory)))))
        (make-pathname 
         :directory (butlast directory)
         :name (pathname-name name-and-type)
         :type (pathname-type name-and-type)
         :defaults pathname))
      pathname)))

;; (walk-directory *logs-root* #'pprint :directories t :test #'directory-p)
(defun walk-directory (dirname fn &key directories (test (constantly t)))
  "Walk a directory invoking `fn' on each pathname found. If `test' is
supplied fn is invoked only on pathnames for which `test' returns
true. If `directories' is t invokes `test' and `fn' on directory
pathnames as well."
  (labels
      ((walk (name)
         (cond
           ((directory-pathname-p name)
            (when (and directories (funcall test name))
              (funcall fn name))
            (dolist (x (list-directory name)) (walk x)))
           ((funcall test name) (funcall fn name)))))
    (walk (pathname-as-directory dirname))))

(defun directory-p (name)
  "Is `name' the name of an existing directory."
  (let ((truename (file-exists-p name)))
    (and truename (directory-pathname-p name))))

(defun file-p (name)
  "Is `name' the name of an existing file, i.e. not a directory."
  (let ((truename (file-exists-p name)))
    (and truename (file-pathname-p name))))

;"home/local/bank-a-trail/code/web-access/elf-database3a.lisp" 1610 lines --64%--    
;
(defun pathname-lessp (pathname1 pathname2)
  (string-lessp (princ-to-string pathname1)
                (princ-to-string pathname2)))
 

(defun subdirs-of (dirname &key recursive-p)
  (loop
      for pathname in (list-directory dirname)
      when (directory-p pathname)
      collect pathname
      into subdirs
      finally
        (return
          (if subdirs
            (if recursive-p
                (cons dirname
                      (loop for subdir in (sort subdirs #'pathname-lessp)
                          collect (let ((sub-subdirs
                                         (subdirs-of subdir
                                                     :recursive-p recursive-p)))
                                    (if sub-subdirs
                                        (list subdir sub-subdirs)
                                      subdir))))
              (sort subdirs #'pathname-lessp))
            (sort subdirs #'pathname-lessp)))))

(defvar *logs-root* "")
(defun recursive-dirs (&optional (base-dir *logs-root*))
  (let (pathnames)
    (flet ((push-dir (dir)
             (push dir pathnames)))
      (walk-directory base-dir #'push-dir
                      :directories t
                      :test #'directory-p)
      (sort pathnames #'pathname-lessp)
      )))
;-http://www.koders.com/lisp/fidFB7070D914D164945DCC6128CF2A5307A8C34731.aspx?s=common#L1
(defmacro in-directory ((dir) &body body)
    `(progn 
            (#+sbcl sb-posix:chdir #+cmu unix:unix-chdir #+openmcl ccl:cwd
	     #+allegro excl:chdir #+lispworks hcl:change-directory ,dir)
	         ,@body))
(defun launch-background-program (directory program &key (args nil))
  "Launch a program in a specified directory - not all shell interfaces
   or OS's support this"
  #+(and allegro (not mswindows))
  (multiple-value-bind (in out pid)
      (excl:run-shell-command (concat-separated-strings " " (list program) args)
			      :wait nil
			      :directory directory)
    (declare (ignore in out))
    pid)
  #+(and sbcl unix)
  (in-directory (directory)
    (sb-ext:run-program program args :wait nil))
  #+cmu 
  (in-directory (directory)
      (ext:run-program program args :wait nil))
  #+openmcl
  (in-directory (directory)
    (ccl:run-program program args :wait nil))
  #+lispworks
  (funcall #'sys::call-system
	 (format nil "~a~{ '~a'~} &" program args)
	 :current-directory directory
	 :wait nil)
  ) 
(defun kill-background-program (process-handle)
  #+(and allegro (not mswindows))
  (progn (excl.osi:kill process-handle 9)
	 (system:reap-os-subprocess :pid process-handle))
  #+(and sbcl unix)
  (sb-ext:process-kill process-handle 9)
  #+openmcl
  (ccl:signal-external-process process-handle 9) )
;-
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
;defun ls (&optional d) 
#+sbcl (defun cd (path) (sb-posix:chdir path)) 
(defun ls (&optional (d nil)) 
 (break2lines
  (if (stringp d) (run-ext "ls" d)
    (run-ext "ls"))))
;==start=
;(defun head (l) (subseq l 0 4))
;(defun head (l &optional (n 4)) (subseq l 0 n))
(defun head (l &optional (n 4)) (subseq l 0 (min n (len l))))
;(defun tail (l) (last l 4))
;(defun tail (l &optional (n 4)) (last l n))
(defun tail (l &optional (n 4)) (last l (min n (len l))))
(defun last3 (l) (last l 3)) 
;==> /Users/bobak/Documents/downloads/lang/lsp/ai/ut/mfkb/km/run/two/ut/util-mb.cl <==
;utils collected/written by m.bobak
;sb- specific now, might do it w/o; &/or if want acl specific subsys like agraph, just load km/triple
;(require :sb-posix)
;-gen utils now
(defvar *dbg-ut* nil)
;from ch.cl
(defun numbers (n) ;clips/py has a more general one
  (if (eq n 1) (list 1)  ;can use phrNum from tsp.cl this time
    (append (numbers (- n 1)) (list n))))
;from csv.lsp
#+mycsv
(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (fboundp 'parse-number)
    (defun parse-number (s)
      (with-standard-io-syntax ()
        (let* ((*read-eval* nil)
               (*read-default-float-format* 'double-float)
               (n (read-from-string s)))
          (if (numberp n) n))))))  
;tsp.cl
;(defun remove-nils (l) (remove-if #'null l)) 
;(defun nth+ (ns ls)
