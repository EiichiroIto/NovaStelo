test
testModelExtent
	| d |
	d := self newDisplay.
	self assert: d modelExtent isNil.
	d modelExtent: 1 @ 2.
	self assert: d modelExtent equals: 1 @ 2