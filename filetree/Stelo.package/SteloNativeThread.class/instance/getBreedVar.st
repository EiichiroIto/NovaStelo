variable ops
getBreedVar
	| var index bno ret |
	bno := self pop.
	var := self pop.
	index := self pop.
	ret := world var: var breed: bno at: index.
	self push: ret.