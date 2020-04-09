test
testAddBooleanArg
	| b |
	b := self newBuilder.
	b addBooleanArg: $b.
	self assert: (b privDict at: $b) isBlock.
	self
		assert: ((b uncoloredArgMorphFor: #(1 $b)) isKindOf: BooleanArgMorph)