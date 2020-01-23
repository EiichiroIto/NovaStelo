turtle ops
setY
	| v |
	breedId <= SBreedId patchBreedNo
		ifTrue: [ ^ self ].
	v := self pop.
	world y: breedId at: id put: v