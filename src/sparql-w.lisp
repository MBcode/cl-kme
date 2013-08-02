(lu)
(defun mk-tr (ss)
  "send sparql str to tmp py file to run it"
 (let ((ta  "
#!/usr/bin/python
# -*- coding: utf-8 -*-
from SPARQLWrapper import SPARQLWrapper, JSON, XML, N3, RDF 
sparql = SPARQLWrapper(\"http://dbpedia.org/sparql\")
sparql.setQuery(\"\"\" 
               ")
       (tb "\"\"\")
sparql.setReturnFormat(XML)
results = sparql.query().convert()
print results.toxml() 
           "))
               (with-open-file (strm "tr.py" :direction :output 
                                     :if-exists :overwrite
                                     :if-does-not-exist :create)
                 (format strm "~A" (str-cat ta ss tb)))))

(require :trivial-shell)
(require :s-xml)
(defun tshell-command (str)
 (trivial-shell:shell-command (to-str str))) 

(defun tshell-cmnd-sxml (str)
   (s-xml:parse-xml-string (tshell-command str)))

;(defvar *i2* "sparql-query -np http://dbpedia.org/sparql < i2.txt")
;(defvar *ix* "python x.py")
;(defvar *ix* "rxpy")
;(trace tshell-command)
(trace tshell-cmnd-sxml)

;defun t2 (&optional (str *ix*))
(defun t2 (&optional (qry-fn "i2.txt") (run-str "python tr.py"))
  "make sparql qry of dbpedia, and parse resulting xml into an s-exp"
  ;(tshell-command str)
  (mk-tr (read-file-to-string qry-fn))
  (tshell-cmnd-sxml run-str))

(defvar *t2* (t2))
;sparql parsing, for now
(defun len- (l) (typecase l
                 (list  (length l))
                 (string  l) ;(length l)
                 (symbol  l) ;(length (symbol-name l))
                 (array  (first (array-dimensions l))))) 
#+ignore
(NS-0:|result|
 ((NS-0:|binding| :|name| "company")
  (NS-0:|uri| "http://dbpedia.org/resource/Borland"))
 ((NS-0:|binding| :|name| "product")
  (NS-0:|uri| "http://dbpedia.org/resource/C++Builder"))) 

(defun explode-by-slash (s) (explode- s #\/)) 

(defun prs-var-bind (vbl)
  "((bnd .. varname) (uri url))->(varname url-end)"
 (let ((vb (if (first-eq vbl 'NS-0:|results|) (rest vbl) vbl)))
  (let ((varname (last_lv (first vb)))
        (url (last_lv (second vb))))
    (cons (intern varname) (last_lv (explode-by-slash url)))))) 

(defun binds-from-result (rl)
  (mapcar #'prs-var-bind (rest rl)))

(trace binds-from-result prs-var-bind)
;got a nice binding list, but can get errs, 
; might be time to go2pattern lib/code2make sure get the types i want

;(defun tsp () (mapcar #'binds-from-result (rest (third *t2*))))
(defun tsp () 
  "test to get bindings alst from sparql returns"
  (binds-from-result (rest (third *t2*))))

;boud vars asserted to KM, in context of the original query; 
; so something like km-qry2 sparql would be cool here
