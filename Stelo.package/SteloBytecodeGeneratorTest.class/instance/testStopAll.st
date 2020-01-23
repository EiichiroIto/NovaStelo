test
testStopAll
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 1.
	b := self newGenerator.
	b stopAll.
	b die.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	self assert: t isTerminated.