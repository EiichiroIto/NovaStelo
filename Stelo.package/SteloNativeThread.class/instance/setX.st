turtle ops
setX
	| v |
	breedId <= SBreedId patchBreedNo
		ifTrue: [ ^ self ].
	v := self pop.
	world x: breedId at: id put: v