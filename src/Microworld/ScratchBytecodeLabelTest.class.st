"
A SCodeLabelTest is a test class for testing the behavior of SCodeLabel
"
Class {
	#name : 'ScratchBytecodeLabelTest',
	#superclass : 'TestCase',
	#category : 'Microworld-Tests',
	#package : 'Microworld',
	#tag : 'Tests'
}

{ #category : 'private' }
ScratchBytecodeLabelTest >> newLabel: anInteger [
	^ ScratchBytecodeLabel id: anInteger
]

{ #category : 'test' }
ScratchBytecodeLabelTest >> testCodeSize [
	| c |
	c := self newLabel: 1.
	self assert: c codeSize equals: 0.
]

{ #category : 'test' }
ScratchBytecodeLabelTest >> testId [
	| c |
	c := self newLabel: 1.
	self assert: c id equals: 1.
	c id: 20.
	self assert: c id equals: 20.
]

{ #category : 'test' }
ScratchBytecodeLabelTest >> testIsLabel [
	| c |
	c := self newLabel: 1.
	self assert: c isLabel.
]

{ #category : 'test' }
ScratchBytecodeLabelTest >> testPrintOn [
	| c |
	c := self newLabel: 1.
	self assert: c asString equals: '<label=1>'.
]

{ #category : 'test' }
ScratchBytecodeLabelTest >> testPutOn [
	| c stream |
	c := self newLabel: 1.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assert: stream contents isEmpty.
]
