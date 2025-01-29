Extension { #name : 'MouseClickState' }

{ #category : '*FromScratch' }
MouseClickState >> cursorPoint [
	^ firstClickDown cursorPoint
]
