test
testStringAt
	| a |
	a := self newArray: #StringArray.
	a stringAt: 1 put: 'abc'.
	self assert: (a stringAt: 1) equals: 'abc'.
	self assert: (a stringAt: 2) equals: ''