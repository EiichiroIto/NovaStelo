list ops
listContains
	| vno val ret |
	val := self pop.
	vno := self pop.
	ret := world
		var: vno
		breed: breedId
		list: id
		contains: val.
	self push: ret