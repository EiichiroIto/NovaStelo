list ops
appendToList
	| vno val |
	val := self pop.
	vno := self pop.
	world
		var: vno
		breed: breedId
		list: id
		add: val