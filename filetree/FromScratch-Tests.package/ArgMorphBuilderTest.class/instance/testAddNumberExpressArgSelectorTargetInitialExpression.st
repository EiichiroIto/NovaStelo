test
testAddNumberExpressArgSelectorTargetInitialExpression
	| b a |
	b := self newBuilder.
	b addNumberExpressArg: $x selector: #abc target: self initialExpression: '5'.
	a := b uncoloredArgMorphFor: #(1 $x).
	self assert: (a isKindOf: ExpressionArgMorph).
	self assert: a getOptionsSelector equals: #abc.
	self assert: a getOptionsTarget equals: self.
	self assert: a evaluate equals: 5