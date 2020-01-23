test
testInitialize
	| a |
	a := self newArray.
	self assert: (a privArray isKindOf: IntegerArray).
	self assert: a privLiterals isArray.
	self assert: a privInvLiterals isNil