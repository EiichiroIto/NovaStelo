test
testSize
	| a |
	a := self newArray.
	self assert: a size equals: 0.
	a := a forceTo: 1 paddingWith: ''.
	self assert: a size equals: 1