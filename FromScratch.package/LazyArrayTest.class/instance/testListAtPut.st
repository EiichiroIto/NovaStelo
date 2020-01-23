test
testListAtPut
	| a |
	a := self newArray: #Array.
	a defaultValue: ''.
	self assert: (a list: 5 at: 2) equals: ''.
	a list: 5 at: 2 put: 'a'.
	a list: 5 at: 3 put: 'b'.
	self assert: (a list: 5 at: 1) equals: ''.
	self assert: (a list: 5 at: 2) equals: 'a'.
	self assert: (a list: 5 at: 3) equals: 'b'