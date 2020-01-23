variable ops
getY
	| ret |
	ret := world y: breedId at: id.
	self push: ret.