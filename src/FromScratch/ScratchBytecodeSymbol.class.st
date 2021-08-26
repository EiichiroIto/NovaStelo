Class {
	#name : #ScratchBytecodeSymbol,
	#superclass : #ScratchBytecode,
	#instVars : [
		'selector'
	],
	#category : #'FromScratch-Bytecode'
}

{ #category : #'instance creation' }
ScratchBytecodeSymbol class >> selector: aSymbol [
	^ self basicNew initialize
		selector: aSymbol;
		yourself.
]

{ #category : #printing }
ScratchBytecodeSymbol >> printOn: aStream [
	aStream
		nextPutAll: '<symbol=';
		nextPutAll: selector asString;
		nextPut: $>.
]

{ #category : #accessing }
ScratchBytecodeSymbol >> putOn: aStream [
	aStream nextPut: selector.
]

{ #category : #accessing }
ScratchBytecodeSymbol >> selector [
	^ selector
]

{ #category : #accessing }
ScratchBytecodeSymbol >> selector: aSymbol [
	selector := aSymbol.
]
