test
testCell
	| d |
	d := self newDisplay.
	self assert: d cell isNil.
	d cell: 1 @ 2.
	self assert: d cell equals: 1 @ 2.
	d cell: 3 @ 4.
	self assert: d cell equals: 3 @ 4