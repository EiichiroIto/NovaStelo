test
testListContains
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
	self assert: (a list: 5 contains: 10).
	self assert: (a list: 5 contains: 20).
	self assert: (a list: 5 contains: 30).
	self deny: (a list: 5 contains: 0).
	self deny: (a list: 5 contains: 40).