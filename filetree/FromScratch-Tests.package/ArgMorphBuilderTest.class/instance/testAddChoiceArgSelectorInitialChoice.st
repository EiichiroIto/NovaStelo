test
testAddChoiceArgSelectorInitialChoice
	| b a |
	b := self newBuilder.
	b addChoiceArg: $x selector: #abc initialChoice: 'def'.
	a := b uncoloredArgMorphFor: #(1 $x).
	self assert: (a isKindOf: ArgMorph).
	self assert: a getOptionsSelector equals: #abc.
	self assert: a getOptionsTarget isNil.
	self assert: a choice equals: 'def'