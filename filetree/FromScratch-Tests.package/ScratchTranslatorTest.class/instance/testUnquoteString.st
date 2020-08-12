test
testUnquoteString
	| t |
	t := self newTranslator.
	self assert: (t unquoteString: '') isEmpty.
	self assert: (t unquoteString: 'abc') equals: 'abc'.
	self assert: (t unquoteString: '  abc   ') equals: 'abc'.
	self assert: (t unquoteString: '  "abc"   ') equals: 'abc'.
	self assert: (t unquoteString: '  "abc   ') equals: 'abc'.
	self assert: (t unquoteString: '  abc"   ') equals: 'abc'