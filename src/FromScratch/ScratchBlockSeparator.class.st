Class {
	#name : #ScratchBlockSeparator,
	#superclass : #AbstractBlockSpec,
	#category : #'FromScratch-Project'
}

{ #category : #testing }
ScratchBlockSeparator >> isSeparator [

	^ true
]

{ #category : #printing }
ScratchBlockSeparator >> printOn: aStream [

	aStream nextPutAll: self class name
]
