test
testMin
	| p |
	p := self newPlotter.
	self assert: p min isNil.
	p min: 123.
	self assert: p min equals: 123.
	p min: 456.
	self assert: p min equals: 456