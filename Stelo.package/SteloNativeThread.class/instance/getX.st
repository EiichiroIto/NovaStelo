variable ops
getX
	| ret |
	ret := world x: breedId at: id.
	self push: ret.