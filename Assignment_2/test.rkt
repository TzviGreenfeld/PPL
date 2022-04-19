;; pair of string 'ok' and value
(define make-ok
  (lambda (val)
    (cons "Ok" val)
  )
 )
 
;; pair based on makeFailure
(define make-error
  (lambda (msg)
    (cons "Failure" msg)
  )
 )

;; returns true if res is pair and the first item of a given pair is the string "ok"
(define ok?
  (lambda (res)
    (if (pair? res)
     (equal? (car res) "Ok" )
     )
  )
 )


;; same as ok but the string is "Failure"
(define error?
  (lambda (res)
    (if (pair? res)
     (equal? (car res) "Failure" )
     )
  )
 )

;; true if res is ok or error
(define result?
  (lambda (res)
    (or (ok? res) (error? res))
  )
 )


(define result->val
  (lambda (res)
    (if (result? res)
     (cdr res)
     )
  )
)

;; f: <non_result> --> <result>\
;; bind should return a function that accepts result as parameter

(define bind 
  (lambda (f)
    (lambda (res)
    (if (ok? res)
      (f (cdr res))
      (make-error (cdr res)))
    )
  )
)

;; cons is couple constructor
;; car = p[0]
;; cdr =  p[1]
(define make-dict
  (lambda ()
    (list ())
  )
)

;; recursive test, true if evry item in the list is dictionary

(define dict?
  (lambda (e)
    (if (empty? e) 
      #t                        ;; vacuous true
      (if (pair? e)             ;; else, first item is in the structure of dict
          (if (pair? (car e))
            (dict? (cdr e))     ;; if so, continue to test the next "chain" in the dictionary
            #f                  ;; not key: val
          )
        #f                      ;; not empty and not in dictionary structure
      )
  )
)


(define get
  (lambda (dict k)
    (if (dict? dict)
      (if (empty? dict)
        (make-error "empty dictionary")
        (if (equal? (car (car dict)) k) ;; found key
          (make-ok (cdr (car dict))) ;; val
          (get (cdr dict) k) ;; keep looking
        )
      )
      make-error(("not dictionary")
    )
  )
)



;; add
(define put
  (lambda (dict k v)
    (let 
      (toAdd (cons k v))
    )
    (if (dict? dict)
      (if (empty? dict)
        (make-ok (cons toAdd make-dict)) ;; TODO: test this line
        (if (error? (get (dict k))) 
        (make-error );; the key exists
        )
        (make-ok (cons toAdd (cdr dict))) ;; all good
      )
      (make-error("not dictionary"))                       
    )
  )
)


(define map-dict
  (lambda (dict f)
    @TODO
  )
)

(define filter-dict
  (lambda (dict pred)
    @TODO
  )
)
