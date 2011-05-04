exports.keyword = 
	if : "if"
	lambda : "lambda"
	define : "define"
	begin : "begin"
	quote : "quote"
	cond : "cond"
	set : "set!"
	
	is_keyword : (name) ->
		name of this
		
	isnt_keyword : (name) ->
		not @is_keyword name

