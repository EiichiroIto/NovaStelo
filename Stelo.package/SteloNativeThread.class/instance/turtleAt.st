turtle ops
turtleAt
	| x y ret bid pno |
	bid := self pop.
	pno := self pop.
	x := world patches xAt: pno.
	y := world patches yAt: pno.
	ret := world turtle: bid x: x y: y exceptBreed: breedId index: id.
	self push: ret.