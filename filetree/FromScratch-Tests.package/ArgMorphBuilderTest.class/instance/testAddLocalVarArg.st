test
testAddLocalVarArg
	| b a |
	b := self newBuilder.
	b addLocalVarArg: $l.
	self assert: (b privDict at: $l) isBlock.
	a := b uncoloredArgMorphFor: #(1 $l).
	self assert: (a isKindOf: LocalVarArgMorph).
	self assert: a evaluate equals: 'x'.
	a varName: 'abc'.
	self assert: a evaluate equals: 'abc'