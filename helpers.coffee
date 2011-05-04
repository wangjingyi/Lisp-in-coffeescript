exports.error = (str) ->
	console.log str
	
exports.zip = (l1, l2) ->
    ret = []
    for i in [0...Math.min l1.length, l2.length]
        ret.push [l1[i], l2[i]]
    ret

exports.map = (f, l) ->
    (f e for e in l)

exports.fold_left = fold_left = (f, acc, l) ->
	acc = f acc, e for e in l
	acc
	
exports.fold_right = (f, l, acc) ->
	reversed = l.reverse()
	acc = f e, acc for e in reversed
	acc
	
exports.reduce = (f, l, acc=undefined) ->
	if acc
		fold_left f, acc, l
	else
		fold_left f, l[0], l[1..]
