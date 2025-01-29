Class {
	#name : 'ScratchBlockCategory',
	#superclass : 'AbstractBlockSpec',
	#instVars : [
		'categoryName'
	],
	#category : 'FromScratch-Project',
	#package : 'FromScratch',
	#tag : 'Project'
}

{ #category : 'accessing' }
ScratchBlockCategory >> categoryName [

	^ categoryName
]

{ #category : 'accessing' }
ScratchBlockCategory >> categoryName: anObject [

	categoryName := anObject
]

{ #category : 'testing' }
ScratchBlockCategory >> isCategory [

	^ true
]

{ #category : 'printing' }
ScratchBlockCategory >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: categoryName asString;
		nextPut: $)
]
