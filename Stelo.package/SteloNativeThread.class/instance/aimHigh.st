turtle ops
aimHigh
	| var ret |
	var := self pop.
	ret := world aimHighPatchVar: var breed: breedId id: id.
	self push: ret.