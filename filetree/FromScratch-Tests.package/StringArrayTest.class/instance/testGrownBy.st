test
testGrownBy
	| a |
	a := self newArray.
	self assert: a size equals: 0.
	a := a grownBy: 1.
	self assert: a size equals: 1.
	self assert: (a stringAt: 1) equals: ''.
	a := a grownBy: 2.
	self assert: a size equals: 3.
	self assert: (a stringAt: 1) equals: ''.
	self assert: (a stringAt: 2) equals: ''.
	self assert: (a stringAt: 3) equals: ''