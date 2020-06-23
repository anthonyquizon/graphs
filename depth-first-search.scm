(add-to-load-path ".")
(use-modules (ice-9 optargs)
             (utils))


;; REFERENCES: Algorithm Design Manual 2nd ed. Ch 5

(define (no-op _) '())


(define (node-value node) 
  (cond [(pair? node) (car node)]
        [else node]))

(define (node-children node) 
  (cond [(pair? node) (car (cdr node))]
        [else '()]))

(define* (dfs G
           #:key 
           [pre-process no-op] 
           [process-edge no-op] 
           [post-process no-op])
    (define visited (make-hash-table))

    (define (iter G) 
      (define value (node-value G))
      (define children (node-children G))

      (pre-process value)

      (when 
        (not (hashq-ref visited value))
        (hashq-set! visited value #t)

        (for-each 
          (lambda (child) 
            (process-edge value (node-value child))
            (iter child)) 
          children)

        (post-process value)))

    (iter G))

(define (find-cycles G)
    (define parents (make-hash-table))
    (define back-edges '())

    (define (process-edge a b)
      (define children (hashq-ref parents b '()))
      (displayln a b children)
      
      (cond [(member a children)
             (set! back-edges 
               (cons `(,a . ,b) back-edges))]
            [else
              (hashq-set! parents a (cons b children))]))

    (dfs G #:process-edge process-edge)

    back-edges)


(define A
  '(a (b c)))

(define B
  '(a (b 
       (c (a)))))

(define C
  '(a ((b (c))
       (c (d e f)))))

(check-equal (find-cycles A) '() "should return empty cycles list")
(check-equal (find-cycles B) '((c . a)) "should return single cycle")
(check-equal (find-cycles C) '((b . c)) "should return single cycle")

;(define A
  ;'(a (b c)))


;(define (pre-print-node node)
  ;(displayln "pre: " node))

;(define (print-edge a b)
  ;(displayln "edge:" a b))

;(begin 
    ;(define G
      ;'(a 
         ;((b (d a))
          ;(c (a)))))

    
    ;)

