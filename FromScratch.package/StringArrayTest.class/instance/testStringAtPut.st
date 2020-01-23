test
testStringAtPut
	| a |
	a := self newArray.
	a := a forceTo: 3 paddingWith: ''.
	a stringAt: 1 put: 'a'.
	a stringAt: 2 put: 'b'.
	a stringAt: 3 put: 'c'.
	self assert: (a stringAt: 1) equals: 'a'.
	self assert: (a stringAt: 2) equals: 'b'.
	self assert: (a stringAt: 3) equals: 'c'.
	self should: [ a stringAt: 4 ] raise: Error