tests-accessing
testOrder
	| ps |
	ps := SPatches new.
	self assert: ps order equals: ps defaultOrder.
	ps create: 120.
	self assert: ps order equals: 120.