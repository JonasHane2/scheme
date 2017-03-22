(define functions (make-table))

(define (mem msg val)
  (define (memoize f)
    (let ((table (make-table)))
          (lambda x 
            (let ((previously-computed-result
                   (lookup x table))) 
              (or previously-computed-result 
                  (let ((result (apply f x))) 
                    (insert! x result table) 
                    result))))))
  (cond 
    ((equal? msg 'memoize)
     (let ((original val) (new (memoize val)))
       (insert! new original functions) new))   
    ((equal? msg 'unmemoize)
     (or (lookup val functions) val))))