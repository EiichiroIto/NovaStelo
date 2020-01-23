test
testPrivArray
	| a |
	a := self newArray.
	self assert: (a privArray isKindOf: IntegerArray)