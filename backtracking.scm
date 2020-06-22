(add-to-load-path ".")
(use-modules (ice-9 optargs))

(define (no-op-bool _) #f)
(define (no-op _) '())

(define* 
  (backtrack init-state
             #:key 
             [max-depth 10000]
             [is-solution no-op-bool]
             [process-solution no-op]
             [construct-candidates no-op])
  (define (iter state i)
    (cond [(is-solution state)
           (process-solution state i input)]
          [(< i max-depth)
           (define i^ (+ i 1))
           (define candidates (construct-candidates state i^))

           (for-each 
             (lambda (candiate))
             candidates
             )
           ]
            
          ))

  (iter init-state))
