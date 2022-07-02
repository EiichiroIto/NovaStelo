Class {
	#name : #StringArray,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'literals',
		'array',
		'nextId',
		'invLiterals'
	],
	#category : #'Microworld-Core'
}

{ #category : #'instance creation' }
StringArray class >> new: anInteger [
	^ self new
		forceTo: anInteger paddingWith: '';
		yourself
]

{ #category : #accessing }
StringArray >> at: anInteger [
	^ array at: anInteger
]

{ #category : #accessing }
StringArray >> at: anInteger put: anObject [
	^ array at: anInteger put: anObject
]

{ #category : #accessing }
StringArray >> defaultElement [
	^ ''
]

{ #category : #'object i/o' }
StringArray >> fieldsVersion [
	^ 1
]

{ #category : #copying }
StringArray >> forceTo: anInteger paddingWith: aString [
	| id |
	id := self idOf: aString.
	array := array forceTo: anInteger paddingWith: id.
	^ self
]

{ #category : #private }
StringArray >> generateInvLiterals [
	| dict |
	dict := Dictionary new.
	literals withIndexDo: [ :each :index | dict at: each put: index ].
	^ dict
]

{ #category : #copying }
StringArray >> grownBy: anInteger [
	array := array grownBy: anInteger.
	^ self
]

{ #category : #accessing }
StringArray >> idOf: aString [
	self assert: aString isString.
	^ self invLiterals
		at: aString
		ifAbsentPut: [ | id |
			literals := literals grownBy: 1.
			id := literals size.
			literals at: id put: aString.
			id ]
]

{ #category : #'object i/o' }
StringArray >> initFieldsFrom: anObjStream version: classVersion [
	self initFieldsNamed: #(literals array) from: anObjStream
]

{ #category : #initialization }
StringArray >> initialize [
	array := IntegerArray new.
	literals := Array new.
	invLiterals := nil
]

{ #category : #private }
StringArray >> invLiterals [
	^ invLiterals ifNil: [ invLiterals := self generateInvLiterals ]
]

{ #category : #testing }
StringArray >> isEmpty [
	^ array isEmpty
]

{ #category : #accessing }
StringArray >> privArray [
	^ array
]

{ #category : #accessing }
StringArray >> privInvLiterals [
	^ invLiterals
]

{ #category : #accessing }
StringArray >> privInvLiterals: aDictionary [
	invLiterals := aDictionary
]

{ #category : #accessing }
StringArray >> privLiterals [
	^ literals
]

{ #category : #accessing }
StringArray >> size [
	^ array size
]

{ #category : #'object i/o' }
StringArray >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(literals array) on: anObjStream.
]

{ #category : #accessing }
StringArray >> stringAt: anInteger [
	| id |
	id := self at: anInteger.
	^ self stringOf: id
]

{ #category : #accessing }
StringArray >> stringAt: anInteger put: aString [
	| id |
	id := self idOf: aString.
	^ self at: anInteger put: id
]

{ #category : #accessing }
StringArray >> stringOf: anInteger [
	^ anInteger = 0
		ifTrue: [ '' ]
		ifFalse: [ literals at: anInteger ]
]
