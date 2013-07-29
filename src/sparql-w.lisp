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
(trace tshell-command)

;defun t2 (&optional (str *ix*))
(defun t2 (&optional (qry-fn "i2.txt") (run-str "python tr.py"))
  "make sparql qry of dbpedia, and parse resulting xml into an s-exp"
  ;(tshell-command str)
  (mk-tr (read-file-to-string qry-fn))
  (tshell-cmnd-sxml run-str))
