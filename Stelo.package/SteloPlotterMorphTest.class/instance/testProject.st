test
testProject
	| p |
	p := self newPlotter.
	self assert: p project isNil.
	p project: 123.
	self assert: p project equals: 123.
	p project: 456.
	self assert: p project equals: 456