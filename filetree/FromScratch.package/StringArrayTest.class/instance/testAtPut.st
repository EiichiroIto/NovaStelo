test
testAtPut
	| a |
	a := self newArray.
	a forceTo: 1 paddingWith: ''.
	self assert: (a at: 1) equals: 1.
	a at: 1 put: 2.
	self assert: (a at: 1) equals: 2