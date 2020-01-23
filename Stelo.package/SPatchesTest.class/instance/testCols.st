tests-accessing
testCols
	| ps |
	ps := SPatches new.
	self assert: ps cols equals: ps defaultOrder.
	ps create: 120.
	self assert: ps cols equals: 120.