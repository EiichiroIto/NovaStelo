test
testGetColor
	| w b t ret |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	w
		var: STurtleVarDef colorVarNo
		breed: 3
		at: 1
		put: SColorList red.
	w
		var: STurtleVarDef colorVarNo
		breed: 3
		at: 2
		put: SColorList yellow.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 1
		put: SColorList green.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 2
		put: SColorList blue.
	b := self newGenerator.
	ret := b getColor.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: SColorList red.
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: SColorList blue