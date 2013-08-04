(lu)
;using http://sparql-wrapper.sourceforge.net/ for now ;try other examples that are working
; want something in lisp(try easy);but maybe twinql or https://github.com/dydra/dydra-cl
(defun mk-tr (ss)
  "send sparql str to tmp py file to run it"
 (let ((ta  "
#!/usr/bin/python
# -*- coding: utf-8 -*-
from SPARQLWrapper import SPARQLWrapper, JSON, XML, N3, RDF 
sparql = SPARQLWrapper(\"http://dbpedia.org/sparql\")
sparql.setQuery(\"\"\" 
               ")
       (tx "\"\"\")
sparql.setReturnFormat(XML)
results = sparql.query().convert()
print results.toxml() 
           ")
       (tj "\"\"\")
sparql.setReturnFormat(JSON)
results = sparql.query().convert()
for result in results[\"results\"][\"bindings\"]:
    print(result[\"label\"][\"value\"])
           ")
           )
               (with-open-file (strm "tr.py" :direction :output 
                                     :if-exists :overwrite
                                     :if-does-not-exist :create)
                 (format strm "~A" (str-cat ta ss tj)))))

(require :trivial-shell)
(defun tshell-command (str)
 (trivial-shell:shell-command (to-str str))) 

(require :s-xml)
(defun tshell-cmnd-sxml (str)
   (s-xml:parse-xml-string (tshell-command str)))
(trace tshell-cmnd-sxml)

(require :xmls)
(defun tshell-cmnd-xmls (str)
   (xmls:parse (tshell-command str)))
(trace tshell-cmnd-xmls)

(require :cl-json)
(defun tshell-cmnd-js (str)
   (cl-json:decode-json-from-string (tshell-command str)))
(trace tshell-cmnd-js)

;(defvar *i2* "sparql-query -np http://dbpedia.org/sparql < i2.txt")
;(defvar *ix* "python x.py")
;(defvar *ix* "rxpy")
;(trace tshell-command)

;defun t2 (&optional (str *ix*))
(defun t2 (&optional (qry-fn "i2.txt") (run-str "python tr.py"))
  "make sparql qry of dbpedia, and parse resulting xml into an s-exp"
  ;(tshell-command str)
  (mk-tr (read-file-to-string qry-fn))
 ;(tshell-cmnd-sxml run-str)
 ;(tshell-cmnd-xmls run-str)
  (tshell-cmnd-js run-str)
  )

;might skip py dependancy if possible
(defvar *t2* (t2))
;sparql parsing, for now
(defun len- (l) (typecase l
                 (list  (length l))
                 (string  l) ;(length l)
                 (symbol  l) ;(length (symbol-name l))
                 (array  (first (array-dimensions l))))) 
 
;(defpackage NS-0 (:use :cl) (:export '|binding| '|uri| '|result|))
#+ignore
(NS-0:|result| ;see if can skip the ns-0 part
 ((NS-0:|binding| :|name| "company")
  (NS-0:|uri| "http://dbpedia.org/resource/Borland"))
 ((NS-0:|binding| :|name| "product")
  (NS-0:|uri| "http://dbpedia.org/resource/C++Builder"))) 
#+ignore ;xmls seems more friendly
(("result" . "http://www.w3.org/2005/sparql-results#") NIL
   (("binding" . "http://www.w3.org/2005/sparql-results#") (("name" "label"))
    (("literal" . "http://www.w3.org/2005/sparql-results#") (("lang" "ca"))
     "Astúries"))) 

(defun explode-by-slash (s) (explode- s #\/)) 

(defun s-n (s) (if (symbolp s) (symbol-name s) s))
(defun first-eqs (l e)
    (when (listp l) (eq (s-n (first-lv l)) e)))
(defun t_p (l s) (when (first-eqs l s) (last_lv l)))
;(defun result_p (l) (t_p l 'NS-0:|results|))
;(defun uri_p (l) (t_p l 'NS-0:|uri|))
;(defun binding_p (l) (t_p l 'NS-0:|binding|))
(defun result_p (l) (t_p l "results"))
(defun uri_p (l) (t_p l "uri"))
(defun binding_p (l) (t_p l "binding"))

(defun prs-var-bind- (vbl)
  "((bnd .. varname) (uri url))->(varname url-end)"
 (let ((vb (if (result-p vbl) (rest vbl) vbl)))
  (let ((varname (last_lv (first vb)))
        (url (last_lv (second vb))))
    (cons (intern varname) (last_lv (explode-by-slash url)))))) 
(defun prs-var-bind (vbl)
  "((bnd .. varname) (uri url))->(varname url-end)"
 (let ((vb (result_p vbl))) (when vb
  (let ((varname (binding_p (first vb)))
        (url (uri_p (second vb))))
    (when (stringp url) (cons (intern varname) (last_lv (explode-by-slash url))))))))

(defun binds-from-result (rl)
  (mapcar #'prs-var-bind (rest rl)))

(trace result_p uri_p binding_p)
(trace binds-from-result prs-var-bind)
;got a nice binding list, but can get errs, 
; might be time to go2pattern lib/code2make sure get the types i want

;(defun tsp () (mapcar #'binds-from-result (rest (third *t2*))))
(defun tsp () 
  "test to get bindings alst from sparql returns"
  (binds-from-result (rest (third *t2*))))

;boud vars asserted to KM, in context of the original query; 
; so something like km-qry2 sparql would be cool here
