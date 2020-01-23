variable ops
getVar
	| var ret |
	var := self pop.
	ret := world var: var breed: breedId at: id.
	self push: ret.