Class {
	#name : #ScratchBytecodeSymbolWithJump,
	#superclass : #ScratchBytecodeSymbol,
	#instVars : [
		'labelId',
		'address'
	],
	#category : #'FromScratch-Bytecode'
}

{ #category : #'instance creation' }
ScratchBytecodeSymbolWithJump class >> selector: aSymbol labelId: anInteger [
	^ self basicNew
		initialize;
		selector: aSymbol;
		labelId: anInteger;
		yourself
]

{ #category : #accessing }
ScratchBytecodeSymbolWithJump >> address [
	^ address
]

{ #category : #accessing }
ScratchBytecodeSymbolWithJump >> address: anInteger [
	address := anInteger.
]

{ #category : #accessing }
ScratchBytecodeSymbolWithJump >> codeSize [
	^ 4
]

{ #category : #testing }
ScratchBytecodeSymbolWithJump >> isJump [
	^ true
]

{ #category : #accessing }
ScratchBytecodeSymbolWithJump >> labelId [
	^ labelId
]

{ #category : #accessing }
ScratchBytecodeSymbolWithJump >> labelId: anInteger [
	labelId := anInteger.
]

{ #category : #printing }
ScratchBytecodeSymbolWithJump >> printOn: aStream [
	aStream
		nextPutAll: '<symbol=';
		nextPutAll: selector asString;
		nextPutAll: ',id=';
		nextPutAll: labelId asString;
		nextPutAll: ',jump=';
		nextPutAll: address asString;
		nextPut: $>.
]

{ #category : #accessing }
ScratchBytecodeSymbolWithJump >> putOn: aStream [
	address ifNil: [ self error ].
	self putShort: address on: aStream.
	aStream nextPut: selector.
]
