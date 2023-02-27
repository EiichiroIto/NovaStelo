Class {
	#name : #ScratchBytecodeGeneratorTest,
	#superclass : #TestCase,
	#category : #'Microworld-Tests'
}

{ #category : #private }
ScratchBytecodeGeneratorTest >> newGenerator [
	^ ScratchBytecodeGenerator new
]

{ #category : #private }
ScratchBytecodeGeneratorTest >> newThread [
	^ ScratchNativeThread new
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testAddress [
	| b |
	b := self newGenerator.
	self assert: b address equals: 1.
	b address: 100.
	self assert: b address equals: 100.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testAddressOfSubName [
	| b d |
	b := self newGenerator.
	self should: [ b addressOfSubName: 'abc' ] raise: Error.
	d := Dictionary new.
	b subTable: d.
	self should: [ b addressOfSubName: 'abc' ] raise: Error.
	d at: 'abc' put: 123.
	d at: 'def' put: 456.
	self assert: (b addressOfSubName: 'abc') equals: 123.
	self assert: (b addressOfSubName: 'def') equals: 456.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testAppendCall [
	| b r |
	b := self newGenerator.
	b subTable: { 'def'->123 } asDictionary.
	self assert: b stream contents isEmpty.
	b appendCall: 'def'.
	self assert: b stream contents size equals: 1.
	r := b stream contents first.
	self assert: r class equals: ScratchBytecodeCall.
	self assert: r subName equals: 'def'.
	self assert: r address equals: 123.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testAppendLabel [
	| b r |
	b := self newGenerator.
	self assert: b stream contents isEmpty.
	b appendLabel: 123.
	b appendLabel: 456.
	self assert: b stream contents size equals: 2.
	r := b stream contents first.
	self assert: r class equals: ScratchBytecodeLabel.
	self assert: r id equals: 123.
	r := b stream contents second.
	self assert: r class equals: ScratchBytecodeLabel.
	self assert: r id equals: 456.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testAppendSymbol [
	| b r |
	b := self newGenerator.
	self assert: b stream contents isEmpty.
	b appendSymbol: #abc.
	b appendSymbol: #def.
	self assert: b stream contents size equals: 2.
	r := b stream contents first.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
	r := b stream contents second.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #def.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testAppendSymbolWithJump [
	| b r |
	b := self newGenerator.
	self assert: b stream contents isEmpty.
	b appendSymbol: #abc withJump: 12.
	b appendSymbol: #def withJump: 34.
	self assert: b stream contents size equals: 2.
	r := b stream contents first.
	self assert: r class equals: ScratchBytecodeSymbolWithJump.
	self assert: r selector equals: #abc.
	self assert: r labelId equals: 12.
	r := b stream contents second.
	self assert: r class equals: ScratchBytecodeSymbolWithJump.
	self assert: r selector equals: #def.
	self assert: r labelId equals: 34.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testAppendValue [
	| b r |
	b := self newGenerator.
	self assert: b stream contents isEmpty.
	b appendValue: 123.
	b appendValue: 456.
	self assert: b stream contents size equals: 2.
	r := b stream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b stream contents second.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 456.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testBinaryCommandArg1Arg2 [
	| b r |
	b := self newGenerator.
	self assert: b stream contents isEmpty.
	b binaryCommand: #abc arg1: 123 arg2: 456.
	self assert: b stream contents size equals: 3.
	r := b stream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b stream contents second.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 456.
	r := b stream contents third.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testCode [

	| b arr |
	b := self newGenerator.
	arr := b code.
	self assertCollection: arr equals: #( stop )
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testLabelId [

	| b x |
	b := self newGenerator.
	self assert: (b labelId isKindOf: BaseId).
	x := BaseId new.
	self deny: b labelId identicalTo: x.
	b labelId: x.
	self assert: b labelId identicalTo: x
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testLabelsAndJumpsFor [
	| b arr |
	b := self newGenerator.
	b appendLabel: b labelId newNo.
	b appendValue: 1.
	b appendValue: 2.
	b appendLabel: b labelId newNo.
	b appendSymbol: #a.
	b appendLabel: b labelId newNo.
	b appendValue: 2.
	b appendSymbol: #a withJump: 1.

	arr := b labelsAndJumpsFor: b stream contents.

	self assertCollection: arr first equals: #(1 5 6).
	self assert: arr second size equals: 1.
	self assert: arr second first selector equals: #a.
	self assert: b address equals: 13.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testLiteralStringFrom [

	| gen |
	gen := self newGenerator.
	self assert: (gen literalStringFrom: 'abc') equals: 0.
	self assert: (gen literalStringFrom: 123) equals: 123.
	self assert: (gen literalStringFrom: '456') equals: 456
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testNullaryCommand [
	| b r |
	b := self newGenerator.
	self assert: b stream contents isEmpty.
	b nullaryCommand: #abc.
	self assert: b stream contents size equals: 1.
	r := b stream contents first.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testResolveJumpAddressUsing [
	| b fp arr |
	b := self newGenerator.
	b appendLabel: b labelId newNo.
	b appendValue: 1.
	b appendValue: 2.
	b appendSymbol: #a withJump: 3.
	b appendLabel: b labelId newNo.
	b appendSymbol: #b.
	b appendLabel: b labelId newNo.
	b appendValue: 2.
	b appendSymbol: #c withJump: 2.
	fp := b stream contents.

	self assert: (fp at: 4) address equals: nil.
	self assert: (fp at: 9) address equals: nil.

	arr := b labelsAndJumpsFor: fp.
	b resolveJumpAddress: arr second using: arr first.

	self assert: (fp at: 4) address equals: 10.
	self assert: (fp at: 9) address equals: 9.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testScript [

	| b x |
	b := self newGenerator.
	self assert: b script isNil.
	x := ScratchScript new.
	b script: x.
	self assert: b script identicalTo: x
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testStream [

	| b x |
	b := self newGenerator.
	self assert: b stream isStream.
	x := WriteStream on: String new.
	self deny: b stream identicalTo: x.
	b stream: x.
	self assert: b stream identicalTo: x
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testSubTable [
	| b d |
	b := self newGenerator.
	self assert: b subTable isNil.
	d := Dictionary new.
	b subTable: d.
	self assert: b subTable equals: d.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testTernaryCommandArg1Arg2Arg3 [
	| b r |
	b := self newGenerator.
	self assert: b stream contents isEmpty.
	b ternaryCommand: #abc arg1: 123 arg2: 456 arg3: 789.
	self assert: b stream contents size equals: 4.
	r := b stream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b stream contents second.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 456.
	r := b stream contents third.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 789.
	r := b stream contents fourth.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testUnaryCommandArg [
	| b r |
	b := self newGenerator.
	self assert: b stream contents isEmpty.
	b unaryCommand: #abc arg: 123.
	self assert: b stream contents size equals: 2.
	r := b stream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b stream contents second.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
]
