test
testDoUntilBegin
	| w b t i |
	w := self newWorld.
	w create: 3 turtles: 1.
	(w breedOf: 3) headingAt: 1 put: 0.
	b := self newGenerator.
	i := b doUntilBegin.
	b forward: 1.
	b appendValue: 5.
	b getXpos.
	b appendSymbol: #less.
	b doUntilEnd: nil id: i.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 6