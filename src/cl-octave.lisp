;;;http://www.cliki.net/cl-octave w/tiny edits from bobak@balisp.org
;;;  so I can run http://web.warwick.ac.uk/PODES/ or similar
;;;  though it might be easier to go through R or Sage
;;;
;;;; cl-octave.lisp -- Interface with octave from Common Lisp
;;;; version 0.1

;;;# Prelude
;;; Copyright (c) 2005, Frederic Nicolier
;;; All rights reserved.

;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions
;;; are met:
;;; * Redistributions of source code must retain the above copyright
;;; notice, this list of conditions and the following disclaimer.
;;; * Redistributions in binary form must reproduce the above copyright
;;;notice, this list of conditions and the following disclaimer in the
;;;documentation and/or other materials provided with the distribution.
;;; * Neither the name of the Champagne-Ardenne University nor the
;;; names of its contributors may be used to endorse or promote
;;; products derived from this software without specific prior written
;;; permission.

;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
;;; FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
;;; COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
;;; INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
;;; STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
;;; OF THE POSSIBILITY OF SUCH DAMAGE.

;;; Contact: Fred Nicolier
;;;          Dept Ge2i, IUT
;;;          9 rue de Quebec
;;;          10026 Troyes Cedex
;;; email:   f.nicolier(At)iut-troyes.univ-reims.fr
;;; 

;;;# Introduction
;;;
;;; The aim of this package is to provide an interface to the octave
;;; programming language. This language (and matlab) is widely used in
;;; signal/image processing tasks. The main reason (imho) is the
;;; presence of lots and useful toolboxes that prepacks the base
;;; functions. In particular (in image processing), it is easy to
;;; read/write image files and to display on screen.
;;;
;;; A more personnal reason is that i want to switch from octave to
;;; lisp and i have a lot of octave code written during my thesis. And
;;; i'm to lazy to rewrite all that code.
;;;
;;; A adaptation to matlab would be straighforward. A single change in
;;; function 'start-octave' would do the stuff. To be done when matlab
;;; will be repaired in my FreeBSD box.
;;;
;;; The code actually runs only with cmucl.

;;;# Package Definition

(in-package :common-lisp-user)

(defpackage :cl-octave
  (:use :common-lisp
        ;:extensions :system
        :sb-ext :sb-sys
        )
  (:export :start-octave
           :stop-octave
           :set/octave
           :get/octave
           :eval/octave
           :funcall/octave
           :exec/octave
           :map/array))

(in-package :cl-octave)

;;;# 'Low-level' functions

;;;## Start and stop engine

(defvar *octave-process* nil)

(defun start-octave ()
  "Start an octave engine. If an engine is ever started, do
nothing. CMUCL specific."
  (when (not *octave-process*)
        (sb-ext:run-program "mkfifo" '("cl2o.dat" "o2cl.dat")) ;;was commented out
    ;#+cmu
    (setf *octave-process* (sb-ext:run-program "octave" '("-qi")
                                            :wait nil
                                            :input :stream
                                            :output :stream
                                            :error :stream))
    (send "PS1=\"\";disp('ok');")
    (receive)))

(defun stop-octave ()
  "Stop the octave engine. If no engine is started, do nothing. CMUCL
specific."
  (when *octave-process*
    (process-close *octave-process*)
    (setf *octave-process* nil)
    ;#+cmu
    (sb-ext:run-program "rm" '("-f" "cl2o.dat" "o2cl.dat") :search t)))

;;;## Send and receive raw strings

(defun send (str)
  "Send a string to octave."
     (let ((in (process-input *octave-process*)))
       (write-line str in)
       (force-output in)))

(defun receive ()
  "Read a line from octave. Can be blocking if no line is available."
     (read-line (process-output *octave-process*)))

;;;# Send structures

(defgeneric set/octave (name val)
  (:documentation "Affect some data to a variable in octave. Ok for
numbers, strings, single and double float 1d and 2d array. Ok with
complex numbers"))

;;; A number is send as a string.
(defmethod set/octave (name (val number))
  (start-octave)
  (if (complexp val)
      (progn 
        (set/octave "_re" (realpart val))
        (set/octave "_imag" (imagpart val))
        (eval/octave name "=_re+i*_imag;"))
      (send (string-cat name "=" (princ-to-string val) ";"))))

;;; A string is send as a string ;o)
(defmethod set/octave (name (str string))
 (start-octave)
 (send (string-cat name "='" str "';")))

;;; An array is send via the file 'cl2o.dat'. The file is writtten
;;; using a raw call to unix fread with cmucl specific code. The file
;;; is read in octave using fread.
(defmethod set/octave (name (a array))
  (start-octave)
  (let* ((elt-type (type-of (row-major-aref a 0)))
         (flat-a (make-array (array-total-size a)
                             :displaced-to a
                            ;:element-type elt-type
                             ))
         (dims (array-dimensions a)))           
    (destructuring-bind (oct-fmt lisp-nb-bytes)
        (if (eql elt-type 'double-float)
            (list "float64" 8)
            (list "float32" 4))
      (destructuring-bind (dimr dimc)
          (if (not (second dims))
              (list 1 (first dims))
              (list (first dims) (second dims))) ; TODO : use bind macro ?
        (if (complexp (row-major-aref a 0)) 
            (progn
              (set/octave "_real" (map/array #'realpart flat-a))
              (set/octave "_imag" (map/array #'imagpart flat-a))
              (eval/octave name "=_real+i*_imag;"))
            (with-open-file (f "cl2o.dat" :direction :output :if-exists :supersede)
              ;#+cmu
              (sb-unix:unix-write (sb-sys:fd-stream-fd f)
                               (sb-sys:vector-sap (coerce flat-a `(simple-array ,elt-type (*))))
                               0
                               (* lisp-nb-bytes (length flat-a)))
              (eval/octave "f=fopen('cl2o.dat');"
                           name "=fread(f,[" (princ-to-string dimr)
                           " " (princ-to-string dimc)
                           "],'" oct-fmt "');"
                           "fclose(f);")))))))

;;;# Receive structures

;;;## Some specific not exported functions.

(defun get-as-array (name &key (element-type 'single-float))
  (destructuring-bind (oct-fmt lisp-nb-bytes)
      (if (eql element-type 'double-float)
          '("float64" 8)
          '("float32" 4))
    (eval/octave "f=fopen('o2cl.dat','w+');"
                 "fwrite(f," name ", '" oct-fmt "');"
                 "fclose(f);")
    (with-open-file (f "o2cl.dat" :direction :input :if-exists :supersede)
      (let* ((length (round (get-as-number (string-cat "prod(size(" name "))"))))
             (result (make-array length :element-type element-type)))
        (sb-unix:unix-read (sb-sys:fd-stream-fd f)
                        (sb-sys:vector-sap result)
                        (* lisp-nb-bytes length))
        result))))

(defun get-reshaped-array (name &key (element-type 'single-float))
  (let ((nb-rows (round (get-as-number (string-cat "size(" name ",1)"))))
        (nb-cols (round (get-as-number (string-cat "size(" name ",2)")))))
    (make-array (if (= 1 nb-rows)
                    nb-cols
                    (list nb-rows nb-cols))
                :element-type element-type
                :displaced-to (get-as-array name :element-type element-type))))

(defun get-as-number (name &key (element-type 'single-float))
  (send (string-cat "printf(\"\%f\", " name ");"
                    "printf(\"\\n\");"
                    "disp(\"end\");"))
  ;coerce (read-from-string (first (loop for line = (receive)
  (coerce (read-from-string
		   #+darwin (first (loop for line = (receive)
					 while (string/= line "end")
					 collect line))
		   #-darwin (find-number-string-from-end
			(first (loop for line = (receive)
					  while (string/= line "end")
					  collect line)))) 
      ;                                  while (string/= line "end")
      ;                                  collect line)))
          element-type))

(defun get-as-complex (name &key (element-type 'single-float))
  (complex (get-as-number (string-cat "real(" name ")") :element-type element-type)
           (get-as-number (string-cat "imag(" name ")") :element-type element-type)))

(defun get-as-string (name)
  (send (string-cat "printf(\"\%s\", " name ");"
                         "printf(\"\\n\");"
                         "disp(\"end\");"))
  (first (loop for line = (receive)
               while (string/= line "end")
               collect line)))

(defun raw-numfunc (name)
  (send (string-cat "_out=" name ";"))
  (get-as-number "_out"))

;;;## The exported function.

(defun get/octave (name &key (element-type 'single-float))
  "Get the value(s) of an octave variable. The result can be a number
or an array. Ok with complex numbers."
  (start-octave)
  (let ((oct-complex-p (= 1.0 (raw-numfunc (string-cat "is_complex(" name ")"))))
        (oct-scalar-p (= 1.0 (raw-numfunc (string-cat "is_scalar(" name ")"))))
        (oct-string-p (= 1.0 (raw-numfunc (string-cat "isstr(" name ")")))))
    (cond (oct-scalar-p (if oct-complex-p
                            (get-as-complex name :element-type element-type)
                            (get-as-number name :element-type element-type)))
          (oct-string-p (get-as-string name))
          (t (if oct-complex-p
                 (let ((reals (get-as-array (string-cat "real(" name ")")))
                       (imags (get-as-array (string-cat "imag(" name ")"))))
                   (map/array #'complex reals imags))
                 (get-reshaped-array name :element-type element-type))))))
  
;;;# Eval some strings in octave and get the result (ans).

(defun eval/octave (&rest todo)
  "Eval some instruction is octave. ans is returned."
  (start-octave)
  (set/octave "ans" 0)
  (send (apply #'concatenate 'string todo))
  (get/octave "ans"))

;;;# Funcalling an octave function on args

(defun funcall/octave (fun &rest rest)
    "Call a function in Octave. `fun' is the function name (a
string). `args' is the list of input arguments. The optional
`:nargout' keyword is the number of output values (if nargout>1 the
values are returned with the values function)."
  (let ((args (loop for (key value) on rest by #'cddr
                    unless (member key '(:nargout))
                    append `(,key ,value))))
    (let ((part-of-rest (member ':nargout rest)))
        (if part-of-rest
            (funcall/octave* fun (cadr part-of-rest) (remove nil args))
            (funcall/octave* fun 1 (remove nil args))))))


(defun funcall/octave* (fun nargout args)
  (start-octave)
  (let ((in-names (loop for i from 1 upto (length args)
                        collect (string-cat "_in"
                                            (princ-to-string i))))
        (out-names (loop for i from 1 upto nargout
                         collect (string-cat "_out"
                                             (princ-to-string i)))))
    (mapcar #'set/octave in-names args)
    (let ((out-string (if (= 1 nargout)
                          "_out1"
                          (format nil "[~{~a~^, ~}]" out-names ))))
      (if (= 0 nargout)
          (send (format nil "~a(~{~a~^, ~});" fun in-names))
          (progn 
            (send (format nil "~a = ~a(~{~a~^, ~});" out-string fun in-names))
            (apply #'values (mapcar #'get/octave out-names)))))))

(defun exec/octave (fun &rest args)
  (apply #'funcall/octave fun :nargout 0 args))

;;;# Tests
(defun tests ()
  (mapcar #'pprint (list (set/octave "a" 1)
                         (get/octave "a")
                         (set/octave "b" #(1.0 2.0 3.0))
                         (get/octave "b")
                         (funcall/octave "conv" #(1.0 2.0 3.0 2.0 1.0) #(-1.0 1.0))
                         (exec/octave "plot" #(1.0 2.0 3.0 2.0 -10.0))
                         (multiple-value-list (funcall/octave "cart2pol" 1 1 :nargout 2)))))

;;;# Useful Stuffs
(defun map/array (f &rest args)
  (let* ((a (first args))
         (r (make-array (array-dimensions a))))
    (dotimes (i (array-total-size a))
      (setf (row-major-aref r i)
            (apply f (mapcar (lambda (ar) (row-major-aref ar i))
                             args))))
    r))

(defun string-cat (&rest args)
     (apply #'concatenate 'string args))

;; Local Variables:
;; pbook-author: "Fred Nicolier"
;; pbbok-use-toc: t
;; pbook-style: article
;; End:

(defun find-number-string-from-end (string)
  ;; FIXME: this is a quick hack based on the return string from octave in Mac OSX. Its behavior is somehow different to octave on linux
  ;; I don't know whether '>' can be a legal output
  ;; if so ,then this function needs modification.
  ;; So far, it serves me well on SBCL + Mac OSX
  (subseq string (1+ (position #\> string :from-end t)))) 

(trace send receive find-number-string-from-end )
