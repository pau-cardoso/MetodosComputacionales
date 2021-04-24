#lang racket

;; Paulina Cardoso
;; A01701490

(require 2htdp/batch-io)

;; Lectura del archivo
(define code
  (string->list (read-file "D:\\Repositories\\MetodosComputacionales\\Act3.4\\test.cpp")))

;; Escritura del archivo
; (write-file "prueba.html" fileHTML)
; copy ((syntaxisHighlighter code "") index.html)

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



;; Variables
(define (variableA code index)
  (cond
    [(char-alphabetic? (car code)) (variableB (cdr code) (+ index 1))]
    [else -1]))

(define (variableB code index)
  (cond
    [(empty? code) index]
    [(char-alphabetic? (car code)) (variableC (cdr code) (+ index 1))]
    [(char-numeric? (car code)) (variableC (cdr code) (+ index 1))]
    [(equal? (car code) #\_) (variableC (cdr code) (+ index 1))]
    [else index]))

(define (variableC code index)
  (cond
    [(empty? code) index]
    [(char-alphabetic? (car code)) (variableC (cdr code) (+ index 1))]
    [(char-numeric? (car code)) (variableC (cdr code) (+ index 1))]
    [(equal? (car code) #\_) (variableC (cdr code) (+ index 1))]
    [else index]))



;; Numeros reales
(define (realesA code index)
  (cond
    [(equal? (car code) #\-) (realesC (cdr code) (+ index 1))]
    [(char-numeric? (car code)) (realesB (cdr code) (+ index 1))]
    [(equal? (car code) #\.) (realesD (cdr code) (+ index 1))]
    [else -1]))

(define (realesB code index)
  (cond
    [(char-numeric? (car code)) (realesB (cdr code) (+ index 1))]
    [(equal? (car code) #\.) (realesE (cdr code) (+ index 1))]
    [else -1]))

(define (realesC code index)
  (cond
    [(char-numeric? (car code)) (realesB (cdr code) (+ index 1))]
    [(equal? (car code) #\.) (realesD (cdr code) (+ index 1))]
    [else -1]))

(define (realesD code index)
  (cond
    [(char-numeric? (car code)) (realesF (cdr code) (+ index 1))]
    [else -1]))

(define (realesE code index)
  (cond
    [(empty? code) index]
    [(char-numeric? (car code)) (realesF (cdr code) (+ index 1))]
    [else index]))

(define (realesF code index)
  (cond
    [(empty? code) index]
    [(char-numeric? (car code)) (realesF (cdr code) (+ index 1))]
    [(equal? (car code) #\E) (realesG (cdr code) (+ index 1))]
    [(equal? (car code) #\e) (realesG (cdr code) (+ index 1))]
    [else index]))

(define (realesG code index)
  (cond
    [(equal? (car code) #\-) (realesI (cdr code) (+ index 1))]
    [(char-numeric? (car code)) (realesH (cdr code) (+ index 1))]
    [else -1]))

(define (realesH code index)
  (cond
    [(empty? code) index]
    [(char-numeric? (car code)) (realesH (cdr code) (+ index 1))]
    [else index]))

(define (realesI code index)
  (cond
    [(char-numeric? (car code)) (realesH (cdr code) (+ index 1))]
    [else -1]))



;; Enteros
(define (enteroA code index)
  (cond
    [(equal? (car code) #\-) (enteroB (cdr code) (+ index 1))]
    [(char-numeric? (car code)) (enteroC (cdr code) (+ index 1))]
    [else -1]))

(define (enteroB code index)
  (cond
    [(char-numeric? (car code)) (enteroC (cdr code) (+ index 1))]
    [else -1]))

(define (enteroC code index)
  (cond
    [(empty? code) index]
    [(char-numeric? (car code)) (enteroC (cdr code) (+ index 1))]
    [else index]))



;; Strings
(define (stringA code index)
  (cond
    [(equal? (car code) #\") (stringB (cdr code) (+ index 1))]
    [else -1]))

(define (stringB code index)
  (cond
    [(equal? (car code) #\") (stringC (cdr code) (+ index 1))]
    [(char? (car code)) (stringD (cdr code) (+ index 1))]
    [else -1]))

(define (stringC code index)
  index)

(define (stringD code index)
  (cond
    [(equal? (car code) #\") (stringC (cdr code) (+ index 1))]
    [(char? (car code)) (stringD (cdr code) (+ index 1))]
    [else -1]))



;; Elimina los elementos de la lista dado un numero de posiciones a eliminar
(define (popElement lst index)
  (cond
    [(> index 0) (popElement (cdr lst) (- index 1))]
    [else lst]))


;; Dada una lista, convierte los elementos desde 0 hasta la posicion dada en un string
(define (substring lst index textLst)
  (cond
    [(> index 0) (substring (cdr lst) (- index 1) (append textLst (list (car lst))))]
    [else (list->string textLst)]))


;; Regresa el string del head del html
(define headHTML
  "<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='UTF-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>Actividad 3.4 Paulina</title>
    <link rel='stylesheet' href='styles.css'>
</head>
<body>")


;; Escribe el tag del html con su debida clase y texto
(define (writeTag class text)
  (string-append "<span class='" class "'>" text "</span>"))


;; Realiza la escritura del resaltador de sintaxis en un string que se escribira en un archivo
(define (syntaxisHighlighter code fileHTML)
  (cond
    [(empty? code) (write-file "prueba.html" fileHTML)]
    ; Espacios
    [(equal? (car code) #\space) (syntaxisHighlighter (cdr code) (string-append fileHTML "&nbsp;"))]
    ; Salto de lineas
    [(equal? (car code) #\newline) (syntaxisHighlighter (cdr code) (string-append fileHTML "<br>"))]
    ; Tabs
    [(equal? (car code) #\tab) (syntaxisHighlighter (cdr code) (string-append fileHTML "&nbsp;&nbsp;&nbsp;&nbsp;"))]
    ; Comentarios
    [(> (commentA code 0) 0) (syntaxisHighlighter (popElement code (commentA code 0)) (string-append fileHTML (writeTag "comentario" (substring code (commentA code 0) '()))))]
    ; Strings
    [(> (stringA code 0) 0) (syntaxisHighlighter (popElement code (stringA code 0)) (string-append fileHTML (writeTag "string" (substring code (stringA code 0) '()))))]
    ; Variables
    [(> (variableA code 0) 0) (syntaxisHighlighter (popElement code (variableA code 0)) (string-append fileHTML (writeTag "variable" (substring code (variableA code 0) '()))))]
    ; Numeros reales
    [(> (realesA code 0) 0) (syntaxisHighlighter (popElement code (realesA code 0)) (string-append fileHTML (writeTag "reales" (substring code (realesA code 0) '()))))]
    ; Numeros enteros
    [(> (enteroA code 0) 0) (syntaxisHighlighter (popElement code (enteroA code 0)) (string-append fileHTML (writeTag "enteros" (substring code (enteroA code 0) '()))))]
    ; Operadores de parentesis, corchetes, etc
    [(or (equal? (car code) #\{) (equal? (car code) #\}) (equal? (car code) #\[) (equal? (car code) #\]) (equal? (car code) #\() (equal? (car code) #\)) ) (syntaxisHighlighter (cdr code) (string-append fileHTML (writeTag "operadores" (string (car code)))))]
    ; Operadores logicos y puntuacion
    [(or (equal? (car code) #\=) (equal? (car code) #\+) (equal? (car code) #\*) (equal? (car code) #\/) (equal? (car code) #\^) (equal? (car code) #\-) (equal? (car code) #\;) (equal? (car code) #\:) (equal? (car code) #\<) (equal? (car code) #\>) (equal? (car code) #\#)) (syntaxisHighlighter (cdr code) (string-append fileHTML (writeTag "operadores-logicos" (string (car code)))))]
    [else (syntaxisHighlighter (cdr code) (string-append fileHTML (string (car code))) )] ))


(define prueba
  '(#\" #\4 #\. #\3 #\e #\- #\5 #\3 #\space #\" #\newline #\h #\o #\l #\a #\;))
  ;;'(#\v #\a #\r #\1 #\_ #\space #\h))
  ;'(#\/ #\/ #\space #\E #\s #\t #\e #\newline #\v #\a #\r #\1))

;; '(#\/ #\/ #\space #\E #\s #\t #\e)
;; (commentA prueba 0)

; (write-file "prueba.html" fileHTML)
;;(syntaxisHighlighter code headHTML)