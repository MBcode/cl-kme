(cl:in-package :cl-kme)
;code that came w/KM components lib
(defun load-lib (&optional (comp-path "./components/"))
  (let (result)
    (dolist (component (traverse-directory comp-path) result)
      (cond 
        ((equal (pathname-type component) "km") 
         (load-kb component)
         (setf result (cons (pathname-name component) result)))
        ((equal (pathname-type component) "lisp")
         (load component))))))

(defun traverse-directory (root-dir-path)
  (let ((dir-list (directory root-dir-path)) sub-dir-path result)
    (dolist (element dir-list result)
      (if (directory (setf sub-dir-path (concatenate 'string root-dir-path (pathname-name element) "/"
)))
          (setf result (append (traverse-directory sub-dir-path) result))
          (setf result (cons element result))))))
 
