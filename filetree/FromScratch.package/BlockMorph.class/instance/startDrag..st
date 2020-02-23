event handling
startDrag: evt
	| rootForGrab point |
	point := evt hand firstClickCursorPoint ifNil: [ evt cursorPoint ].
	rootForGrab := self rootForGrabOf: self.
	rootForGrab ifNil: [ ^ self ].
	evt hand grabMorph: rootForGrab.
	rootForGrab
		position: evt hand position + (rootForGrab topLeft - point)