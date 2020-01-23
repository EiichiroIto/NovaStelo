variable ops
setHeading
	| degrees |
	breedId <= SBreedId patchBreedNo
		ifTrue: [ ^ self ].
	degrees := self pop.
	world var: STurtleVarDef headingVarNo breed: SBreedId turtleBreedNo at: id put: degrees.