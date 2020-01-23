variable ops
setVarTo
	| var val |
	val := self pop.
	var := self pop.
	world
		var: var
		breed: breedId
		at: id
		put: val