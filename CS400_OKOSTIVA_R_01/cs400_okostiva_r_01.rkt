(define (containsAnywhere elementToFind inList)
  (cond ((null? inList) #f)
        ((list? inList) (or (containsAnywhere elementToFind (first inList))
                             (containsAnywhere elementToFind (rest inList))))
        (else (eq? elementToFind inList))))
                             

(define (unitTest)
  (and 
   (containsAnywhere 'a '(a))
   (containsAnywhere 'a '(b a))
   (not (containsAnywhere 'a '(c d)))
   (containsAnywhere 'a '((a) b))
   (containsAnywhere 'b '((c d e) (g b e)))
   (containsAnywhere 'b '((c d e) (g (b) e)))
   (not (containsAnywhere 'x '((c d e) (g (b) e))))
   (containsAnywhere 'f '((c d e) (g (b) e) f))
   (not (containsAnywhere 'h '((c d e) (g (b) e) f)))
   ))

(display "Results from unitTest: ")
(unitTest)

(define (removeAll elementToRemove inList)
  (cond ((null? inList) '())
        ((list? (first inList)) (append (list (removeAll elementToRemove (first inList)))
                                        (removeAll elementToRemove (rest inList))))
        ((eq? elementToRemove (first inList)) (removeAll elementToRemove (rest inList)))
        (else (append (list (first inList)) (removeAll elementToRemove (rest inList))))))

(define (unitTest2)
  (and 
   (equal? (removeAll 'a '(b a c)) '(b c))
   (equal? (removeAll 'a '((b a c d))) '((b c d)))
   (equal? (removeAll 'b '((b a c d (f)))) '((a c d (f))))
   (equal? (removeAll 'b '((b a c d (f b)))) '((a c d (f))))
   (equal? (removeAll 'b '((b a c d (f (b))))) '((a c d (f ()))))
   (equal? (removeAll 'b '((b a c d (f (b g))))) '((a c d (f (g)))))
   ))

(display "Results from unitTest2: ")
(unitTest2)

(define (feet-to-meters feet)
  (/ feet 3.28084))

(define (meters-to-feet meters)
  (* meters 3.28084))

(define (celsius-to-fahrenheit celsius)
  (+ (* (/ 9.0 5.0) celsius) 32))

(define (fahrenheit-to-celsius fahrenheit)
  (* (- fahrenheit 32) (/ 5.0 9.0)))

(define (kilograms-to-pounds kilograms)
  (* kilograms 2.20462))

(define (pounds-to-kilograms pounds)
  (/ pounds 2.20462))

(define (dollars-to-pesos dollars)
  (* dollars 12.62))

(define (pesos-to-dollars pesos)
  (/ pesos 12.62))
  

(define (calculator)
  (display "Enter the first unit: ")
  (let ([unit1 (read)])
    (display "Enter the second unit: ")
    (let* ([unit2 (read)]
          [function (string->symbol (string-append (symbol->string unit1)
                                                   (string-append "-to-" (symbol->string unit2))))])
      (display "Enter the value to convert: ")
      (let ([value (read)])
        ((eval function) value)))))