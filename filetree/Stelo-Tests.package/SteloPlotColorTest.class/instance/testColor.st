test
testColor
	| p |
	p := self newPlotColor.
	self assert: p color isNil.
	p color: Color red.
	self assert: p color equals: Color red.
	p color: Color blue.
	self assert: p color equals: Color blue