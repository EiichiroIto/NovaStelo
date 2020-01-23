test
testAddPenColor
	| p |
	p := self newPlotter.
	self assert: p pens size equals: 1.
	self assert: p pens first equals: Color blue.
	p addPen: 1 color: Color red.
	self assert: p pens first equals: Color red.
	p addPen: 3 color: Color black.
	self assert: p pens third equals: Color black