; recursion play

; build from '() after reaching the end of the list
(define (doubleIt theList)
  (if (null? theList) '()
      (append (list (* 2 (car theList))) (doubleIt (cdr theList)))))

; This option uses two parameters, builds result as recursive calls are made
; Result is simply returned when the end of input is reached
(define dblIt
  (lambda (input result)
    (cond ((and (null? input) (null? result)) #f)
          ; see if done with input
          ((null? input) result)
          ; see if car is even
          (else
           (dblIt (cdr input) (append result (list (* 2 (car input)))))))))

(define traceDblIt
  (lambda (input result)
    (display "parameter theList ")
    (display input)
    (display "\nparameter: accumulated result")
    (display result)
    (newline)
    (cond ((and (null? input) (null? result)) #f)
          ; see if done with input
          ((null? input) 
           (begin
             (display "returning result ")
             result))
          ; see if car is even
          (else
           (traceDblIt (cdr input) (append result (list (* 2 (car input)))))))))

(define (traceDoubleIt theList)
  (display "parameter theList ")
  (display theList)
  (newline)
  (if (null? theList) '()
      (let ((partialResult (traceDoubleIt (cdr theList)))
            (myContribution (list (* 2 (car theList)))))
            (begin
              (display "appending doubled item ")
              (display myContribution)
              (display " to the return of ")
              (display partialResult)
              (display #\newline)
              (append (list (* 2 (car theList))) partialResult))
        )))

      ;(append (list (* 2 (car theList))) (traceDoubleIt (cdr theList)))))

(display "demo of recursion\n")
(display "calling DoubleIt on '(2 3 5)\n")
(traceDoubleIt '(2 3 5))
(display #\newline)
(display "calling DblIt on '(2 3 5)\n")
(traceDblIt '(2 3 5) '())
