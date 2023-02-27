"
A ScratchGeneratorTest is a test class for testing the behavior of ScratchGenerator
"
Class {
	#name : #ScratchGeneratorTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchGeneratorTest >> newGenerator [

	^ ScratchGenerator new
]

{ #category : #private }
ScratchGeneratorTest >> newParser [

	^ ScratchBlockParser new
]

{ #category : #test }
ScratchGeneratorTest >> testFalseString [

	self deny: self newGenerator falseString
]

{ #category : #test }
ScratchGeneratorTest >> testIndentLevelFor [

	| morph |
	morph := HatBlockMorph new.
	self assert: (self newGenerator indentLevelFor: morph) equals: 0.
	morph := CommandBlockMorph new.
	self assert: (self newGenerator indentLevelFor: 100) equals: 0
]

{ #category : #test }
ScratchGeneratorTest >> testLiteralStringFrom [

	| gen |
	gen := self newGenerator.
	self assert: (gen literalStringFrom: 'abc') equals: 'abc'.
	self assert: (gen literalStringFrom: 123) equals: '123'
]

{ #category : #test }
ScratchGeneratorTest >> testParser [

	| gen parser |
	gen := self newGenerator.
	self assert: gen parser isNil.
	parser := self newParser.
	gen parser: parser.
	self assert: gen parser identicalTo: parser
]
