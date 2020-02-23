test
testGetPatchColorAt
	| w b t ret pno |
	w := self newWorld.
	"
	1 2 3
	4 5 6
	7 8 9
"
	w createPatch: 3.
	w create: 3 turtles: 1.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 3
		put: SColorList green.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 5
		put: SColorList blue.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 6
		put: SColorList yellow.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 7
		put: SColorList red.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 9
		put: SColorList lime.
	b := self newGenerator.
	pno := w patchIndexAtX: 1 y: 2.
	ret := b getPatchColorAt: pno.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: SColorList green.
	b := self newGenerator.
	ret := b getPatchColorAt: 9.
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: SColorList lime