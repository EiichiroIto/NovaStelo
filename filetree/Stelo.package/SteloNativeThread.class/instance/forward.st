turtle ops
forward
	| step |
	step := self pop.
	world forward: step breed: breedId id: id.