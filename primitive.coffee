exports.plus = (operands) ->
	ret = 0
	ret += elem for elem in operands
	ret
exports.times = (operands) ->
	ret = 1
	ret *= elem for elem in operands
	ret
	
exports.minus = (operands) ->
	return - operands[0] if operands.length is 1
	return operands[0] - operands[1] if operands.length is 2
	
exports.equals = (operands) ->
	operands[0] is operands[1]
	
exports.zero = (operands) ->
	operands[0] is 0
	
exports.greater = (operands) ->
	operands[0] > operands[1]
	
exports.less = (operands) ->
	operands[0] < operands[1]
	
exports.lisp_and = (operands) ->
	operands[0] and operands[1]
	
exports.lisp_or = (operandds) ->
	operands[0] or operands[1]

exports.lisp_not = (operands) ->
	not operands[0]
	
exports.car = (operands) ->
	operands[0][0]

exports.cdr = (operands) ->
	operands[0][1..]

exports.cons = (operands) ->
	value = operands[0]
	ret = operands[1][0..]
	ret.unshift value
	ret
	
exports.display = (operands) ->
	console.log operands