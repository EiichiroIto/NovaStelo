Extension { #name : #Cursor }

{ #category : #'*FromScratch' }
Cursor class >> eyeDropper [
	^ CursorWithMask derivedFrom: (((Smalltalk ui icons iconNamed: #eyeDropper) scaledIntoFormOfSize: 16) offset: 0@ -14)
]
