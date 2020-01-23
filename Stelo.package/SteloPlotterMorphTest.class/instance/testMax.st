test
testMax
	| p |
	p := self newPlotter.
	self assert: p max isNil.
	p max: 123.
	self assert: p max equals: 123.
	p max: 456.
	self assert: p max equals: 456