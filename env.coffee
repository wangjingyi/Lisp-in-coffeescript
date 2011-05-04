{error} = require './helpers'
exports.Env = class Env
	constructor : (@parent=null) ->
		@frame = {}
	add: (name, value) ->
		@frame[name] = value
	lookup : (name) ->
		return @frame[name] if name of @frame
		return @parent.lookup name if @parent?
		error "undefined variable"
