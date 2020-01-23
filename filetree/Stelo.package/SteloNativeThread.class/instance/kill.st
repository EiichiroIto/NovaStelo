turtle ops
kill
	| tid bid |
	breedId <= SBreedId patchBreedNo
		ifTrue: [ ^ self ].
	tid := self pop.
	bid := self pop.
	world kill: bid at: tid.
	(breedId = bid and: [ id = tid ])
		ifTrue: [ self stop ]