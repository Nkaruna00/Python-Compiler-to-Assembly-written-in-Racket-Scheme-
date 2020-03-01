#lang racket/base

(require parser-tools/lex
         (prefix-in : parser-tools/lex-sre))

(provide lex operators valeurs debfin nom)

(define-empty-tokens debfin
  (Leq Lsc))

(define-empty-tokens operators
  (Leof Lplus Lminus Lstar Lslash))


(define-tokens valeurs
    (Lnum))

(define-tokens nom
  (Lid))


(define lex
  (lexer
   ((eof) (token-Leof))
   (whitespace (lex input-port))
   ("="   (token-Leq))
   (";"   (token-Lsc))
   ("+"   (token-Lplus))
   ("-"   (token-Lminus))
   ("*"   (token-Lstar))
   ("/"   (token-Lslash))
   ((:+ alphabetic) (token-Lid (string->symbol lexeme)))
   ((:+ numeric) (token-Lnum (string->number lexeme)))))
