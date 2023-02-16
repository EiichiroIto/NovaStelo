Class {
	#name : #ScratchChoiceArgDef,
	#superclass : #AbstractBlockSpec,
	#instVars : [
		'arg',
		'options'
	],
	#category : #'FromScratch-Project'
}

{ #category : #accessing }
ScratchChoiceArgDef >> arg [

	^ arg
]

{ #category : #accessing }
ScratchChoiceArgDef >> arg: anObject [

	arg := anObject
]

{ #category : #testing }
ScratchChoiceArgDef >> isChoiceArg [

	^ true
]

{ #category : #accessing }
ScratchChoiceArgDef >> options [

	^ options
]

{ #category : #accessing }
ScratchChoiceArgDef >> options: anObject [

	options := anObject
]

{ #category : #printing }
ScratchChoiceArgDef >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPut: $(.
	arg ifNotNil: [ 
		aStream
			nextPut: $%;
			nextPut: arg.
		options ifNotNil: [ 
			aStream
				nextPut: $,;
				nextPutAll: options size asString ] ].
	aStream nextPut: $)
]
