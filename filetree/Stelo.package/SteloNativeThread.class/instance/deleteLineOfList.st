list ops
deleteLineOfList
	| vno index |
	index := self pop.
	vno := self pop.
	world
		var: vno
		breed: breedId
		list: id
		remove: index