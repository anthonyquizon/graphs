(use-modules (ice-9 optargs))

(define (no-op _) '())

(define (displayln . args)
  (define (display-value val)
    (display val)
    (display " "))

  (for-each display-value args)

  (display "\n"))

(define* (dfs graph
           #:key 
           [pre-process no-op] 
           [process-edge no-op] 
           [post-process no-op])
    (define visited (make-hash-table))

    (define (node-value node) 
      (cond [(pair? node) (car node)]
            [else node]))

    (define (node-children node) 
      (cond [(pair? node) (car (cdr node))]
            [else '()]))

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

    (iter graph))


(define A
  '(a (b c)))

(define B
  '(a 
     ((b (d a))
      (c (a)))))

(define (pre-print-node node)
  (displayln "pre: " node))

(define (print-edge a b)
  (displayln "edge:" a b))

;(dfs A 
     ;#:pre-process print-node
     ;#:process-edge print-edge)

(dfs B 
     #:pre-process pre-print-node
     #:process-edge print-edge)
