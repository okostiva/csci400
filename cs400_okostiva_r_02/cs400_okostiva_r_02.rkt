;Function to display all of the sticks in the provided row
(define (displayRow row)
  (cond ((null? row) (newline))
        ((null? (rest row)) (display (first row)) (newline))
        (else (display (first row)) (display " ") (displayRow (rest row)))))

;Function to display each row of the board with the corresponding label
;Returns #t if the board was valid
;Returns #f is the board did not contain any rows
(define (displayBoard board row)
  (cond ((null? board) #f)
        (else (display "Row ") 
              (display row) 
              (display ": ")
              (displayRow (first board))
              (if (null? (rest board)) 
                  #t
                  (displayBoard (rest board) (+ row 1))))))

;Function to display the current player's turn
(define (displayTurn playerNum)
  (display "Player ")
  (display (+ 1 playerNum))
  (display "'s Turn")
  (newline)
  (display "--------------------------")
  (newline))

;Function to display the winner of the game
(define (displayWinner playerNum)
  (display "--------------------------")
  (newline)
  (display "PLAYER ")
  (display (+ 1 playerNum))
  (display " WINS!")
  (newline))

;Function to get the number of rows in the given board
(define (getBoardRows board) (length board))

;Function to get the number of remaining sticks in a given row of a given board
(define (getRemainingSticks board row) (length (list-ref board (- row 1))))

;Function to validate that the user selected a valid row
(define (validateRow board row)
  (cond ((not (number? row)) #f)
        ((< row 1) #f)
        ((> row (getBoardRows board)) #f)
        (else #t)))

;Function to validate the that the user selected to remove a valid number of sticks
(define (validateNumSticks board row numSticks)
  (cond ((not (number? numSticks)) #f)
        ((< numSticks 1) #f)
        ((> numSticks (getRemainingSticks board row)) #f)
        (else #t)))

;Function to remove a given number of sticks from the given row of the given board
;Returns a new board
(define (removeSticks board row numSticks)
  (if (eq? row 1)
      (append (list (list-tail (first board) numSticks)) (rest board))
      (append (list (first board)) (removeSticks (rest board) (- row 1) numSticks))))

;Function to handle the user move
(define (humanTurn board)
  (display "Which row do you choose:.. ")
  ((lambda (inRow)
     (display "How many sticks:.......... ")
     ((lambda (row numSticks)
        (cond ((and (validateRow board row) (validateNumSticks board row numSticks))
               (removeSticks board row numSticks))
              (else (display "INVALID MOVE! - TRY AGAIN")
                    (newline)
                    board)))
      inRow (read)))
   (read)))

;Function to handle the random player's move
(define (randomTurn board)
  (display "Hello random"))

;Function to handle the smart player's move
(define (smartTurn board)
  (display "Hello smart"))

;Function to check whether the game is over (if there are no sticks remaining the game is over)
(define (gameOver board)
  (if (null? (rest board))
      #t
      (and (eq? (length (first board)) 0) (gameOver (rest board)))))

;Function to control the game play
;Takes a board, list of players and the index of the current player's turn as parameters
(define (playNIM board players playerTurn)
  (display "--------------------------")
  (newline)
  (if (displayBoard board 1)
      (cond ((string=? (string-upcase (symbol->string (list-ref players playerTurn))) "HUMAN") 
             (displayTurn playerTurn)
             ((lambda (resultBoard)
                (if (equal? board resultBoard)
                    (playNIM board players playerTurn)
                    (if (gameOver resultBoard)
                        (displayWinner playerTurn)
                        (playNIM resultBoard players (modulo (+ 1 playerTurn) (length players))))))
              (humanTurn board)))
            ((string=? (string-upcase (symbol->string (list-ref players playerTurn))) "SMART")
             (displayTurn playerTurn)
             (playNIM (smartTurn board) players (modulo (+ 1 playerTurn) (length players))))
            ((string=? (string-upcase (symbol->string (list-ref players playerTurn))) "RANDOM")
             (displayTurn playerTurn)
             (playNIM (randomTurn board) players (modulo (+ 1 playerTurn) (length players))))
            (else (display "PLEASE PROVIDE A VALID PLAYER LIST")))
      (display "PLEASE PROVIDE A VALID BOARD")))

;Function to initialize the game play
(define (NIM board players)
  (display "WELCOME TO NIM!")
  (newline)
  (if (empty? board)
      (display "PLEASE PROVIDE A NON-EMPTY BOARD")
      (if (empty? players)
          (display "PLEASE PROVIDE A NON-EMPTY PLAYER LIST")
          (playNIM board players 0))))

(NIM '[(X) (X X X) (X X X X X)] '(human human))
