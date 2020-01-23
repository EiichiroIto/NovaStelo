test
testDoDoubleClickAt
	| d x |
	d := self newDisplay.
	d
		cell: 1 @ 1;
		offset: 0 @ 0;
		modelExtent: 100 @ 100;
		whenDoubleClickDo: [ :p | x := p ].
	d doDoubleClickAt: 0 @ 0.
	self assert: x equals: -50 @ 49