{plus, minus, times, equals, zero, greater, less, car, cdr, cons, display, } = require './primitive'
{parser} = require './parser'
{Env} = require './env'
{evaluate} = require './eval'	

global_env = new Env

init_global_env = ->		
	global_env.add "#t", true
	global_env.add "#f", false
	global_env.add "true", true
	global_env.add "false", false
	global_env.add "+", plus
	global_env.add "-", minus
	global_env.add "*", times
	global_env.add ">", greater
	global_env.add "<", less
	global_env.add "=", equals
	global_env.add "zero?", zero,
	global_env.add "display", display
	global_env.add "car", car
	global_env.add "cdr", cdr
	global_env.add "cons", cons
	global_env.add "and", lisp_and
	global_env.add "or", lisp_or
	global_env.add "not", lisp_not
	
start = (str) ->
	init_global_env()
	root = parser.parse str
	console.log root.to_array()
	evaluate e, global_env for e in root.value
	
#str = "(define a 1) (define b 2) (define add (lambda (x y) (+ x y))) (define sum (add a b)) (sum)"
#str = "(define a 1) (define b 2) (define add (lambda (a b) (+ a b))) (define sum (add a b)) (display sum)"
#str = "(define add (lambda (a b) (+ a b))) (add 5 5)"
#str = "(define l (quote (1 2 3 4)) ) (define ll (cons 5 l)) (display ll)"
#str = "(define l (quote (1 2 3 4))) (define first (car l)) (display first)"
str = "(define l (quote (1 2 3 4))) (define first (car l)) (define rest (cdr l)) (define orig (cons first rest)) (display orig)"
start str

