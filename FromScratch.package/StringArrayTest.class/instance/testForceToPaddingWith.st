test
testForceToPaddingWith
	| a |
	a := self newArray.
	self assert: a size equals: 0.
	a := a forceTo: 2 paddingWith: 'a'.
	self assert: a size equals: 2.
	self assert: (a stringAt: 1) equals: 'a'.
	self assert: (a stringAt: 2) equals: 'a'.
	a stringAt: 1 put: 'c'.
	a stringAt: 2 put: 'd'.
	a := a forceTo: 4 paddingWith: 'b'.
	self assert: a size equals: 4.
	self assert: (a stringAt: 1) equals: 'c'.
	self assert: (a stringAt: 2) equals: 'd'.
	self assert: (a stringAt: 3) equals: 'b'.
	self assert: (a stringAt: 4) equals: 'b'