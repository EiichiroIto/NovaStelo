list ops
setLineOfListTo
	| vno val index |
	vno := self pop.
	val := self pop.
	index := self pop.
	world
		var: vno
		breed: breedId
		list: id
		at: index
		put: val