variable ops
setBreedVarTo
	| var val index bno |
	bno := self pop.
	var := self pop.
	val := self pop.
	index := self pop.
	world
		var: var
		breed: bno
		at: index
		put: val