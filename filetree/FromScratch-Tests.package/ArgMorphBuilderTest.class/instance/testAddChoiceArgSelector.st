test
testAddChoiceArgSelector
	| b a |
	b := self newBuilder.
	b addChoiceArg: $x selector: #abc.
	a := b uncoloredArgMorphFor: #(1 $x).
	self assert: (a isKindOf: ArgMorph).
	self assert: a getOptionsSelector equals: #abc.
	self assert: a getOptionsTarget isNil.
	self assert: a choice isEmpty