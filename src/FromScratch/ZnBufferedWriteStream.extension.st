Extension { #name : #ZnBufferedWriteStream }

{ #category : #'*FromScratch' }
ZnBufferedWriteStream >> uint24: integer [
	^ self nextIntegerOfSize: 3 signed: false bigEndian: true put: integer
]
