test
testPatchIndexAtXY
	| c r |
	c := SteloLibCall new.
	c createPatch: 10.
	r := c patchIndexAtX: -5 y: -5.
	self assert: r equals: 1.
	r := c patchIndexAtX: -4 y: -5.
	self assert: r equals: 2.
	r := c patchIndexAtX: 4 y: 4.
	self assert: r equals: 100.
	r := c patchIndexAtX: 0 y: 0.
	self assert: r equals: 56.