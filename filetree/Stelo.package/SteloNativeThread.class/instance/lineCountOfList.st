list ops
lineCountOfList
	| vno ret |
	vno := self pop.
	ret := world
		var: vno
		breed: breedId
		listSizeOf: id.
	self push: ret