Class {
	#name : #STONObjStream,
	#superclass : #Object,
	#category : #'FromScratch-Converter'
}

{ #category : #'entry points' }
STONObjStream >> readObjFrom: aStream [
	"Read the root object from the given binary stream."

	^ self readObjFrom: aStream showProgress: false
]

{ #category : #'entry points' }
STONObjStream >> readObjFrom: aStream showProgress: aBoolean [
	| str |
	str := aStream upToEnd.
	str := ZnUTF8Encoder default decodeBytes: str.
	^ STON fromString: str
]

{ #category : #'entry points' }
STONObjStream >> storeObj: anObject on: aStream [
	| str |
	str := STON toString: anObject.
	str := ZnUTF8Encoder default encodeString: str.
	aStream nextPutAll: str
]
