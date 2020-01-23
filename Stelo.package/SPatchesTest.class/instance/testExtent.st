tests-accessing
testExtent
	| ps |
	ps := SPatches new.
	self assert: ps extent equals: (1 @ 1) * ps defaultOrder.
	ps create: 120.
	self assert: ps extent equals: 120 @ 120.