{Form, Str} = require './node'

exports.parser = parser =
	tokenize : (str) ->
		ret = []
		reg = /[()]|\".*\"|\s*([^()"\s])+\s*/g
		ret.push match[0].trim() while match = reg.exec str
		ret

	parse : (str) ->
		parse_tokens = (tokens) ->
			stack = [new Form]
			while tokens.length > 0
				token = tokens.shift()
				switch token
					when "(" 
						stack.push new Form
					when ")"
						e1 = stack.pop()
						if e1 not instanceof Form
							error "unmatched close paren"
						e2 = stack.pop()
						if e2 not instanceof Form
							error "parsing error."
						stack.push e2.add e1
					else
						e = stack.pop()
						token = new Str token[1...-1] if token[0] is "\"" and token[token.length - 1] is "\""
						stack.push e.add token
			stack.pop()	
		parse_tokens @tokenize str