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
;Returns the number of the winning player
(define (displayWinner playerNum)
  (display "--------------------------")
  (newline)
  (display "PLAYER ")
  (display (+ 1 playerNum))
  (display " WINS!")
  (newline)
  (+ 1 playerNum))

;Function that will return a list containing the number of elements in each row of a given board
(define (getRowSizeList board)
    (if (null? (rest board))
        (list (length (first board)))
        (append (list (length (first board))) (getRowSizeList (rest board)))))

;Function to check whether the game is over (if there are no sticks remaining the game is over)
(define (gameOver board)
  (eq? 0 (apply + (getRowSizeList board))))

;Function to get the number of rows in the given board
(define (getBoardRows board) (length board))

;Function to get the number of remaining sticks in a given row of a given board
(define (getRemainingSticks board row) (length (list-ref board (- row 1))))

;Function to get a valid random row
;If the initial random number corresponds to a row with no sticks, increment the row until a row with sticks is found
(define (getRandomRow board)
  (define (checkRow index)
    (if (> (getRemainingSticks board (+ index 1)) 0)
        index
        (checkRow (modulo (+ 1 index) (getBoardRows board)))))
  (checkRow (random (getBoardRows board))))

;Function that accepts the a list containing the number of sticks remaining in each row in the board and the current 
;row index that should be used to determine if a good move is possible
(define (makeBestMove rowSizeList rowIndex board)
  ((lambda (xorResult)
     (cond ((<= (bitwise-xor (list-ref rowSizeList rowIndex) xorResult) (list-ref rowSizeList rowIndex))
           ((lambda (row numSticks)
              (display "Which row do you choose:.. ")
              (display row)
              (newline)
              (display "How many sticks:.......... ")
              (display numSticks)
              (newline)
              (removeSticks board row numSticks))
            (+ rowIndex 1) (- (list-ref rowSizeList rowIndex) (bitwise-xor (list-ref rowSizeList rowIndex) xorResult))))
          (else (makeBestMove rowSizeList (+ 1 rowIndex) board))))
   (apply bitwise-xor rowSizeList)))

;Function to remove a given number of sticks from the given row of the given board
;Returns a new board
(define (removeSticks board row numSticks)
  (if (eq? row 1)
      (append (list (list-tail (first board) numSticks)) (rest board))
      (append (list (first board)) (removeSticks (rest board) (- row 1) numSticks))))

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
  ((lambda (row)
     (display "Which row do you choose:.. ")
     (display row)
     (newline)
     ((lambda (numSticks)
        (display "How many sticks:.......... ")
        (display numSticks)
        (newline)
        (removeSticks board row numSticks))
      (+ (random (getRemainingSticks board row)) 1)))
   (+ (getRandomRow board) 1)))

;Function to handle the smart player's move
(define (smartTurn board)
  ((lambda (rowSizeList)
     ;If the parity is already even, make a random move because there is no move that guarantees a win
     (if (eq? (apply bitwise-xor rowSizeList) 0)
         (randomTurn board)
         (makeBestMove rowSizeList 0 board)))
   (getRowSizeList board)))

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
             ((lambda (resultBoard)
                (if (gameOver resultBoard)
                    (displayWinner playerTurn)
                    (playNIM resultBoard players (modulo (+ 1 playerTurn) (length players)))))
              (smartTurn board)))
            ((string=? (string-upcase (symbol->string (list-ref players playerTurn))) "RANDOM")
             (displayTurn playerTurn)
             ((lambda (resultBoard)
                (if (gameOver resultBoard)
                    (displayWinner playerTurn)
                    (playNIM resultBoard players (modulo (+ 1 playerTurn) (length players)))))
              (randomTurn board)))
            (else (display "PLEASE PROVIDE A VALID PLAYER LIST")))
      (display "PLEASE PROVIDE A VALID BOARD")))

;Function to initialize the game play
(define (NIM board players)
  (display "WELCOME TO NIM!")
  (newline)
  (if (or (empty? board) (eq? 0 (apply + (getRowSizeList board))))
      (display "PLEASE PROVIDE A NON-EMPTY BOARD")
      (if (empty? players)
          (display "PLEASE PROVIDE A NON-EMPTY PLAYER LIST")
          (playNIM board players 0))))

;Start the game when the file is run
(NIM '[(X X X) (X) (X X) (X X X X X) (X X X)] '(human smart))
