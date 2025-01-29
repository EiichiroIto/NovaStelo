Class {
	#name : 'ScratchBytecodeCallTest',
	#superclass : 'TestCase',
	#category : 'Microworld-Tests',
	#package : 'Microworld',
	#tag : 'Tests'
}

{ #category : 'private' }
ScratchBytecodeCallTest >> newCall: aString [
	^ ScratchBytecodeCall subName: aString
]

{ #category : 'private' }
ScratchBytecodeCallTest >> newCall: aString address: anInteger [
	^ ScratchBytecodeCall subName: aString address: anInteger
]

{ #category : 'test' }
ScratchBytecodeCallTest >> testAddress [
	| c |
	c := self newCall: 'abc'.
	self assert: c address isNil.
	c address: 123.
	self assert: c address equals: 123.
	c address: 456.
	self assert: c address equals: 456.
]

{ #category : 'test' }
ScratchBytecodeCallTest >> testCodeSize [
	| c |
	c := self newCall: 'abc'.
	self assert: c codeSize equals: 4.
]

{ #category : 'test' }
ScratchBytecodeCallTest >> testIsCall [
	| c |
	c := self newCall: 'abc'.
	self assert: c isCall.
]

{ #category : 'test' }
ScratchBytecodeCallTest >> testPrintOn [
	| c |
	c := self newCall: 'abc'.
	self assert: c asString equals: '<call=abc,to=nil>'.
	c address: 2.
	self assert: c asString equals: '<call=abc,to=2>'.
]

{ #category : 'test' }
ScratchBytecodeCallTest >> testPutOn [
	| c stream |
	stream := WriteStream on: Array new.
	c := self newCall: 'abc'.
	self should: [ c putOn: stream ] raise: Error.
	c address: 123.
	c putOn: stream.
	self assertCollection: stream contents equals: #(pushShort 123 0 call).
]

{ #category : 'test' }
ScratchBytecodeCallTest >> testSubName [
	| c |
	c := self newCall: 'abc'.
	self assert: c subName equals: 'abc'.
	c subName: 'def'.
	self assert: c subName equals: 'def'.
	c subName: 'ghi'.
	self assert: c subName equals: 'ghi'.
]

{ #category : 'test' }
ScratchBytecodeCallTest >> testSubNameAddress [
	| c |
	c := self newCall: 'abc' address: 123.
	self assert: c subName equals: 'abc'.
	self assert: c address equals: 123.
	c := self newCall: 'def' address: 456.
	self assert: c subName equals: 'def'.
	self assert: c address equals: 456.
]
