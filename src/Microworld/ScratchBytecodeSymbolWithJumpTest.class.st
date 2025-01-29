"
A SCodeSymbolWithJumpTest is a test class for testing the behavior of SCodeSymbolWithJump
"
Class {
	#name : 'ScratchBytecodeSymbolWithJumpTest',
	#superclass : 'TestCase',
	#category : 'Microworld-Tests',
	#package : 'Microworld',
	#tag : 'Tests'
}

{ #category : 'private' }
ScratchBytecodeSymbolWithJumpTest >> newSymbol: aSymbol label: anInteger [
	^ ScratchBytecodeSymbolWithJump selector: aSymbol labelId: anInteger
]

{ #category : 'test' }
ScratchBytecodeSymbolWithJumpTest >> testAddress [
	| c |
	c := self newSymbol: #abc label: 1.
	self assert: c address isNil.
	c address: 123.
	self assert: c address equals: 123.
]

{ #category : 'test' }
ScratchBytecodeSymbolWithJumpTest >> testCodeSize [
	| c |
	c := self newSymbol: #abc label: 1.
	self assert: c codeSize equals: 4.
]

{ #category : 'test' }
ScratchBytecodeSymbolWithJumpTest >> testIsJump [
	| c |
	c := self newSymbol: #abc label: 1.
	self assert: c isJump.
]

{ #category : 'test' }
ScratchBytecodeSymbolWithJumpTest >> testLabelId [
	| c |
	c := self newSymbol: #abc label: 1.
	self assert: c labelId equals: 1.
	c labelId: 123.
	self assert: c labelId equals: 123.
]

{ #category : 'test' }
ScratchBytecodeSymbolWithJumpTest >> testPrintOn [
	| c |
	c := self newSymbol: #abc label: 1.
	self assert: c asString equals: '<symbol=abc,id=1,jump=nil>'.
	c address: 2.
	self assert: c asString equals: '<symbol=abc,id=1,jump=2>'.
]

{ #category : 'test' }
ScratchBytecodeSymbolWithJumpTest >> testPutOn [
	| c stream |
	stream := WriteStream on: Array new.
	c := self newSymbol: #abc label: 1.
	self should: [ c putOn: stream ] raise: Error.
	c address: 123.
	c putOn: stream.
	self assertCollection: stream contents equals: #(pushShort 123 0 abc).
]
