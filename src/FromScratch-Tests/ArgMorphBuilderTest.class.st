"
An ArgMorphBuilderTest is a test class for testing the behavior of ArgMorphBuilder
"
Class {
	#name : #ArgMorphBuilderTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ArgMorphBuilderTest >> newBuilder [
	^ ArgMorphBuilder new
]

{ #category : #test }
ArgMorphBuilderTest >> testAddBooleanArg [
	| b |
	b := self newBuilder.
	b addBooleanArg: $b.
	self assert: (b dict at: $b) isBlock.
	self
		assert: ((b uncoloredArgMorphFor: #(1 $b)) isKindOf: BooleanArgMorph)
]

{ #category : #test }
ArgMorphBuilderTest >> testAddBuilder [
	| b |
	b := self newBuilder.
	b add: $a builder: 123.
	b add: $b builder: 456.
	self assert: (b dict at: $a) equals: 123.
	self assert: (b dict at: $b) equals: 456.
	self should: [ b add: $b builder: 789 ] raise: Error
]

{ #category : #test }
ArgMorphBuilderTest >> testAddChoiceArgDef [

	| obj def r |
	obj := self newBuilder.
	self assert: obj dict isEmpty.
	def := ScratchChoiceArgDef new
		       arg: $a;
		       options: #( abc def ).
	obj addChoiceArgDef: def.
	self assert: obj dict size equals: 1.
	r := obj dict at: $a.
	self assert: (r isKindOf: BlockClosure).
	self assert: (r value isKindOf: StaticChoiceArgMorph).
	self assert: r value choice equals: ''.
	self assertCollection: r value options equals: #( abc def )
]

{ #category : #test }
ArgMorphBuilderTest >> testAddChoiceArgOptionsInitialChoice [

	| b a |
	b := self newBuilder.
	b addChoiceArg: $x options: #( abc def ) initialChoice: 'def'.
	a := b uncoloredArgMorphFor: #( 1 $x ).
	self assert: (a isKindOf: StaticChoiceArgMorph).
	self assertCollection: a options equals: #( abc def ).
	self assert: a choice equals: 'def'
]

{ #category : #test }
ArgMorphBuilderTest >> testAddChoiceArgSelector [
	| b a |
	b := self newBuilder.
	b addChoiceArg: $x selector: #abc.
	a := b uncoloredArgMorphFor: #(1 $x).
	self assert: (a isKindOf: ArgMorph).
	self assert: a getOptionsSelector equals: #abc.
	self assert: a getOptionsTarget isNil.
	self assert: a choice isEmpty
]

{ #category : #test }
ArgMorphBuilderTest >> testAddChoiceArgSelectorInitialChoice [
	| b a |
	b := self newBuilder.
	b addChoiceArg: $x selector: #abc initialChoice: 'def'.
	a := b uncoloredArgMorphFor: #(1 $x).
	self assert: (a isKindOf: ArgMorph).
	self assert: a getOptionsSelector equals: #abc.
	self assert: a getOptionsTarget isNil.
	self assert: a choice equals: 'def'
]

{ #category : #test }
ArgMorphBuilderTest >> testAddChoiceArgSelectorTargetInitialChoice [
	| b a |
	b := self newBuilder.
	b addChoiceArg: $x selector: #abc target: self initialChoice: 'def'.
	a := b uncoloredArgMorphFor: #(1 $x).
	self assert: (a isKindOf: ArgMorph).
	self assert: a getOptionsSelector equals: #abc.
	self assert: a getOptionsTarget equals: self.
	self assert: a choice equals: 'def'
]

{ #category : #test }
ArgMorphBuilderTest >> testAddEventTitleArg [
	| b |
	b := self newBuilder.
	b addEventTitleArg: $e.
	self assert: (b dict at: $e) isBlock.
	self
		assert: ((b uncoloredArgMorphFor: #(1 $e)) isKindOf: EventTitleMorph)
]

{ #category : #test }
ArgMorphBuilderTest >> testAddLocalVarArg [
	| b a |
	b := self newBuilder.
	b addLocalVarArg: $l.
	self assert: (b dict at: $l) isBlock.
	a := b uncoloredArgMorphFor: #(1 $l).
	self assert: (a isKindOf: LocalVarArgMorph).
	self assert: a evaluate equals: 'x'.
	a varName: 'abc'.
	self assert: a evaluate equals: 'abc'
]

{ #category : #test }
ArgMorphBuilderTest >> testAddLocalVarArgInitialVarName [
	| b a |
	b := self newBuilder.
	b addLocalVarArg: $l initialVarName: 'abc'.
	self assert: (b dict at: $l) isBlock.
	a := b uncoloredArgMorphFor: #(1 $l).
	self assert: (a isKindOf: LocalVarArgMorph).
	self assert: a evaluate equals: 'abc'
]

{ #category : #test }
ArgMorphBuilderTest >> testAddNumberExpressArgInitialExpression [
	| b a |
	b := self newBuilder.
	b addNumberExpressArg: $e initialExpression: '10'.
	self assert: (b dict at: $e) isBlock.
	a := b uncoloredArgMorphFor: #(1 $e).
	self assert: (a isKindOf: ExpressionArgMorph).
	self assert: a evaluate equals: 10
]

{ #category : #test }
ArgMorphBuilderTest >> testAddNumberExpressArgSelectorTargetInitialExpression [
	| b a |
	b := self newBuilder.
	b addNumberExpressArg: $x selector: #abc target: self initialExpression: '5'.
	a := b uncoloredArgMorphFor: #(1 $x).
	self assert: (a isKindOf: ExpressionArgMorph).
	self assert: a getOptionsSelector equals: #abc.
	self assert: a getOptionsTarget equals: self.
	self assert: a evaluate equals: 5
]

{ #category : #test }
ArgMorphBuilderTest >> testAddSpriteArg [
	| b |
	b := self newBuilder.
	b addSpriteArg: $e.
	self assert: (b dict at: $e) isBlock.
	self
		assert: ((b uncoloredArgMorphFor: #(1 $e)) isKindOf: SpriteArgMorph)
]

{ #category : #test }
ArgMorphBuilderTest >> testAddStringExpressArg [
	| b a |
	b := self newBuilder.
	b addStringExpressArg: $e.
	self assert: (b dict at: $e) isBlock.
	a := b uncoloredArgMorphFor: #(1 $e).
	self assert: (a isKindOf: ExpressionArgMorph).
	self assert: a evaluate equals: ''
]

{ #category : #test }
ArgMorphBuilderTest >> testArgMorphFor [

	| obj r |
	obj := self newBuilder.
	obj addBooleanArg: $a.
	obj addChoiceArg: $b options: #( a b c ) initialChoice: #a.
	r := obj argMorphFor: $a.
	self assert: (r isKindOf: BooleanArgMorph).
	r := obj argMorphFor: $b.
	self assert: (r isKindOf: StaticChoiceArgMorph)
]

{ #category : #test }
ArgMorphBuilderTest >> testDict [

	| obj a |
	obj := self newBuilder.
	self assert: obj dict isDictionary.
	a := Dictionary new.
	obj dict: a.
	self assert: obj dict identicalTo: a
]

{ #category : #test }
ArgMorphBuilderTest >> testInitialize [
	self testPrivDict
]

{ #category : #test }
ArgMorphBuilderTest >> testPrivDict [
	| b |
	b := self newBuilder.
	self assert: b dict isDictionary.
	self assert: b dict isEmpty
]

{ #category : #test }
ArgMorphBuilderTest >> testUncoloredArgMorphFor [
	| b |
	b := self newBuilder.
	b add: $x builder: [ 1 + 2 ].
	self assert: (b uncoloredArgMorphFor: #(1 $x)) equals: 3
]
