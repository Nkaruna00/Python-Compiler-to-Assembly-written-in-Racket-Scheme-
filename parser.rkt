#lang racket/base

(require "lexer.rkt"
         parser-tools/yacc
         "ast.rkt")

(provide parse_python)

(define parse
  (parser
   (tokens nom debfin operators valeurs)
   (start prog)
   (end Leof)
   (grammar
    	(prog
     		((expr)         (list $1))
     		((vardecl prog) (cons $1 $2)))
    	(expr
     		((expr Lplus  expr) (Pop 'add  $1 $3))
     		((expr Lminus expr) (Pop 'sub  $1 $3))
     		((expr Lstar   expr) (Pop 'mult $1 $3))
     		((expr Lslash   expr) (Pop 'div  $1 $3))
     		((val)           $1))
    	(vardecl
     		((Lid Leq expr) (Pdef $1 $3)))

    	(val
     		((Lnum)  (Pval $1))
     		((Lid)   (Pid $1))))
   		(precs
   			(left Lplus)
   			(left Lminus)
   			(left Lstar)
   			(left Lslash))
		(error
    		(lambda (ok? name value)
      			(error 'Parser "ERREUR")))))

(define (parse_python in)
  (parse (lambda () (lex in))))
