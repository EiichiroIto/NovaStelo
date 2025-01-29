Extension { #name : 'HandMorph' }

{ #category : '*FromScratch' }
HandMorph >> firstClickCursorPoint [
	mouseClickState ifNil: [ ^ nil ].
	^ mouseClickState cursorPoint
]

{ #category : '*FromScratch' }
HandMorph >> rejectDropMorph: aMorph event: evt [
	aMorph rejectDropMorphEvent: evt
]
