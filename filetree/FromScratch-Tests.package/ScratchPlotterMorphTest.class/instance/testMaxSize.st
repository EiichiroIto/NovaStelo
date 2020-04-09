test
testMaxSize
	| p |
	p := self newPlotter.
	self assert: p maxSize isNil.
	p maxSize: 10.
	self assert: p maxSize equals: 10.
	p maxSize: 2.
	self assert: p maxSize equals: 2.
	self assert: p numData equals: 0.
	p newData.
	p newData.
	self assert: p numData equals: 2.
	p newData.
	self assert: p numData equals: 2