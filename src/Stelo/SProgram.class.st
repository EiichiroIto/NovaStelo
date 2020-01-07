Class {
	#name : #SProgram,
	#superclass : #Object,
	#instVars : [
		'codes',
		'entryPoints'
	],
	#category : #'Stelo-Process'
}

{ #category : #accessing }
SProgram >> addCode: anArray [
	codes := codes, anArray.
]

{ #category : #accessing }
SProgram >> addEntryPoint: anInteger eventNo: eno breedNo: bno [
	(self forEventNo: eno) addEntryPoint: anInteger forBreedNo: bno.
]

{ #category : #accessing }
SProgram >> bytecode [
	^ codes
		collect: [ :each | 
			each isSymbol
				ifTrue: [ SteloNativeThread indexOfSymbol: each ]
				ifFalse: [ each ] ]
]

{ #category : #accessing }
SProgram >> codes [
	^ codes
]

{ #category : #accessing }
SProgram >> entryPointList [
	| stream list |
	stream := WriteStream on: Array new.
	entryPoints keys sort
		do: [ :eno | 
			list := (self forEventNo: eno) entryPointList.
			list do: [ :each | stream nextPut: ({eno} , each) ] ].
	^ stream contents
]

{ #category : #accessing }
SProgram >> eventNoList [
	^ entryPoints keys
]

{ #category : #accessing }
SProgram >> forEventNo: anInteger [
	^ entryPoints at: anInteger ifAbsentPut: [ SEntryPoints new ]
]

{ #category : #initialization }
SProgram >> initialize [
	entryPoints := Dictionary new.
	codes := Array new.
]

{ #category : #accessing }
SProgram >> nextAddress [
	^ codes size + 1
]

{ #category : #printing }
SProgram >> printOn: aStream [
	aStream
		nextPutAll: 'SProgram(';
		nextPutAll: codes size asString;
		nextPut: $)
]

{ #category : #private }
SProgram >> privCodes: aCollection [
	codes := aCollection.
]

{ #category : #private }
SProgram >> privEntryPoints [
	^ entryPoints
]
