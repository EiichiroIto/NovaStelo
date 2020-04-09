test
testAddNumberExpressArgInitialExpression
	| b a |
	b := self newBuilder.
	b addNumberExpressArg: $e initialExpression: '10'.
	self assert: (b privDict at: $e) isBlock.
	a := b uncoloredArgMorphFor: #(1 $e).
	self assert: (a isKindOf: ExpressionArgMorph).
	self assert: a evaluate equals: 10