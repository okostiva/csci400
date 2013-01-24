(define PI 3.14159)

(define (square x) (* x x))

(define bob '(a b c d))

(define (show_square x)
  (display "The square of ")
  (display x)
  (display " is ")
  (display (square x))
  (newline))

(define (love_items item_list)
  (if (null? item_list)
      (display "that is all...")
      (begin
        (display "I love ")
        (display (first item_list))
        (newline)
        (love_items (rest item_list)))))