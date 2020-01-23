Class {
	#name : #ScratchBytecodeValue,
	#superclass : #ScratchBytecode,
	#instVars : [
		'data'
	],
	#category : #'FromScratch-Bytecode'
}

{ #category : #'instance creation' }
ScratchBytecodeValue class >> data: anObject [
	^ self basicNew
		initialize;
		data: anObject;
		yourself
]

{ #category : #accessing }
ScratchBytecodeValue >> codeSize [
	data = false
		ifTrue: [ ^ 1 ].
	data = true
		ifTrue: [ ^ 1 ].
	data = 0
		ifTrue: [ ^ 1 ].
	data = 1
		ifTrue: [ ^ 1 ].
	(data isInteger and: [ data between: -32768 and: 32767 ])
		ifTrue: [ ^ 3 ].
	^ 5
]

{ #category : #accessing }
ScratchBytecodeValue >> data [
	^ data
]

{ #category : #accessing }
ScratchBytecodeValue >> data: anObject [
	data := anObject.
]

{ #category : #printing }
ScratchBytecodeValue >> printOn: aStream [
	aStream
		nextPutAll: '<value=';
		nextPutAll: data asString;
		nextPut: $>.
]

{ #category : #private }
ScratchBytecodeValue >> putFloatOn: aStream [
	| v |
	aStream nextPut: #pushFloat.
	v := data asFloat asIEEE32BitWord.
	aStream nextPut: (v bitAnd: 16rFF).
	v := v >> 8.
	aStream nextPut: (v bitAnd: 16rFF).
	v := v >> 8.
	aStream nextPut: (v bitAnd: 16rFF).
	v := v >> 8.
	aStream nextPut: (v bitAnd: 16rFF).
]

{ #category : #accessing }
ScratchBytecodeValue >> putOn: aStream [
	data = false
		ifTrue: [ ^ aStream nextPut: #push0 ].
	data = true
		ifTrue: [ ^ aStream nextPut: #push1 ].
	data = 0
		ifTrue: [ ^ aStream nextPut: #push0 ].
	data = 1
		ifTrue: [ ^ aStream nextPut: #push1 ].
	(data isInteger and: [ data between: -32768 and: 32767 ])
		ifTrue: [ ^ self putShortOn: aStream ].
	self putFloatOn: aStream
]

{ #category : #private }
ScratchBytecodeValue >> putShortOn: aStream [
	self putShort: data on: aStream
]
