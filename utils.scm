(define-module (utils)
    #:export (check-equal displayln))

(use-modules (ice-9 optargs))

(define (displayln . args)
  (define (display-value val)
    (display val)
    (display " "))

  (for-each display-value args)

  (display "\n"))

(define (check-equal a b . args)
  (define name 
    (if (eq? (length args) 0)
        "Not equal"
        (car args)))

  (when (not (equal? a b))
    (displayln "left:" a)    
    (displayln "right:" b)    
    (raise (string-append "Test failed: " name))))

