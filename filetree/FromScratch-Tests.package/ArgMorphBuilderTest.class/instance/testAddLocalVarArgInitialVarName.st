test
testAddLocalVarArgInitialVarName
	| b a |
	b := self newBuilder.
	b addLocalVarArg: $l initialVarName: 'abc'.
	self assert: (b privDict at: $l) isBlock.
	a := b uncoloredArgMorphFor: #(1 $l).
	self assert: (a isKindOf: LocalVarArgMorph).
	self assert: a evaluate equals: 'abc'