Class {
	#name : #ScratchBytecodeGeneratorTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
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
ScratchBytecodeGeneratorTest >> testAndWith [
	| t b r |
	b := self newGenerator.
	r := b and: true with: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b and: true with: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b and: false with: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b and: false with: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testAppendCall [
	| b r |
	b := self newGenerator.
	b subTable: { 'def'->123 } asDictionary.
	self assert: b privStream contents isEmpty.
	b appendCall: 'def'.
	self assert: b privStream contents size equals: 1.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeCall.
	self assert: r subName equals: 'def'.
	self assert: r address equals: 123.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testAppendLabel [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b appendLabel: 123.
	b appendLabel: 456.
	self assert: b privStream contents size equals: 2.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeLabel.
	self assert: r id equals: 123.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeLabel.
	self assert: r id equals: 456.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testAppendSymbol [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b appendSymbol: #abc.
	b appendSymbol: #def.
	self assert: b privStream contents size equals: 2.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #def.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testAppendSymbolWithJump [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b appendSymbol: #abc withJump: 12.
	b appendSymbol: #def withJump: 34.
	self assert: b privStream contents size equals: 2.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeSymbolWithJump.
	self assert: r selector equals: #abc.
	self assert: r labelId equals: 12.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeSymbolWithJump.
	self assert: r selector equals: #def.
	self assert: r labelId equals: 34.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testAppendValue [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b appendValue: 123.
	b appendValue: 456.
	self assert: b privStream contents size equals: 2.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 456.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testBinaryCommandArg1Arg2 [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b binaryCommand: #abc arg1: 123 arg2: 456.
	self assert: b privStream contents size equals: 3.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 456.
	r := b privStream contents third.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testCallSub [
	| b r |
	b := self newGenerator.
	b subTable: { 'abc'->9. 'def'->3 } asDictionary.
	b return: 1.
	b callSub: 'def'.
	b address: 5.
	r := b code.
	self assertCollection: r equals: #(push1 return pushShort 3 0 call stop).
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testCode [
	| b arr |
	b := self newGenerator.
	b plus: 1 and: 2.
	b minus: 3 with: 5.
	arr := b code.
	self
		assertCollection: arr
		equals: #(push1 pushShort 2 0 plus pushShort 3 0 pushShort 5 0 minus stop)
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testComputeFunctionOf [
	| t b r |
	b := self newGenerator.
	r := b computeFunction: #abs of: -1.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b computeFunction: #abs of: 10.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b computeFunction: #sqrt of: 2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2 sqrt.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testDivideBy [
	| t b r |
	b := self newGenerator.
	r := b divide: 100 by: 2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 50.

	b := self newGenerator.
	r := b divide: 12 by: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 4.

	b := self newGenerator.
	r := b divide: 10 by: -2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -5.

	b := self newGenerator.
	r := b divide: 1 by: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.2.

	b := self newGenerator.
	r := b divide: 2 by: -4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -0.5.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testDoIfBegin [
	| b t i r |
	b := self newGenerator.
	b appendValue: 1.
	b appendValue: false.
	i := b doIfBegin: nil.
	b appendValue: 1.
	b appendSymbol: #plus.
	b doIfEnd: i.
	t := self newThread.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r equals: 1.
	b := self newGenerator.
	b appendValue: 1.
	b appendValue: true.
	i := b doIfBegin: nil.
	b appendValue: 1.
	b appendSymbol: #plus.
	b doIfEnd: i.
	t := self newThread.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r equals: 2.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testDoIfElse [
	| r b t i |
	b := self newGenerator.
	b appendValue: 1.
	b appendValue: false.
	i := b doIfBegin: nil.
	b appendValue: 1.
	b appendSymbol: #plus.
	i := b doIfElse: i.
	b appendValue: 2.
	b appendSymbol: #plus.
	b doIfEnd: i.
	t := self newThread.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r equals: 3.

	b := self newGenerator.
	b appendValue: 1.
	b appendValue: true.
	i := b doIfBegin: nil.
	b appendValue: 1.
	b appendSymbol: #plus.
	i := b doIfElse: i.
	b appendValue: 2.
	b appendSymbol: #plus.
	b doIfEnd: i.
	t := self newThread.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r equals: 2.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testDoIfEnd [
	self testDoIfBegin.
	self testDoIfElse.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testDoRepeatBegin [
	| b t arr |
	b := self newGenerator.
	b appendValue: false.
	arr := b doRepeatBegin: 5.
	b doRepeatEndLabels: arr.
	t := self newThread.
	t codes: b code.
	t execute: 1.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testDoRepeatEndLabels [
	self testDoRepeatBegin.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testDoUntilBegin [
	| b t i |
	b := self newGenerator.
	i := b doUntilBegin.
	b appendValue: true.
	b doUntilEnd: nil id: i.
	t := self newThread.
	t codes: b code.
	t execute: 1.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testDoUntilEndId [
	self testDoUntilBegin.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testEqualTo [
	| t b r |
	b := self newGenerator.
	r := b equal: 12 to: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b equal: 10 to: -3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b equal: 5 to: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b equal: -2.5 to: -2.5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testGetId [
	| g |
	g := self newGenerator.
	g getId.
	self assertCollection: g code equals: { #getId . #stop }.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testInitialize [
	self testPrivLabelId.
	self testPrivStream.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testIsBetweenAnd [
	| t b r |
	b := self newGenerator.
	r := b is: 10 between: 3 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b is: 10 between: 10 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b is: 12 between: 10 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b is: 9 between: 10 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b is: 13 between: 10 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testLabelsAndJumpsFor [
	| b arr |
	b := self newGenerator.
	b appendLabel: b privLabelId newNo.
	b appendValue: 1.
	b appendValue: 2.
	b appendLabel: b privLabelId newNo.
	b appendSymbol: #a.
	b appendLabel: b privLabelId newNo.
	b appendValue: 2.
	b appendSymbol: #a withJump: 1.

	arr := b labelsAndJumpsFor: b privStream contents.

	self assertCollection: arr first equals: #(1 5 6).
	self assert: arr second size equals: 1.
	self assert: arr second first selector equals: #a.
	self assert: b address equals: 13.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testLessEqualThan [
	| t b r |
	b := self newGenerator.
	r := b lessEqual: 12 than: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b lessEqual: -10 than: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b lessEqual: 5 than: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b lessEqual: -2.5 than: -2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testLessThan [
	| t b r |
	b := self newGenerator.
	r := b less: 12 than: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b less: -10 than: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b less: 5 than: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b less: -2.5 than: -2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testMinusWith [
	| t b r |
	b := self newGenerator.
	r := b minus: 12 with: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 9.

	b := self newGenerator.
	r := b minus: 10 with: -3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 13.

	b := self newGenerator.
	r := b minus: 1.5 with: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -3.5.

	b := self newGenerator.
	r := b minus: -2 with: -4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testModBy [
	| t b r |
	b := self newGenerator.
	r := b mod: 12 by: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b mod: 10 by: -3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -2.

	b := self newGenerator.
	r := b mod: 1 by: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b mod: -2 by: 4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testMultiplyAnd [
	| t b r |
	b := self newGenerator.
	r := b multiply: 12 and: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 36.

	b := self newGenerator.
	r := b multiply: 10 and: -3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -30.

	b := self newGenerator.
	r := b multiply: 1.5 and: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 7.5.

	b := self newGenerator.
	r := b multiply: -2 and: -4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 8.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testNot [
	| t b r |
	b := self newGenerator.
	r := b not: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b not: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testNullaryCommand [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b nullaryCommand: #abc.
	self assert: b privStream contents size equals: 1.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testOrWith [
	| t b r |
	b := self newGenerator.
	r := b or: true with: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b or: true with: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b or: false with: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b or: false with: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testPlusAnd [
	| t b r |
	b := self newGenerator.
	r := b plus: 12 and: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 15.

	b := self newGenerator.
	r := b plus: 10 and: -3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 7.

	b := self newGenerator.
	r := b plus: 1.5 and: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 6.5.

	b := self newGenerator.
	r := b plus: -2 and: -4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -6.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testPrivLabelId [
	| b |
	b := self newGenerator.
	self assert: b privLabelId class equals: BaseId.
	self assert: b privLabelId size equals: 0.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testPrivStream [
	| b |
	b := self newGenerator.
	self assert: b privStream isStream.
	self assert: b privStream contents isArray.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testRandomFromTo [
	| t b r |
	b := self newGenerator.
	10
		timesRepeat: [ r := b randomFrom: 1 to: 10.
			self assert: r isNil.
			t := self newThread.
			t codes: b code.
			self assert: ((t evaluate: 1) between: 1 and: 10) ].
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testResolveJumpAddressUsing [
	| b fp arr |
	b := self newGenerator.
	b appendLabel: b privLabelId newNo.
	b appendValue: 1.
	b appendValue: 2.
	b appendSymbol: #a withJump: 3.
	b appendLabel: b privLabelId newNo.
	b appendSymbol: #b.
	b appendLabel: b privLabelId newNo.
	b appendValue: 2.
	b appendSymbol: #c withJump: 2.
	fp := b privStream contents.

	self assert: (fp at: 4) address equals: nil.
	self assert: (fp at: 9) address equals: nil.

	arr := b labelsAndJumpsFor: fp.
	b resolveJumpAddress: arr second using: arr first.

	self assert: (fp at: 4) address equals: 10.
	self assert: (fp at: 9) address equals: 9.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testReturn [
	self testCallSub.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testReturnValue [
	| b r |
	b := self newGenerator.
	b returnValue.
	b address: 5.
	r := b code.
	self assertCollection: r equals: #(returnValue stop).
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testRounded [
	| t b r |
	b := self newGenerator.
	r := b rounded: 10.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b rounded: 10.2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b rounded: 10.5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 11.

	b := self newGenerator.
	r := b rounded: -10.5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -11.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testStopAll [
	| g |
	g := self newGenerator.
	g stopAll.
	self assertCollection: g code equals: { #stopAll . #stop }
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testStopThread [
	| g |
	g := self newGenerator.
	g stopThread.
	self assertCollection: g code equals: { #stop . #stop }
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
	self assert: b privStream contents isEmpty.
	b ternaryCommand: #abc arg1: 123 arg2: 456 arg3: 789.
	self assert: b privStream contents size equals: 4.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 456.
	r := b privStream contents third.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 789.
	r := b privStream contents fourth.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testTruncated [
	| t b r |
	b := self newGenerator.
	r := b truncated: 10.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b truncated: 10.2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b truncated: 10.5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b truncated: -10.5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -10.
]

{ #category : #test }
ScratchBytecodeGeneratorTest >> testUnaryCommandArg [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b unaryCommand: #abc arg: 123.
	self assert: b privStream contents size equals: 2.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
]
