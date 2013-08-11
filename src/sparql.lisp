;https://github.com/daimrod/dbpedia-sparql.git
;(in-package #:dbpedia-sparql)

(defparameter *http-proxy-server* nil)  ; hostname only! no http://
(defparameter *http-proxy-port* 80)

;defun send-query (query)
(defun send-query (query &optional (where "http://dbpedia.org/sparql"))
  (drakma:http-request where ;"http://dbpedia.org/sparql"
                       :method :get
                       :parameters
                       (list (cons "query" query)
                             (cons "format" "json"))
                       :proxy (unless (null *http-proxy-server*)
                                (list *http-proxy-server*
                                      *http-proxy-port*))))

(defun json->list (json)
  (json:decode-json-from-string json))

(defun upper-case (string)
  (map 'string #'char-upcase string))

(defun url-end (s) (last_lv (explode-by-slash s)))
(defun url-end2 (s) (last (explode-by-slash s) 2))

(defun make-better-list (results)
  (let (titles)
    (cons
     (setf titles
           (loop :for title :in (alexandria:assoc-value (alexandria:assoc-value results :HEAD)
                                             :VARS)
                 :collect title))
     (loop :for line :in (alexandria:assoc-value (alexandria:assoc-value results :RESULTS)
                                      :BINDINGS)
           :collect
           (loop :for title :in titles
                 :collect (alexandria:assoc-value (alexandria:assoc-value line
                                                    (intern
                                                     (upper-case title)
                                                     :keyword))
                                       :VALUE))))))

(defun query->list (query)
  (multiple-value-bind (ret code)
      (send-query query)
    (case code
      (200 (make-better-list
            (json->list
             (babel:octets-to-string ret))))
      (t ret))))
 
(defun sparql2lst (query)
  (let ((r (query->list query)))
    (when (listp r)
      (mapcar #'(lambda (tri) (mapcar #'url-end2 tri)) r))))
