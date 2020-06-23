(define-module (utils)
    #:export (check-equal check-set-equal displayln))

(use-modules (ice-9 optargs)
             (srfi srfi-1))

(define (displayln . args)
  (define (display-value val)
    (display val)
    (display " "))

  (for-each display-value args)

  (display "\n"))

(define (print-failure a b args)
  (define name 
    (if (eq? (length args) 0)
        "Not equal"
        (car args)))

    (displayln "=====")
    (displayln "Test failed:" name)   
    (displayln "left:" a)    
    (displayln "right:" b)
    (displayln "=====")  )

(define (check-equal a b . args)
  (when (not (equal? a b))
    (print-failure a b args)))

(define (check-set-equal a b . args)
  (when (not (lset= equal? a b))
    (print-failure a b args)))

