#lang racket

;; Paulina Cardoso
;; A01701490

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



;; Variables
(define (variableA code index)
  (cond
    [(char-alphabetic? (car code)) (variableB (cdr code) (+ index 1))]
    [else -1]))

(define (variableB code index)
  (cond
    [(char-alphabetic? (car code)) (variableC (cdr code) (+ index 1))]
    [(char-numeric? (car code)) (variableC (cdr code) (+ index 1))]
    [(char-numeric? (car code)) (variableC (cdr code) (+ index 1))]
    [else index]))

(define (variableC code index)
  (cond
    [(char-alphabetic? (car code)) (variableC (cdr code) (+ index 1))]
    [(char-numeric? (car code)) (variableC (cdr code) (+ index 1))]
    [else index]))



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


;; Escribe el head del html
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
    [(empty? code) fileHTML]
    [(equal? (car code) #\space) (syntaxisHighlighter (cdr code) (append fileHTML "&nbsp;"))]
    [(equal? (car code) #\newline) (syntaxisHighlighter (cdr code) (append fileHTML "<br>"))]
    [(equal? (car code) #\tab) (syntaxisHighlighter (cdr code) (append fileHTML "&nbsp;&nbsp;&nbsp;&nbsp;"))]
    [(> (commentA code 0) 0) (syntaxisHighlighter (popElement code (commentA code 0)) (append (writeTag "comentario" (substring code (commentA code 0) '()))))]
    [else (syntaxisHighlighter (cdr code) fileHTML)]))


(define prueba
  '(#\/ #\/ #\space #\E #\s #\t #\e #\newline #\v #\a #\r #\1))

;; '(#\/ #\/ #\space #\E #\s #\t #\e)
;; (commentA prueba 0)

;;(lexicalAnalyzer code "")