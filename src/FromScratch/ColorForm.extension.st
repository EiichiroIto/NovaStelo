Extension { #name : 'ColorForm' }

{ #category : '*FromScratch' }
ColorForm >> privateColors [
	^ colors
]

{ #category : '*FromScratch' }
ColorForm >> privateColors: anObject [
	colors := anObject.
	cachedDepth := nil.
	cachedColormap := nil
]
