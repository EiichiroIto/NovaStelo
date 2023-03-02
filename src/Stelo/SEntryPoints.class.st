Class {
	#name : #SEntryPoints,
	#superclass : #Object,
	#instVars : [
		'breeds'
	],
	#category : #'Stelo-Process'
}

{ #category : #accessing }
SEntryPoints >> addEntryPoint: anInteger forBreedNo: bno [
	| list |
	list := breeds at: bno ifAbsentPut: [ OrderedCollection new ].
	list add: anInteger.
]

{ #category : #accessing }
SEntryPoints >> breedNoList [
	^ breeds keys
]

{ #category : #private }
SEntryPoints >> breeds [
	^ breeds
]

{ #category : #accessing }
SEntryPoints >> entryPointList [
	| stream list |
	stream := WriteStream on: Array new.
	breeds keys sort
		do: [ :bno | 
			list := self forBreedNo: bno.
			list
				do: [ :address | stream nextPut: (Array with: bno with: address) ] ].
	^ stream contents
]

{ #category : #accessing }
SEntryPoints >> forBreedNo: anInteger [
	^ breeds at: anInteger ifAbsent: [ #() ]
]

{ #category : #initialization }
SEntryPoints >> initialize [
	breeds := Dictionary new.
]

{ #category : #testing }
SEntryPoints >> isEmpty [
	^ breeds isEmpty
]

{ #category : #printing }
SEntryPoints >> printOn: aStream [
	aStream nextPut: $(.
	self breedNoList
		do: [ :each | 
			aStream
				nextPutAll: each asString;
				nextPutAll: '->('.
			(self forBreedNo: each)
				do: [ :list | aStream nextPutAll: list asString ]
				separatedBy: [ aStream nextPut: Character space ].
			aStream nextPut: $) ]
		separatedBy: [ aStream nextPut: Character space ].
	aStream nextPut: $)
]
