;Function containsAnywhere takes an element to find and an input list
;and searches for the given element anywhere in the input list
;If the element is found, the function will return a true, otherwise
;the function will return a false
(define (containsAnywhere elementToFind inList)
        ;If the list is null, it cannot contain the element
  (cond ((null? inList) #f) 
        ;If the input list is still a list call the function recursively on the
        ;first element in the list and the rest of the list and or the results
        ((list? inList) (or (containsAnywhere elementToFind (first inList))
                             (containsAnywhere elementToFind (rest inList))))
        ;Otherwise we can check to see if the current element is the element to find
        (else (eq? elementToFind inList)))) 
                             
;Unit Test for the containsAnywhere function
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

;Run and display the results of the unit test
(display "Results from unitTest: ")
(unitTest)

;Function removeAll which takes an element to remove and an input list as parameters
;If the element is found, it will be removed from the list maintaining the original
;structure of the input list
(define (removeAll elementToRemove inList)
        ;If the input list is null, return a empty list
  (cond ((null? inList) '())
        ;If the first element in the input list is a list then make a recursive call
        ;to removeAll on the first element of the input list and the rest of the 
        ;input list and append the two results
        ((list? (first inList)) (append (list (removeAll elementToRemove (first inList)))
                                        (removeAll elementToRemove (rest inList))))
        ;If the element to remove is the first element in the list then make a recursive
        ;call to removeAll on the rest of the list (so the first element is removed)
        ((eq? elementToRemove (first inList)) (removeAll elementToRemove (rest inList)))
        ;Otherwise append the first element in the list to the reults of a recursive
        ;call to removeAll on the rest of the input list
        (else (append (list (first inList)) (removeAll elementToRemove (rest inList))))))

;Define the unit test for the removeAll function
(define (unitTest2)
  (and 
   (equal? (removeAll 'a '(b a c)) '(b c))
   (equal? (removeAll 'a '((b a c d))) '((b c d)))
   (equal? (removeAll 'b '((b a c d (f)))) '((a c d (f))))
   (equal? (removeAll 'b '((b a c d (f b)))) '((a c d (f))))
   (equal? (removeAll 'b '((b a c d (f (b))))) '((a c d (f ()))))
   (equal? (removeAll 'b '((b a c d (f (b g))))) '((a c d (f (g)))))
   ))

;Run and display the results of the unit test
(display "Results from unitTest2: ")
(unitTest2)

;Define the function for converting feet-to-meters
(define (feet-to-meters feet)
  (/ feet 3.28084))

;Define the function for converting meters-to-feet
(define (meters-to-feet meters)
  (* meters 3.28084))

;Define the function for converting celsius-to-fahrenheit
(define (celsius-to-fahrenheit celsius)
  (+ (* (/ 9.0 5.0) celsius) 32))

;Define the function for converting fahrenheit-to-celsius
(define (fahrenheit-to-celsius fahrenheit)
  (* (- fahrenheit 32) (/ 5.0 9.0)))

;Define the function for converting kilograms-to-pounds
(define (kilograms-to-pounds kilograms)
  (* kilograms 2.20462))

;Define the function for converting pounds-to-kilograms
(define (pounds-to-kilograms pounds)
  (/ pounds 2.20462))

;Define the function for converting dollars-to-pesos
(define (dollars-to-pesos dollars)
  (* dollars 12.62))

;Define the function for converting pesos-to-dollars
(define (pesos-to-dollars pesos)
  (/ pesos 12.62))
  
;Define the calculator function
(define (calculator)
  ;Read in the units from the user
  (display "Enter the first unit: ")
  (let ([unit1 (read)])
    (display "Enter the second unit: ")
    (let* ([unit2 (read)]
           ;Convert the user input to a string and then to a symbol 
           ;in the form 'unit1-to-unit2
           [function (string->symbol (string-append (symbol->string unit1)
                                                    (string-append "-to-" (symbol->string unit2))))])
      ;Read in the value to convert
      (display "Enter the value to convert: ")
      (let ([value (read)])
        ;Evaluate the symbol containing the function name and pass the 
        ;value to be converted to the prodcedure returned (if it exists)
        ;otherwise an error will be thrown and the program will abort
        ((eval function) value)))))