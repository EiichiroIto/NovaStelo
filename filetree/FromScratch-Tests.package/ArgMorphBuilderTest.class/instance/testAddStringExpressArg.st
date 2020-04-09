test
testAddStringExpressArg
	| b a |
	b := self newBuilder.
	b addStringExpressArg: $e.
	self assert: (b privDict at: $e) isBlock.
	a := b uncoloredArgMorphFor: #(1 $e).
	self assert: (a isKindOf: ExpressionArgMorph).
	self assert: a evaluate equals: ''