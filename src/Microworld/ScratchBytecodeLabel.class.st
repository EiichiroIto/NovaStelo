Class {
	#name : #ScratchBytecodeLabel,
	#superclass : #ScratchBytecode,
	#instVars : [
		'id'
	],
	#category : #'Microworld-Bytecode'
}

{ #category : #'instance creation' }
ScratchBytecodeLabel class >> id: anInteger [
	^ self basicNew initialize
		id: anInteger;
		yourself.
]

{ #category : #accessing }
ScratchBytecodeLabel >> codeSize [
	^ 0
]

{ #category : #accessing }
ScratchBytecodeLabel >> id [
	^ id
]

{ #category : #accessing }
ScratchBytecodeLabel >> id: anInteger [
	id := anInteger.
]

{ #category : #testing }
ScratchBytecodeLabel >> isLabel [
	^ true
]

{ #category : #printing }
ScratchBytecodeLabel >> printOn: aStream [
	aStream
		nextPutAll: '<label=';
		nextPutAll: id asString;
		nextPut: $>.
]
