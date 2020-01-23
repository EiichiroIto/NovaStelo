test
testAssureExistsIndex
	| a |
	a := self newArray: #Array.
	self assert: a privArray isNil.
	a assureExistsIndex: 10.
	a at: 9 put: 1.
	a at: 10 put: 2.
	self assert: a privArray isArray.
	self assert: a privArray size equals: 100.
	a assureExistsIndex: 20.
	self assert: a privArray isArray.
	self assert: a privArray size equals: 100.
	self assert: (a at: 9) equals: 1.
	self assert: (a at: 10) equals: 2.