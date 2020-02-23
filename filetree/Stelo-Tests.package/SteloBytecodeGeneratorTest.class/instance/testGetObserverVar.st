test
testGetObserverVar
	| w b t ret |
	w := self newWorld.
	w addBreed: SObserver new.
	w create: 3 turtles: 1.
	b := self newGenerator.
	ret := b getObserverVar: SObserverVarDef widthVarNo.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 100.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	w createPatch: 10.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10