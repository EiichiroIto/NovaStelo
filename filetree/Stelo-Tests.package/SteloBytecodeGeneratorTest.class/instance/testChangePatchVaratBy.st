test
testChangePatchVaratBy
	| w b vid t pno |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	vid := w patches addVariable: 'a'.
	w patches var: vid at: 2 put: 1.
	w patches var: vid at: 5 put: 2.
	b := self newGenerator.
	pno := w patchIndexAtX: 0 y: 0.
	b changePatchVar: vid at: pno by: 5.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w patches var: vid at: 2) equals: 1.
	self assert: (w patches var: vid at: 5) equals: 7.
	w y: 3 at: 1 put: -1.
	b := self newGenerator.
	pno := w patchIndexAtX: 0 y: -1.
	b changePatchVar: vid at: pno by: 5.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w patches var: vid at: 2) equals: 6.
	self assert: (w patches var: vid at: 5) equals: 7