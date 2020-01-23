test
testSetPatchVarAtTo
	| w b vid t pno |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	vid := w patches addVariable: 'a'.
	self assert: (w patches var: vid at: 2) equals: 0.
	self assert: (w patches var: vid at: 5) equals: 0.
	b := self newGenerator.
	pno := w patchIndexAtX: 0 y: 0.
	b setPatchVar: vid at: pno to: 5.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w patches var: vid at: 2) equals: 0.
	self assert: (w patches var: vid at: 5) equals: 5.
	b := self newGenerator.
	pno := w patchIndexAtX: 0 y: -1.
	b setPatchVar: vid at: pno to: 5.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w patches var: vid at: 2) equals: 5.
	self assert: (w patches var: vid at: 5) equals: 5