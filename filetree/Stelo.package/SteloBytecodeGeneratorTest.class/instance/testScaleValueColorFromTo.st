test
testScaleValueColorFromTo
	| w v b t |
	w := self newWorld.
	w addBreed: SObserver new.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b
		scaleValue: v
		color: 15
		from: 1
		to: 9.
	w patches var: v at: 1 put: 0.
	w patches var: v at: 2 put: 1.
	w patches var: v at: 3 put: 2.
	w patches var: v at: 4 put: 3.
	w patches var: v at: 5 put: 4.
	w patches var: v at: 6 put: 5.
	w patches var: v at: 7 put: 6.
	w patches var: v at: 8 put: 7.
	w patches var: v at: 9 put: 8.
	w patches var: v at: 10 put: 9.
	w patches var: v at: 11 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 1)
		equals: SColorList black.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 6)
		equals: SColorList red - 1.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 7)
		equals: SColorList red.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 8)
		equals: SColorList red + 1.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 11)
		equals: SColorList white.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 12)
		equals: SColorList black.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 13)
		equals: SColorList black.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 14)
		equals: SColorList black.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 15)
		equals: SColorList black.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 16)
		equals: SColorList black