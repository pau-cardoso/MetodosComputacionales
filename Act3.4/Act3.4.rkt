#lang racket

(require 2htdp/batch-io)

;; Lectura del archivo
(define code
  (string->list (read-file "D:\\Repositories\\MetodosComputacionales\\Act3.4\\test.cpp")))

;; Escritura del archivo
(define copy
  (lambda (source destination)
    (write-file destination (read-file source))))


;; Comentario
(define (commentA code index) 
  (cond 
    [(equal? (car code) #\/) (commentB (cdr code) (+ index 1))]
    [else -1]))

(define (commentB code index) 
  (cond 
    [(equal? (car code) #\/) (commentC (cdr code) (+ index 1))]
    [else -1]))

(define (commentC code index) 
  (cond
    [(empty? code) index]
    [(not (equal? (car code) #\newline)) (commentC (cdr code) (+ index 1))]
    [else index]))


;; Elimina los elementos de la lista dado un numero de posiciones a eliminar
(define (popElement lst index)
  (cond
    [(> index 0) (popElement (cdr lst) (- index 1))]
    [else lst]))

; (popElement prueba (commentA prueba 0))


;; Corta la lista desde el indice dado hasta el final
(define sublst
  (lambda (lst newlst quantity)
    (if (> quantity 0) (sublst (cdr lst) (append newlst (list (car lst))) (- quantity 1)) newlst)))

(define appendHTML
  (lambda (openTag quantity lst html)
    (string-append html (string-append openTag (string-append (list->string(sublst lst '() quantity)) "</span>")))))

(define (writeTag class)
  )

(define lexicalAnalyzer
  (lambda (code html)
    (if (empty? code) html
        (cond
          [(not (> (commentA code 0) 0)) (lexicalAnalyzer (lstPop code (commentA code 0)) (appendHTML "<span class='identifier'>" (commentA code 0) code html))]
          ;[(not (equal? (floatA code 0) 0)) (lexicalAnalyzer (codePop code (floatA code 0)) (appendHTML "<span class='float'>" (floatA code 0) code html))]
          ;[(not (equal? (intA code 0) 0)) (lexicalAnalyzer (codePop code (intA code 0)) (appendHTML "<span class='int'>" (intA code 0) code html))]
          
          [else (lexicalAnalyzer (cdr code) html)]
         )
    )))

(define prueba
  '(#\/ #\/ #\space #\E #\s #\t #\e #\newline #\v #\a #\r #\1))

;; '(#\/ #\/ #\space #\E #\s #\t #\e)
;; (commentA prueba 0)

;;(lexicalAnalyzer code "")