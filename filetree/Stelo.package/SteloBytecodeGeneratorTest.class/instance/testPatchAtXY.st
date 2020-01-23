test
testPatchAtXY
	| w b t |
	w := self newWorld.
	w createPatch: 3.

	b := self newGenerator.
	b patchAtX: 0 y: 0.
	t := self newThread: w.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 5.

	b := self newGenerator.
	b patchAtX: -1 y: 1.
	t := self newThread: w.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 7.