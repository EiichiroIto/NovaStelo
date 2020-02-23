test
testClearTurtles
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 2.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 1
		put: 3.
	b := self newGenerator.
	b clearTurtles.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 0