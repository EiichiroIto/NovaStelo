test
testAddChoiceArgSelectorTargetInitialChoice
	| b a |
	b := self newBuilder.
	b addChoiceArg: $x selector: #abc target: self initialChoice: 'def'.
	a := b uncoloredArgMorphFor: #(1 $x).
	self assert: (a isKindOf: ArgMorph).
	self assert: a getOptionsSelector equals: #abc.
	self assert: a getOptionsTarget equals: self.
	self assert: a choice equals: 'def'