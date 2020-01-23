test
testListRemove
	| a |
	a := self newArray: #Array.
	a defaultValue: 0.
	self assert: (a list: 5 at: 2) equals: 0.
	a list: 5 add: 10.
	a list: 5 add: 20.
	a list: 5 add: 30.
	self assert: (a list: 5 at: 1) equals: 10.
	self assert: (a list: 5 at: 2) equals: 20.
	self assert: (a list: 5 at: 3) equals: 30.
	a list: 5 remove: 2.
	self assert: (a list: 5 at: 1) equals: 10.
	self assert: (a list: 5 at: 2) equals: 30.
	self assert: (a listSizeOf: 5) equals: 2.