;I will be using the I/O mostly from the ML packages I'm looking at, &maybe cl-arff-parser
;bobak@balisp.org
(in-package :cl-kme) ;:use 'common-lisp
(defvar *train* "train") ;can pull from the name of the input file
(print *package*)
;last used read csv to clean up some kaggle data
(defvar *h* ;read&construct this instead of hard-coding
  '(classified 
     outlook temp humidity wind))
;or, not great, but shell useful later
(defun rm-newline (str) (remove #\newline str))

;(require :trivial-shell)
(require :cl-csv)

(defun tshell-command (str)
   (trivial-shell:shell-command (to-str str)))

(defun h1 (fn) (rm-newline (tshell-command (str-cat "head -1 " fn))))

(defun read-data-csv (&optional (file #p"train.csv"))
  ;try2get info from skip-first, but can peek at it, for now:
 (let* ((h1s (h1 (file-namestring file)))
        (hl (if (stringp h1s) (mapcar- #'intern (coerce (csv-parse-string h1s) 'list))
              *h*)))
   (format t "~%fn=~a,hl=~a" h1s hl)
   (cl-csv:read-csv file ;(str-cat "data/" file ".csv") 
                   :skip-first-p t
         :map-fn #'(lambda (l)
                     (let* ((name-str (symbol-name (gentemp *train*)))
                            ;(name-str (clean_se (third l)))
                            (name (k_i (under_ name-str)))
                            )
                        ;(sv-al name (mkalst-n *h* l 4))
                        (sv-al name (mkhl hl l))
                        ;(sv-cls name (fourth l)) 
                        (sv-cls name "data") 
                        )))))
