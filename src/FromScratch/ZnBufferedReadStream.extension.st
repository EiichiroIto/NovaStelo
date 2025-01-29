Extension { #name : 'ZnBufferedReadStream' }

{ #category : '*FromScratch' }
ZnBufferedReadStream >> uint24 [
	^ self nextIntegerOfSize: 3 signed: false bigEndian: true 
]
