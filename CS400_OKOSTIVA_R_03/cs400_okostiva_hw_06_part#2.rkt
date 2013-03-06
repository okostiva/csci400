;Orion Kostival
;CSCI 400
;3/7/2013
;Racket HW #3 Part2

;List of articles defined the problem description
(define articles '(
     ((Test-Driven Learning: Intrinsic Integration of Testing into the CS/SE Curriculum)
      ((David Jansen)(Hossein Saiedian))
      ("Test-driven learning" "test-driven development" "extreme programming" "pedagogy" "CS1"))
     ((Process Improvement of Peer Code Review and Behavior Analysis of its Participants)
      ((WANG Yan-qing) (LI Yi-jun) (Michael Collins) (LIU Pei-jie))
      ("peer code review" "behavior analysis" "software quality assurance" 
        "computer science education" "software engineering"))
     ((Computer Games as Motivation for Design Patterns)
      ((Paul V. Gestwicki))
      ("Design Patterns" "Games" "Pedagogy" "Java"))
     ((Killer "Killer Examples" for Design Patterns)
      ((Carl Alphonce) (Michael Caspersen) (Adrienne Decker))
      ("Object-orientation" "Design Patterns"))
     ((Test-First Java Concurrency for the Classroom)
      ((Mathias Ricken)(Robert Cartwright))
      ("CS education" "Java" "JUnit" "unit testing" "concurrent programming"
       "tools" "software engineering"))
     ((Teaching Design Patterns in CS1: a Closed Laboratory Sequence
                based on the Game of Life)
      ((Michael Wick))
      ("Design Patterns" "Game of Life" "CS1" "Laboratory"))
   ))

;Accessor for the title of the article
(define (getTitle article) 
  (if (list? article)
      (first article)
      '()))

;Accessor for the author of the article
(define (getAuthors article)
  (if (list? article)
      (first (rest article))))
       
;Accessor for the keywords of the article
(define (getKeywords article)
  (if (list? article)
      (first (rest (rest article)))))

;Function call to match the definition in the project description
;
;This function will call the selectTitles function with the results
;from the call to the doSearch function
(define (keywordSearch keyword articleList)
  (selectTitles articleList (doSearch keyword articles)))

;Function call that will return all of the titles of the articles
;that contained the given keyword based on a list of search results
(define (selectTitles articleList searchResults)
  (if (null? searchResults) 
      '()
      (if (first searchResults) 
          (append (list (getTitle (first articleList)))
                  (selectTitles (rest articleList) (rest searchResults)))
          (selectTitles (rest articleList) (rest searchResults)))))

;Function call that utilized map and currying in order to call the 
;createFunction method for each article in the list of provided articles
(define (doSearch keyword articleList)
  (map (createFunction keyword) articleList))

;Fuction call that utilized currying in order to properly build up the
;call to containsKeyword which requires two arguments (but map can only
;use a single argument)
(define (createFunction keyword)
  (lambda (article)
    (containsKeyword keyword (getKeywords article))))

;Function that will return true if the provided keyword is found in the 
;provided list of keywords
(define (containsKeyword keyword keywordList)
  (if (null? keywordList)
      #f
      (if (string=? keyword (first keywordList))
          #t
          (containsKeyword keyword (rest keywordList)))))
    