Class {
	#name : #STONObjStream,
	#superclass : #Object,
	#category : #'FromScratch-Project'
}

{ #category : #accessing }
STONObjStream class >> fileVersion: anAppClass from: aStream [
	"Answer the Scratch file version number from the given string. If the string is of the form: 'ScratchVxx', were xx is a two-digit integer, answer the value of xx. Otherwise, answer 0."

	| str |
	str := (aStream next: anAppClass appVersionString size) asString.
	(str beginsWith: anAppClass appVersionTag)
		ifFalse: [ ^ 0 ].
	^ (str
		copyFrom: anAppClass appVersionTag size + 1
		to: str size) asNumberNoError
]

{ #category : #'entry points' }
STONObjStream >> readObjFrom: aStream [
	"Read the root object from the given binary stream."

	^ self readObjFrom: aStream showProgress: false
]

{ #category : #'entry points' }
STONObjStream >> readObjFrom: aStream showProgress: aBoolean [
	| str |
	str := aStream upToEnd asString.
	^ STON fromString: str
]

{ #category : #'entry points' }
STONObjStream >> storeObj: anObject on: aStream [
	| str |
	str := STON toString: anObject.
	aStream nextPutAll: str asByteArray
]
