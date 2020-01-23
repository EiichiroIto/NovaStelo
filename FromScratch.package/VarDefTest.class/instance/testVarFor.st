test
testVarFor
	| v |
	v := self newVarDef.
	v addVariable: 'abc'.
	v addVariable: 'def'.
	v addVariable: 'ghi'.
	self assert: (v varNoFor: 'abc') equals: 1.
	self assert: (v varNoFor: 'def') equals: 2.
	self assert: (v varNoFor: 'ghi') equals: 3.
	self should: [v varNoFor: 'aaa'] raise: NotFound.
	self should: [v varNoFor: 'bbb'] raise: NotFound.