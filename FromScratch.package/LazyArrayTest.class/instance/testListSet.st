test
testListSet
	| a |
	a := self newArray: #Array.
	a defaultValue: 0.
	a list: 5 set: #(10 20 30).
	self assert: (a list: 5 at: 1) equals: 10.
	self assert: (a list: 5 at: 2) equals: 20.
	self assert: (a list: 5 at: 3) equals: 30