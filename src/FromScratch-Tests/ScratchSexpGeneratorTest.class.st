"
A ScratchSexpGeneratorTest is a test class for testing the behavior of ScratchSexpGenerator
"
Class {
	#name : #ScratchSexpGeneratorTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchSexpGeneratorTest >> newGenerator [

	^ ScratchSexpGenerator new
]

{ #category : #test }
ScratchSexpGeneratorTest >> testIndentLevel [

	| gen |
	gen := self newGenerator.
	self assert: gen indentLevel equals: 1.
	gen indentLevel: 123.
	self assert: gen indentLevel equals: 123.
	gen indentLevel: 456.
	self assert: gen indentLevel equals: 456
]

{ #category : #test }
ScratchSexpGeneratorTest >> testIndents [

	| gen a |
	gen := self newGenerator.
	self assert: gen indents isArray.
	self assert: gen indents size equals: 1.
	self assert: gen indents first equals: 0.
	a := #(1 2 3).
	gen indents: a.
	self assert: gen indents identicalTo: a
]

{ #category : #test }
ScratchSexpGeneratorTest >> testParser [

	| gen a |
	gen := self newGenerator.
	self assert: (gen parser isKindOf: ScratchBlockParser).
	a := ScratchBlockParser new.
	gen parser: a.
	self assert: gen parser identicalTo: a.
	self assert: a generator equals: gen
]

{ #category : #test }
ScratchSexpGeneratorTest >> testPosition [

	| gen |
	gen := self newGenerator.
	self assert: gen position equals: 0.
	gen position: 123.
	self assert: gen position equals: 123.
	gen position: 456.
	self assert: gen position equals: 456
]

{ #category : #test }
ScratchSexpGeneratorTest >> testStream [

	| gen a |
	gen := self newGenerator.
	self assert: (gen stream isKindOf: WriteStream).
	a := WriteStream on: String new.
	gen stream: a.
	self assert: gen stream identicalTo: a
]

{ #category : #test }
ScratchSexpGeneratorTest >> testWantsLinefeed [

	| gen |
	gen := self newGenerator.
	self deny: gen wantsLinefeed.
	gen wantsLinefeed: true.
	self assert: gen wantsLinefeed.
	gen wantsLinefeed: false.
	self deny: gen wantsLinefeed
]
