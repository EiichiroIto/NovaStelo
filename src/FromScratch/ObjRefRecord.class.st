"
Instances of me are used to temporarily record inter-object references when ObjStream is reading in an object structure. After all the objects have been read, a second pass is made to replace each object reference with a pointer directly to to the object in the object table.

"
Class {
	#name : #ObjRefRecord,
	#superclass : #Object,
	#instVars : [
		'objectID'
	],
	#category : #'FromScratch-Converter'
}

{ #category : #accessing }
ObjRefRecord >> objectID [

	^ objectID

]

{ #category : #accessing }
ObjRefRecord >> objectID: anInteger [

	objectID :=  anInteger.

]

{ #category : #printing }
ObjRefRecord >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: objectID asString;
		nextPut: $)
]
