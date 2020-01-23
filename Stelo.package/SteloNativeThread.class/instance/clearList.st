list ops
clearList
	| vno |
	vno := self pop.
	world
		var: vno
		breed: breedId
		list: id
		set: #()