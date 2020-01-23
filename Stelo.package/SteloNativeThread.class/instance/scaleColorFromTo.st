variable ops
scaleColorFromTo
	| v c f t |
	t := self pop.
	f := self pop.
	c := self pop.
	v := self pop.
	world scaleVar: v color: c breed: breedId from: f to: t id: id.