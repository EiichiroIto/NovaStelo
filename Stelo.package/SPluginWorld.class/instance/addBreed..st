accessing
addBreed: aBreed
	| bno |
	bno := aBreed breedNo.
	plugin setupBreed: bno.
	bno = SBreedId patchBreedNo
		ifTrue: [ plugin createPatch: aBreed order ].
	bno = SBreedId turtleBreedNo
		ifTrue: [ plugin create: bno turtles: aBreed size ].
	self addVariablesFor: aBreed.
	self setAllVariables: aBreed