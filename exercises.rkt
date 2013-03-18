(define (square x) (* x x))

(define (squareFirst inList) (* (square (first inList))))

(define (showCons e inList) (cons e inList))
  
(define (showAppend e inList) (append (list e) inList))

(define (showList e inList) (list e inList))

(define (half x) (/ x 2))

(define (theParts inList)
  (display "car: ")
  (display (list-ref inList 0))
  (newline)
  (display "cdr: ")
  (display (cdr inList))
  (newline)
  (display "caar: ")
  (display (caar inList))
  (newline)
  (display "cadar: ")
  (display (cadar inList))
  (newline))

(define (squareFirstIfEven inList)
  (if (eq? (modulo (first inList) 2) 0) 
      (cons (square (first inList)) (rest inList))
      inList))

(define (allSquares inList)
  (if (null? inList)
      '()
      (cons (square (first inList)) (allSquares (rest inList)))))

(define (evenSq inList)
  (if (null? inList)
      '()
      (if (even? (first inList))
          (cons (square (first inList))
                (evenSq (rest inList)))
          (evenSq (rest inList)))))

(define (evenSquares inList outList)
  (cond ((null? inList) '())
        ((even? (first inList)) (append (list (square (first inList))) (evenSquares (rest inList) outList)))
        (else (append outList (evenSquares (rest inList) outList))))) 

(define (evenSquaresTF inList outList)
  (if (null? (evenSquares inList outList)) #f (evenSquares inList outList)))
        
(define (userInfo)
  (display "Please enter your name: ")
  (let ([x (read)])
    (display "Hello, ")
    (display x)))
