test
testInitialize
	| p |
	p := self newPlotter.
	self assert: p data isCollection.
	self assert: p last isNil.
	self assert: p colors isArray