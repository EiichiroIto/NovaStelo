"
A SCodeTest is a test class for testing the behavior of SCode
"
Class {
	#name : 'ScratchBytecodeTest',
	#superclass : 'TestCase',
	#category : 'Microworld-Tests',
	#package : 'Microworld',
	#tag : 'Tests'
}

{ #category : 'private' }
ScratchBytecodeTest >> newBytecode [
	^ ScratchBytecode basicNew
]

{ #category : 'test' }
ScratchBytecodeTest >> testCodeSize [
	| c |
	c := self newBytecode.
	self assert: c codeSize equals: 1.
]

{ #category : 'test' }
ScratchBytecodeTest >> testIsCall [
	| c |
	c := ScratchBytecode basicNew.
	self deny: c isCall.
]

{ #category : 'test' }
ScratchBytecodeTest >> testIsJump [
	| c |
	c := self newBytecode.
	self deny: c isJump.
]

{ #category : 'test' }
ScratchBytecodeTest >> testIsLabel [
	| c |
	c := self newBytecode.
	self deny: c isLabel.
]

{ #category : 'test' }
ScratchBytecodeTest >> testPutOn [
	| c stream |
	c := self newBytecode.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assert: stream contents isEmpty.
]

{ #category : 'test' }
ScratchBytecodeTest >> testPutShortOn [
	| c stream |
	c := ScratchBytecode basicNew.
	stream := WriteStream on: Array new.
	c putShort: 123 on: stream.
	self assertCollection: stream contents equals: #(pushShort 123 0).
	c := ScratchBytecode basicNew.
	stream := WriteStream on: Array new.
	c putShort: -123 on: stream.
	self
		assertCollection: stream contents
		equals: #(pushShort 16r85 16rFF)
]
