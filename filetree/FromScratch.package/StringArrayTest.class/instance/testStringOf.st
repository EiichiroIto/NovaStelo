test
testStringOf
	| a |
	a := self newArray.
	self assert: (a stringOf: 0) equals: ''.
	a forceTo: 1 paddingWith: 'a'.
	self assert: (a stringOf: 1) equals: 'a'