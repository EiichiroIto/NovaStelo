test
testStringAtPut
	| a |
	a := self newArray: #StringArray.
	a stringAt: 1 put: 'abc'.
	a stringAt: 2 put: 'def'.
	self assert: (a stringAt: 1) equals: 'abc'.
	self assert: (a stringAt: 2) equals: 'def'