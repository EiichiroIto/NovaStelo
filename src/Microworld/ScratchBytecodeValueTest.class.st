"
A SCodeValueTest is a test class for testing the behavior of SCodeValue
"
Class {
	#name : #ScratchBytecodeValueTest,
	#superclass : #TestCase,
	#category : #'Microworld-Tests'
}

{ #category : #private }
ScratchBytecodeValueTest >> newValue: aNumber [
	^ ScratchBytecodeValue data: aNumber
]

{ #category : #test }
ScratchBytecodeValueTest >> testCodeSize [
	| c |
	c := self newValue: 0.
	self assert: c codeSize equals: 1.
	c := self newValue: 1.
	self assert: c codeSize equals: 1.
	c := self newValue: 2.
	self assert: c codeSize equals: 3.
	c := self newValue: 32767.
	self assert: c codeSize equals: 3.
	c := self newValue: -32768.
	self assert: c codeSize equals: 3.
	c := self newValue: 32768.
	self assert: c codeSize equals: 5.
	c := self newValue: -32769.
	self assert: c codeSize equals: 5.
	c := self newValue: 1.1.
	self assert: c codeSize equals: 5.
]

{ #category : #test }
ScratchBytecodeValueTest >> testData [
	| c |
	c := self newValue: 1.
	self assert: c data equals: 1.
	c data: 2.
	self assert: c data equals: 2.
]

{ #category : #test }
ScratchBytecodeValueTest >> testPrintOn [
	| c |
	c := self newValue: 123.
	self assert: c asString equals: '<value=123>'.
]

{ #category : #test }
ScratchBytecodeValueTest >> testPutFloatOn [
	| c stream |
	c := self newValue: 123.0.
	stream := WriteStream on: Array new.
	c putFloatOn: stream.
	self
		assertCollection: stream contents
		equals: #(pushFloat 16r00 16r00 16rF6 16r42).
	c := self newValue: -5.3.
	stream := WriteStream on: Array new.
	c putFloatOn: stream.
	self
		assertCollection: stream contents
		equals: #(pushFloat 16r9A 16r99 16rA9 16rC0)
]

{ #category : #test }
ScratchBytecodeValueTest >> testPutOn [
	| c stream |
	c := self newValue: 0.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assertCollection: stream contents equals: #(push0).
	c := self newValue: 1.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assertCollection: stream contents equals: #(push1).
	c := self newValue: 2.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assertCollection: stream contents equals: #(pushShort 2 0).
	c := self newValue: 123.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self assertCollection: stream contents equals: #(pushShort 123 0).
	c := self newValue: -2.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self
		assertCollection: stream contents
		equals: #(pushShort 16rFE 16rFF).
	c := self newValue: 123.0.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self
		assertCollection: stream contents
		equals: #(pushFloat 16r00 16r00 16rF6 16r42).
	c := self newValue: -5.3.
	stream := WriteStream on: Array new.
	c putOn: stream.
	self
		assertCollection: stream contents
		equals: #(pushFloat 16r9A 16r99 16rA9 16rC0)
]

{ #category : #test }
ScratchBytecodeValueTest >> testPutShortOn [
	| c stream |
	c := self newValue: 123.
	stream := WriteStream on: Array new.
	c putShortOn: stream.
	self assertCollection: stream contents equals: #(pushShort 123 0).
	c := self newValue: -123.
	stream := WriteStream on: Array new.
	c putShortOn: stream.
	self
		assertCollection: stream contents
		equals: #(pushShort 16r85 16rFF)
]
