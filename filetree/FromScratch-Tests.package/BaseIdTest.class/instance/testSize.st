test
testSize
	| e |
	e := self newBaseId.
	self assert: e size equals: e class reservedNo.
	e newNo.
	self assert: e size equals: e class reservedNo + 1.