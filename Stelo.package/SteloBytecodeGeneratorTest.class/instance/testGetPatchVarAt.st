test
testGetPatchVarAt
	| w b vid t ret pno |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	vid := w patches addVariable: 'a'.
	w patches var: vid at: 5 put: 4.
	w patches var: vid at: 2 put: 8.
	b := self newGenerator.
	pno := w patchIndexAtX: 0 y: 0.
	ret := b getPatchVar: vid at: pno.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 4.
	w y: 3 at: 1 put: -1.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 4.