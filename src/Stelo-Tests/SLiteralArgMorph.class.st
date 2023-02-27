Class {
	#name : #SLiteralArgMorph,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Stelo-Tests'
}

{ #category : #'code generation' }
SLiteralArgMorph >> argString: aGenerator [

	^ aGenerator argString: self.
]

{ #category : #evaluation }
SLiteralArgMorph >> evaluate [

	^ value
]

{ #category : #accessing }
SLiteralArgMorph >> labelMorph [

	^ value
]

{ #category : #printing }
SLiteralArgMorph >> printOn: aStream [

	aStream
		nextPutAll: 'literal(';
		nextPutAll: value asString;
		nextPut: $)
]

{ #category : #accessing }
SLiteralArgMorph >> value1 [

	^ value
]

{ #category : #accessing }
SLiteralArgMorph >> value: anObject [

	value := anObject
]
