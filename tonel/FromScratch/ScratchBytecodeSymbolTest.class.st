"
A SCodeSymbolTest is a test class for testing the behavior of SCodeSymbol
"
Class {
	#name : #ScratchBytecodeSymbolTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchBytecodeSymbolTest >> newSymbol: aSymbol [
	^ ScratchBytecodeSymbol selector: aSymbol
]

{ #category : #test }
ScratchBytecodeSymbolTest >> testPrintOn [
	| c |
	c := self newSymbol: #abc.
	self assert: c asString equals: '<symbol=abc>'.
]

{ #category : #test }
ScratchBytecodeSymbolTest >> testPutOn [
	| c stream |
	c := self newSymbol: #abc.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assertCollection: stream contents equals: #(abc).
]

{ #category : #test }
ScratchBytecodeSymbolTest >> testSelector [
	| c |
	c := self newSymbol: #abc.
	self assert: c selector equals: #abc.
	c selector: #def.
	self assert: c selector equals: #def.
]
