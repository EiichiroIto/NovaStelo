test
testSelector
	| c |
	c := self newSymbol: #abc.
	self assert: c selector equals: #abc.
	c selector: #def.
	self assert: c selector equals: #def.