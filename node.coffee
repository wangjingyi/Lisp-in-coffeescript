exports.Form = class Form 
	constructor : (@value=[], @is_list=false) ->
	add : (elem) ->
		@value.push elem
		this
	car : -> @value[0]
	cadr : -> @value[1]
	caddr : -> @value[2]
	cadddr : -> @value[3]
	cdr : -> new Form @value[1..]
	cddr : -> new Form @value[2..]
	cons : (elem) ->
		copy = @value[0..]
		copy.unshift elem
		new Form copy
		
	length : -> @value.length
	quote : -> @is_list = true

	to_array : ->
		ret = []
		for e in @value
			if e instanceof Form
				ret.push e.to_array()
			else if e instanceof Str
				ret.push "^^" + e.value + "^^"
			else
				ret.push e
		ret

exports.Str = class Str
	constructor : (@value) ->

exports.Sym = class Sym
	constructor : (@value) ->
		
exports.Procedure = class Procedure
		constructor : (@params, @body, @env) ->
