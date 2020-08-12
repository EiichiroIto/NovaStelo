test
testTextAt
	| t |
	t := self newTranslator.
	self assert: (t textAt: 'abc') equals: 'abc'.
	t textAt: 'abc' put: 'def'.
	self assert: (t textAt: 'abc') equals: 'def'