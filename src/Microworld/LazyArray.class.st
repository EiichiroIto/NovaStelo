Class {
	#name : #LazyArray,
	#superclass : #Object,
	#instVars : [
		'array',
		'className',
		'fixedSize',
		'defaultValue'
	],
	#category : #'Microworld-Core'
}

{ #category : #'instance creation' }
LazyArray class >> className: aSymbol [
	^ self basicNew
		initialize;
		className: aSymbol;
		yourself
]

{ #category : #'instance creation' }
LazyArray class >> newArray [
	^ self className: #Array
]

{ #category : #private }
LazyArray >> allocateMore: anInteger [
	| newSize |
	self assert: self fixedSize isNil.
	newSize := anInteger roundUpTo: self defaultAllocationSize.
	array := array
		ifNil: [ self arrayClass new: newSize ]
		ifNotNil: [ array grownBy: newSize ].
]

{ #category : #accessing }
LazyArray >> array [
	array ifNil: [ array := self arrayClass new ].
	^ array
]

{ #category : #private }
LazyArray >> arrayClass [
	^ Smalltalk at: className
]

{ #category : #private }
LazyArray >> assureExistsIndex: anInteger [
	self allocateMore: anInteger - self size
]

{ #category : #private }
LazyArray >> assureExistsIndex: anInteger1 and: anInteger2 [
	| arr |
	anInteger1 > self size
		ifTrue: [ self assureExistsIndex: anInteger1 ].
	arr := array at: anInteger1.
	arr
		ifNil: [ arr := OrderedCollection new.
			array at: anInteger1 put: arr ].
	anInteger2 > arr size
		ifTrue: [ arr := arr forceTo: anInteger2 paddingWith: self defaultValue.
			array at: anInteger1 put: arr ].
]

{ #category : #accessing }
LazyArray >> at: anInteger [
	anInteger > self size
		ifTrue: [ ^ self defaultValue ].
	^ array at: anInteger
]

{ #category : #accessing }
LazyArray >> at: anInteger put: aValue [
	anInteger > self size
		ifTrue: [ aValue = self defaultValue
				ifTrue: [ ^ self ].
			self assureExistsIndex: anInteger.
			self assert: anInteger <= self size ].
	array at: anInteger put: aValue
]

{ #category : #accessing }
LazyArray >> changeBy: aNumber [
	array
		ifNil: [ defaultValue ifNotNil: [ defaultValue := defaultValue + aNumber ] ]
		ifNotNil: [ array += aNumber ]
]

{ #category : #accessing }
LazyArray >> className [
	^ className
]

{ #category : #accessing }
LazyArray >> className: aSymbol [
	className := aSymbol asSymbol
]

{ #category : #private }
LazyArray >> defaultAllocationSize [
	^ 100
]

{ #category : #accessing }
LazyArray >> defaultValue [
	^ defaultValue ifNil: [ self array defaultElement ]
]

{ #category : #accessing }
LazyArray >> defaultValue: aNumber [
	self assert: defaultValue isNil.
	defaultValue := aNumber.
]

{ #category : #'object i/o' }
LazyArray >> fieldsVersion [
	^ 2
]

{ #category : #private }
LazyArray >> fixedSize [
	^ fixedSize
]

{ #category : #accessing }
LazyArray >> forceSize: anInteger [
	self privFixedSize: anInteger.
	array := array
		ifNil: [ self arrayClass new: self fixedSize ]
		ifNotNil: [ array forceTo: self fixedSize paddingWith: 0 ].
]

{ #category : #'object i/o' }
LazyArray >> initFieldsFrom: anObjStream version: classVersion [
	classVersion = 1
		ifTrue:
			[ self initFieldsNamed: #(array className fixedSize) from: anObjStream ].
	classVersion = 2
		ifTrue: [ self
				initFieldsNamed: #(array className fixedSize defaultValue)
				from: anObjStream ].
	className = #FloatArray
		ifTrue: [ className := #Float32Array ]
]

{ #category : #testing }
LazyArray >> isEmpty [
	^ array isNil or: [ array isEmpty ]
]

{ #category : #testing }
LazyArray >> isFixed [
	^ fixedSize notNil
]

{ #category : #accessing }
LazyArray >> list: anInteger1 [
	| ret |
	(anInteger1 = 0 or: [ anInteger1 > self size ])
		ifTrue: [ ^ Array new ].
	ret := array at: anInteger1.
	ret ifNil: [ ^ Array new ].
	^ ret asArray
]

{ #category : #accessing }
LazyArray >> list: anInteger1 add: anObject [
	anInteger1 = 0
		ifTrue: [ ^ self ].
	self assureExistsIndex: anInteger1 and: 0.
	(array at: anInteger1) add: anObject
]

{ #category : #accessing }
LazyArray >> list: anInteger1 at: anInteger2 [
	| arr |
	anInteger1 = 0
		ifTrue: [ ^ self defaultValue ].
	self assert: className = #Array.
	anInteger1 > self size
		ifTrue: [ self assureExistsIndex: anInteger1 ].
	arr := array at: anInteger1.
	(arr isNil or: [ anInteger2 > arr size ])
		ifTrue: [ ^ self defaultValue ].
	^ arr at: anInteger2
]

{ #category : #accessing }
LazyArray >> list: anInteger1 at: anInteger2 put: anObject [
	anInteger1 = 0
		ifTrue: [ ^ self ].
	self assureExistsIndex: anInteger1 and: anInteger2.
	(array at: anInteger1) at: anInteger2 put: anObject
]

{ #category : #accessing }
LazyArray >> list: anInteger1 contains: anObject [
	anInteger1 = 0
		ifTrue: [ ^ false ].
	self assureExistsIndex: anInteger1 and: 0.
	^ (array at: anInteger1) includes: anObject
]

{ #category : #accessing }
LazyArray >> list: anInteger1 remove: anInteger2 [
	| arr |
	anInteger1 = 0
		ifTrue: [ ^ self ].
	self assureExistsIndex: anInteger1 and: 0.
	arr := array at: anInteger1.
	(anInteger2 > arr size or: [ anInteger2 = 0 ])
		ifTrue: [ ^ self ].
	arr removeAt: anInteger2
]

{ #category : #accessing }
LazyArray >> list: anInteger1 set: aCollection [
	anInteger1 = 0
		ifTrue: [ ^ self ].
	self assureExistsIndex: anInteger1 and: 0.
	array at: anInteger1 put: aCollection copy asOrderedCollection
]

{ #category : #accessing }
LazyArray >> listSizeOf: anInteger [
	(anInteger between: 1 and: self size)
		ifFalse: [ ^ 0 ].
	^ (array at: anInteger) size
]

{ #category : #accessing }
LazyArray >> multiplyBy: aNumber [
	array
		ifNil: [ defaultValue ifNotNil: [ defaultValue := defaultValue * aNumber ] ]
		ifNotNil: [ array *= aNumber ]
]

{ #category : #printing }
LazyArray >> printOn: aStream [
	aStream
		nextPutAll: 'LazyArray(';
		nextPutAll: className asString;
		nextPutAll: ','.
	self isFixed
		ifTrue: [ aStream nextPut: $* ].
	aStream
		nextPutAll: self size asString;
		nextPutAll: ')'.
]

{ #category : #private }
LazyArray >> privArray [
	^ array
]

{ #category : #private }
LazyArray >> privArray: anArray [
	array := anArray.
]

{ #category : #private }
LazyArray >> privFixedSize: anInteger [
	fixedSize := anInteger.
]

{ #category : #accessing }
LazyArray >> reset [
	array := self isFixed
		ifTrue: [ self arrayClass new: fixedSize ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
LazyArray >> setArray: aCollection [
	className ~= aCollection class name
		ifTrue: [ self error ].
	array := aCollection copy.
]

{ #category : #accessing }
LazyArray >> size [
	array ifNil: [ ^ 0 ].
	^ array size
]

{ #category : #'object i/o' }
LazyArray >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(array className fixedSize defaultValue) on: anObjStream.
]

{ #category : #accessing }
LazyArray >> stringAt: anInteger [
	self assert: className = #StringArray.
	anInteger > self size
		ifTrue: [ ^ self defaultValue ].
	^ array stringAt: anInteger
]

{ #category : #accessing }
LazyArray >> stringAt: anInteger put: aString [
	self assert: className = #StringArray.
	anInteger > self size
		ifTrue: [ aString = self defaultValue
				ifTrue: [ ^ self ].
			self assureExistsIndex: anInteger.
			self assert: anInteger <= self size ].
	array stringAt: anInteger put: aString
]
