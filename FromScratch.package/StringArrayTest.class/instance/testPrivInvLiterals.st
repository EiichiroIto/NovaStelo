test
testPrivInvLiterals
	| a |
	a := self newArray.
	self assert: a privInvLiterals isNil.
	a invLiterals.
	self assert: a privInvLiterals isDictionary.
	a privInvLiterals: nil.
	self assert: a privInvLiterals isNil