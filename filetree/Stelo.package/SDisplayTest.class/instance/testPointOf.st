test
testPointOf
	| d |
	d := self newDisplay.
	d
		cell: 1 @ 1;
		offset: 0 @ 0;
		modelExtent: 100 @ 100.
	self assert: (d pointOf: 0 @ 0) equals: -50 @ 49.
	self assert: (d pointOf: 99 @ 99) equals: 49 @ -50.
	self assert: (d pointOf: 0 @ 99) equals: -50 @ -50.
	self assert: (d pointOf: 99 @ 0) equals: 49 @ 49