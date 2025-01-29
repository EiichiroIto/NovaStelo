Class {
	#name : 'ScratchBytecode',
	#superclass : 'Object',
	#category : 'Microworld-Bytecode',
	#package : 'Microworld',
	#tag : 'Bytecode'
}

{ #category : 'instance creation' }
ScratchBytecode class >> new [
	self shouldNotImplement.
]

{ #category : 'accessing' }
ScratchBytecode >> codeSize [
	^ 1
]

{ #category : 'testing' }
ScratchBytecode >> isCall [
	^ false
]

{ #category : 'testing' }
ScratchBytecode >> isJump [
	^ false
]

{ #category : 'testing' }
ScratchBytecode >> isLabel [
	^ false
]

{ #category : 'accessing' }
ScratchBytecode >> putOn: aStream [
	"do nothing"
]

{ #category : 'accessing' }
ScratchBytecode >> putShort: anInteger on: aStream [
	| v |
	aStream nextPut: #pushShort.
	v := anInteger >= 0
		ifTrue: [ anInteger ]
		ifFalse: [ 16r10000 + anInteger ].
	aStream nextPut: (v bitAnd: 16rFF).
	v := v >> 8.
	aStream nextPut: (v bitAnd: 16rFF).
]
