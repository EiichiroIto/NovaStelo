*FromScratch
firstClickCursorPoint
	mouseClickState ifNil: [ ^ nil ].
	^ mouseClickState cursorPoint