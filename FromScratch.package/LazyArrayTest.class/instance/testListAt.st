test
testListAt
	| a |
	a := self newArray: #Array.
	a defaultValue: ''.
	self assert: (a list: 5 at: 2) equals: ''.
	self assert: a privArray size equals: 100.
	self assert: a privArray first equals: nil.
	self assert: a privArray fifth equals: nil.
	a assureExistsIndex: 5 and: 3.
	self assert: (a list: 5 at: 2) equals: ''.
	self assert: a privArray fifth class equals: OrderedCollection.
	self assert: a privArray fifth size equals: 3.
	self assert: a privArray fifth first equals: ''.
	self assert: a privArray fifth second equals: ''.
	self assert: a privArray fifth third equals: ''.