{zip, map, error} = require './helpers'
{keyword} = require './keyword'
{Form, Str, Procedure, Sym} = require './node'
{Env} = require './env'
	
exports.evaluate = evaluate = (expr, env) ->
	return eval_number expr if is_number expr
	return eval_quote expr if is_quote expr
	return eval_symbol expr if is_symbol expr
	return eval_string expr if is_string expr
	return eval_list expr if is_list expr
	return eval_if expr, env if is_if expr
	return eval_define expr, env if is_define expr
	return eval_name expr, env if is_name expr
	return eval_lambda expr, env if is_lambda expr
	return eval_application expr, env if is_application expr
	error "unknown expxression type: " + expr
	
exports.invoke = invoke = (proc, operands) ->
	return proc operands.value if is_primitive_proc proc
	
	if is_defined_proc proc
		env = new Env proc.env
		params = proc.params
		if params.length() isnt operands.length()
			error "Parameter length mismatch"
		env.add name, value for [name, value] in zip params.value, operands.value
		evaluate proc.body, env
	else
		error "Apcliation of non-procedure"

is_numerical = (str)->
	not isNaN parseFloat str
	
is_number = (expr) ->
	typeof expr is "string" and is_numerical expr

eval_number = (expr) ->
	parseFloat expr

is_string = (expr) ->
	expr instanceof Str

eval_string = (expr) ->
	expr.value
	
is_symbol = (expr) ->
	expr instanceof Sym

eval_symbol = (expr) ->
	expr.value
	
is_name = (expr) ->
	typeof expr is "string" and not is_numerical(expr)
	
eval_name = (expr, env) ->
	env.lookup expr

is_list = (expr) ->
	expr instanceof Array

eval_list = (expr) ->
	expr
	
is_primitive_proc = (expr) ->
	expr instanceof Function

is_defined_proc = (expr) ->
	expr instanceof Procedure
	
is_application = (expr) ->
	expr instanceof Form and not expr.is_list and keyword.isnt_keyword expr.proc 
	
is_special_form = (expr, keyword) ->
	expr instanceof Form and expr.length() > 0 and expr.car() is keyword

is_quote = (expr) ->
	is_special_form expr, keyword.quote

eval_quote = (expr) ->
	if expr.length() isnt 2
		error "Bad quote expression " + expr
		
	value = expr.cadr()
	if value instanceof Form
		value.value
	else
		new Sym value

is_if = (expr) ->
	is_special_form expr, keyword.if
		
eval_if = (expr, env) ->
	if expr.length() isnt 4
		error "Bad if expression " + expr
	
	flag = evaluate expr.cadr(), env
	if flag
		evaluate expr.caddr(), env
	else
		evaluate expr.cadddr(), env

is_define = (expr) ->
	is_special_form expr, keyword.define

	
eval_define = (expr, env) ->
	if expr.length() isnt 3
		error "Bad definition"
	name = expr.cadr()
	if is_name name
		value = evaluate expr.caddr(), env
		env.add name, value
	else
		error "Bad variable name '" + name + "'"
	
is_lambda = (expr) ->
	is_special_form expr, keyword.lambda

eval_lambda = (expr, env) ->
	if expr.length() isnt 3
		error "Bad lambda expression : " + expr
	new Procedure expr.cadr(), expr.caddr(), env
	
eval_application = (expr, env) ->
	expr_vals = (evaluate e, env for e in expr.value)
	invoke expr_vals[0], new Form expr_vals[1..]
	
		
