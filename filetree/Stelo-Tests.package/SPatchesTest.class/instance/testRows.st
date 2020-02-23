tests-accessing
testRows
	| ps |
	ps := SPatches new.
	self assert: ps rows equals: ps defaultOrder.
	ps create: 120.
	self assert: ps rows equals: 120.