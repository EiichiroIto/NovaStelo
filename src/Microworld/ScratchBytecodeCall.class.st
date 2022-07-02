Class {
	#name : #ScratchBytecodeCall,
	#superclass : #ScratchBytecode,
	#instVars : [
		'subName',
		'address'
	],
	#category : #'Microworld-Bytecode'
}

{ #category : #'instance creation' }
ScratchBytecodeCall class >> subName: aString [
	^ self basicNew
		initialize;
		subName: aString;
		yourself
]

{ #category : #'instance creation' }
ScratchBytecodeCall class >> subName: aString address: anInteger [
	^ self basicNew
		initialize;
		subName: aString;
		address: anInteger;
		yourself
]

{ #category : #accessing }
ScratchBytecodeCall >> address [
	^ address
]

{ #category : #accessing }
ScratchBytecodeCall >> address: anObject [
	address := anObject
]

{ #category : #accessing }
ScratchBytecodeCall >> codeSize [
	^ 4
]

{ #category : #testing }
ScratchBytecodeCall >> isCall [
	^ true
]

{ #category : #printing }
ScratchBytecodeCall >> printOn: aStream [
	aStream
		nextPutAll: '<call=';
		nextPutAll: subName asString;
		nextPutAll: ',to=';
		nextPutAll: address asString;
		nextPut: $>.
]

{ #category : #accessing }
ScratchBytecodeCall >> putOn: aStream [
	address ifNil: [ self error ].
	self putShort: address on: aStream.
	aStream nextPut: #call.
]

{ #category : #accessing }
ScratchBytecodeCall >> subName [
	^ subName
]

{ #category : #accessing }
ScratchBytecodeCall >> subName: anObject [
	subName := anObject
]
