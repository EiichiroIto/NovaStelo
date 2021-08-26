Class {
	#name : #SProgramToBytecode,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Stelo-Plugins'
}

{ #category : #private }
SProgramToBytecode >> addCode: anArray eventNo: eno breed: bno [
	| code |
	code := anArray
		collect: [ :each | 
			each isSymbol
				ifTrue: [ SteloNativeThread indexOfSymbol: each ]
				ifFalse: [ each ] ].
	stream
		nextPut:
			{eno.
			bno.
			code asByteArray}
]

{ #category : #private }
SProgramToBytecode >> convert: aProgram [
	aProgram eventNoList
		do: [ :each | self convert: (aProgram forEventNo: each) eventNo: each ]
]

{ #category : #private }
SProgramToBytecode >> convert: anEventCodes eventNo: anInteger [
	anEventCodes breedNoList
		do: [ :each | 
			(anEventCodes forBreedNo: each)
				do: [ :code | self addCode: code eventNo: anInteger breed: each ] ]
]

{ #category : #accessing }
SProgramToBytecode >> fromProgram: aProgram [
	stream := WriteStream on: Array new.
	self convert: aProgram.
	^ stream contents
]
