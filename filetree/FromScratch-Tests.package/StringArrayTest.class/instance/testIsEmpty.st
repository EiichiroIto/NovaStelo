test
testIsEmpty
	| a |
	a := self newArray.
	self assert: a isEmpty.
	a := a forceTo: 1 paddingWith: ''.
	self deny: a isEmpty