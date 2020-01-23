test
testListSizeOf
	| a |
	a := self newArray: #Array.
	a defaultValue: ''.
	self assert: (a listSizeOf: 5) equals: 0.
	a list: 5 at: 2 put: 'a'.
	self assert: (a listSizeOf: 5) equals: 2.
	a list: 5 at: 3 put: 'a'.
	self assert: (a listSizeOf: 5) equals: 3.