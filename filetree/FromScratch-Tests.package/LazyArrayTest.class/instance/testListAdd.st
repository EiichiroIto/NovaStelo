test
testListAdd
	| a |
	a := self newArray: #Array.
	a defaultValue: 0.
	self assert: (a list: 5 at: 2) equals: 0.
	a list: 5 add: 10.
	a list: 5 add: 20.
	self assert: (a list: 5 at: 1) equals: 10.
	self assert: (a list: 5 at: 2) equals: 20.