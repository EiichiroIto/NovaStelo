"
A ScratchBlockParserTest is a test class for testing the behavior of ScratchBlockParser
"
Class {
	#name : 'ScratchBlockParserTest',
	#superclass : 'TestCase',
	#category : 'FromScratch-Tests',
	#package : 'FromScratch-Tests'
}

{ #category : 'private' }
ScratchBlockParserTest >> newGenerator [

	^ ScratchGenerator new
]

{ #category : 'private' }
ScratchBlockParserTest >> newParser [

	^ ScratchBlockParser new
]

{ #category : 'test' }
ScratchBlockParserTest >> testGenerator [

	| gen parser |
	parser := self newParser.
	self assert: parser generator isNil.
	gen := self newGenerator.
	parser generator: gen.
	self assert: parser generator identicalTo: gen
]
