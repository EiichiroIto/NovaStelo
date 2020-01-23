list ops
getLineOfList
	| vno index ret |
	index := self pop.
	vno := self pop.
	ret := world
		var: vno
		breed: breedId
		list: id
		at: index.
	self push: ret