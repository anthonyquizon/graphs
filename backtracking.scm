(add-to-load-path ".")
(use-modules (ice-9 optargs)
             (srfi srfi-1)
             (utils))

(define (no-op-bool _state _i) #t)
(define (no-op _state _i) '())

(define* 
  (backtrack init-state
             #:key 
             [solution? no-op-bool]
             [continue? no-op-bool]
             [process-solution no-op]
             [construct-candidates no-op])
  (define (iter state i)
    (cond [(solution? state i)
           (process-solution state i)]
          [(continue? state i)
           (for-each 
             (lambda (candidate)
               (iter (cons candidate state) (+ i 1)))
             (construct-candidates state i))
           ]))

  (iter init-state 0))


;(define# (iterative-backtrack 
           ;G
           ;#:key 
           ;[max-depth 10000]
           ;[is-solution no-op-bool]
           ;[process-solution no-op]
           ;[construct-candidates no-op]) 
    ;(define stack '())
  
    ;(while 
      ;()
      ;)
  ;)

(define (generate-subsets n)
  (define init-state '())
  (define solutions '())

  (define (solution? state i) (equal? i n))
  (define (construct-candidates state i) `((,i . #t) (,i . #f)))
  (define (process-solution state i) 
    (define solution 
      (fold (lambda (x acc)
              (if (equal? (cdr x) #t)
                  (cons (car x) acc)
                  acc))
            '() state)) 

    (set!
      solutions
      (cons solution solutions)))

  (backtrack init-state
             #:solution? solution?
             #:process-solution process-solution
             #:construct-candidates construct-candidates)
  solutions)

(check-set-equal 
  (generate-subsets 3) 
  '(() (0) (0 1) (0 1 2) (1 2) (0 2) (2) (1)))
