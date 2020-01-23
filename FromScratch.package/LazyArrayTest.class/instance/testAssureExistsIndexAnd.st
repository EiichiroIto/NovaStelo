test
testAssureExistsIndexAnd
	| a |
	a := self newArray: #Array.
	a defaultValue: 2.
	self assert: a privArray isNil.
	a assureExistsIndex: 10 and: 20.
	self assert: a privArray isArray.
	self assert: a privArray size equals: 100.
	self assert: (a at: 10) isCollection.
	self assert: (a at: 10) size equals: 20.
	self assert: ((a at: 10) at: 1) equals: 2.
	self assert: ((a at: 10) at: 20) equals: 2.