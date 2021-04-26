#lang racket

;; Paulina Cardoso
;; A01701490

(require 2htdp/batch-io)


;; Input del usuario para saber el lenguaje del programa
(display "Introduce el lenguaje de tu programa como 'cpp' para C++ o 'py' para Python: ")
(define programa (read-line))

;; Input del usuario para saber la ruta del programa a leer
(display "Introduce la ruta del archivo código a leer en formato 'D:\\Descargas\\Codigos\\codigo.cpp' ")
(define archivo (read-line))


;; Lectura del archivo
(define code
  (string->list (read-file archivo)))

; D:\\Repositories\\MetodosComputacionales\\Act3.4\\test.py
; D:\\Repositories\\MetodosComputacionales\\Act3.2\\main.cpp


;; Palabras reservadas
(define pythonPR
  (set "or" "while" "continue" "exec" "import" "yield" "def" "finally" "in" "print" "and" "del" "for" "is" "raise" "assert" "if" "else" "elif" "from" "lambda" "return" "break" "global" "not" "try" "class" "except"))

(define cplusplusPR
  (set "asm" "auto" "bool" "break" "case" "catch" "char" "class" "const" "const_cast" "continue" "default" "delete" "do" "double" "dynamic_cast" "else" "enum" "explicit" "extern" "false" "float" "for" "friend" "goto" "if" "inline" "int" "long" "mutable" "namespace" "new" "operator" "private" "protected" "public" "register" "reinterpret_cast" "return" "short" "signed" "sizeof" "static" "static_cast" "struct" "switch" "template" "this" "throw" "true" "try" "typedef" "typeid" "typename" "union" "unsigned" "using" "virtual" "void" "volatile" "while"))

(define (pyPR palabra lst index)
  (cond
    [(empty? lst) index]
    [(char-alphabetic? (car lst))(pyPR (string-append palabra (string (car lst))) (cdr lst) (+ 1 index))]
    [(set-member? pythonPR palabra) index]
    [else 0]))

(define (cppPR palabra lst index)
  (cond
    [(empty? lst) index]
    [(char-alphabetic? (car lst))(cppPR (string-append palabra (string (car lst))) (cdr lst) (+ 1 index))]
    [(set-member? cplusplusPR palabra) index]
    [else 0]))



;; Comentario para Python
(define (pyCommentA code index) 
  (cond 
    [(equal? (car code) #\#) (pyCommentB (cdr code) (+ index 1))]
    [else -1]))

(define (pyCommentB code index) 
  (cond
    [(empty? code) index]
    [(not (equal? (car code) #\newline)) (pyCommentB (cdr code) (+ index 1))]
    [else index]))



;; Comentario para C++
(define (cppCommentA code index) 
  (cond 
    [(equal? (car code) #\/) (cppCommentB (cdr code) (+ index 1))]
    [else -1]))

(define (cppCommentB code index) 
  (cond 
    [(equal? (car code) #\/) (cppCommentC (cdr code) (+ index 1))]
    [else -1]))

(define (cppCommentC code index) 
  (cond
    [(empty? code) index]
    [(not (equal? (car code) #\newline)) (cppCommentC (cdr code) (+ index 1))]
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
    [(or (equal? (car code) #\") (equal? (car code) #\')) (stringB (cdr code) (+ index 1))]
    [else -1]))

(define (stringB code index)
  (cond
    [(or (equal? (car code) #\") (equal? (car code) #\')) (stringC (cdr code) (+ index 1))]
    [(char? (car code)) (stringD (cdr code) (+ index 1))]
    [else -1]))

(define (stringC code index)
  index)

(define (stringD code index)
  (cond
    [(or (equal? (car code) #\") (equal? (car code) #\')) (stringC (cdr code) (+ index 1))]
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
(define (cppSyntaxisHighlighter code fileHTML)
  (cond
    [(empty? code) (write-file "prueba.html" fileHTML)]
    ; Espacios
    [(equal? (car code) #\space) (cppSyntaxisHighlighter (cdr code) (string-append fileHTML "&nbsp;"))]
    ; Salto de lineas
    [(equal? (car code) #\newline) (cppSyntaxisHighlighter (cdr code) (string-append fileHTML "<br>"))]
    ; Tabs
    [(equal? (car code) #\tab) (cppSyntaxisHighlighter (cdr code) (string-append fileHTML "&nbsp;&nbsp;&nbsp;&nbsp;"))]
    ; Comentarios
    [(> (cppCommentA code 0) 0) (cppSyntaxisHighlighter (popElement code (cppCommentA code 0)) (string-append fileHTML (writeTag "comentario" (substring code (cppCommentA code 0) '()))))]
    ; Palabras reservadas
    [(> (cppPR "" code 0) 0) (cppSyntaxisHighlighter (popElement code (cppPR "" code 0)) (string-append fileHTML (writeTag "palabra-reservada" (substring code (cppPR "" code 0) '()))))]
    ; Strings
    [(> (stringA code 0) 0) (cppSyntaxisHighlighter (popElement code (stringA code 0)) (string-append fileHTML (writeTag "string" (substring code (stringA code 0) '()))))]
    ; Variables
    [(> (variableA code 0) 0) (cppSyntaxisHighlighter (popElement code (variableA code 0)) (string-append fileHTML (writeTag "variable" (substring code (variableA code 0) '()))))]
    ; Numeros reales
    [(> (realesA code 0) 0) (cppSyntaxisHighlighter (popElement code (realesA code 0)) (string-append fileHTML (writeTag "reales" (substring code (realesA code 0) '()))))]
    ; Numeros enteros
    [(> (enteroA code 0) 0) (cppSyntaxisHighlighter (popElement code (enteroA code 0)) (string-append fileHTML (writeTag "enteros" (substring code (enteroA code 0) '()))))]
    ; Operadores de parentesis, corchetes, etc
    [(or (equal? (car code) #\{) (equal? (car code) #\}) (equal? (car code) #\[) (equal? (car code) #\]) (equal? (car code) #\() (equal? (car code) #\)) ) (cppSyntaxisHighlighter (cdr code) (string-append fileHTML (writeTag "operadores" (string (car code)))))]
    ; Operadores logicos y puntuacion
    [(or (equal? (car code) #\=) (equal? (car code) #\+) (equal? (car code) #\*) (equal? (car code) #\/) (equal? (car code) #\^) (equal? (car code) #\-) (equal? (car code) #\;) (equal? (car code) #\:) (equal? (car code) #\<) (equal? (car code) #\>) (equal? (car code) #\#)) (cppSyntaxisHighlighter (cdr code) (string-append fileHTML (writeTag "operadores-logicos" (string (car code)))))]
    [else (cppSyntaxisHighlighter (cdr code) (string-append fileHTML (string (car code))) )] ))


(define (pySyntaxisHighlighter code fileHTML)
  (cond
    [(empty? code) (write-file "prueba.html" fileHTML)]
    ; Espacios
    [(equal? (car code) #\space) (pySyntaxisHighlighter (cdr code) (string-append fileHTML "&nbsp;"))]
    ; Salto de lineas
    [(equal? (car code) #\newline) (pySyntaxisHighlighter (cdr code) (string-append fileHTML "<br>"))]
    ; Tabs
    [(equal? (car code) #\tab) (pySyntaxisHighlighter (cdr code) (string-append fileHTML "&nbsp;&nbsp;&nbsp;&nbsp;"))]
    ; Comentarios
    [(> (pyCommentA code 0) 0) (pySyntaxisHighlighter (popElement code (pyCommentA code 0)) (string-append fileHTML (writeTag "comentario" (substring code (pyCommentA code 0) '()))))]
    ; Palabras reservadas
    [(> (pyPR "" code 0) 0) (pySyntaxisHighlighter (popElement code (pyPR "" code 0)) (string-append fileHTML (writeTag "palabra-reservada" (substring code (pyPR "" code 0) '()))))]
    ; Strings
    [(> (stringA code 0) 0) (pySyntaxisHighlighter (popElement code (stringA code 0)) (string-append fileHTML (writeTag "string" (substring code (stringA code 0) '()))))]
    ; Variables
    [(> (variableA code 0) 0) (pySyntaxisHighlighter (popElement code (variableA code 0)) (string-append fileHTML (writeTag "variable" (substring code (variableA code 0) '()))))]
    ; Numeros reales
    [(> (realesA code 0) 0) (pySyntaxisHighlighter (popElement code (realesA code 0)) (string-append fileHTML (writeTag "reales" (substring code (realesA code 0) '()))))]
    ; Numeros enteros
    [(> (enteroA code 0) 0) (pySyntaxisHighlighter (popElement code (enteroA code 0)) (string-append fileHTML (writeTag "enteros" (substring code (enteroA code 0) '()))))]
    ; Delimitadores
    [(or (equal? (car code) #\{) (equal? (car code) #\}) (equal? (car code) #\[) (equal? (car code) #\]) (equal? (car code) #\() (equal? (car code) #\)) ) (pySyntaxisHighlighter (cdr code) (string-append fileHTML (writeTag "operadores" (string (car code)))))]
    ; Operadores
    [(or (equal? (car code) #\=) (equal? (car code) #\+) (equal? (car code) #\*) (equal? (car code) #\/) (equal? (car code) #\^) (equal? (car code) #\-) (equal? (car code) #\;) (equal? (car code) #\:) (equal? (car code) #\<) (equal? (car code) #\>) (equal? (car code) #\#) (equal? (car code) #\&) (equal? (car code) #\|)) (pySyntaxisHighlighter (cdr code) (string-append fileHTML (writeTag "operadores-logicos" (string (car code)))))]
    [else (pySyntaxisHighlighter (cdr code) (string-append fileHTML (string (car code))) )] ))


(define (run programa code fileHTML)
  (cond
    [(equal? programa "cpp") (cppSyntaxisHighlighter code fileHTML)]
    [(equal? programa "py") (pySyntaxisHighlighter code fileHTML)]))

(define prueba
  '(#\i #\n #\t #\space #\3 #\2 #\5 #\3 #\space #\newline #\h #\o #\l #\a #\;))
  ;;'(#\v #\a #\r #\1 #\_ #\space #\h))
  ;'(#\/ #\/ #\space #\E #\s #\t #\e #\newline #\v #\a #\r #\1))

;; '(#\/ #\/ #\space #\E #\s #\t #\e)
;; (commentA prueba 0)

;; (run programa code headHTML)