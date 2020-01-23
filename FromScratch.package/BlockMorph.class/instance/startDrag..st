event handling
startDrag: evt

	| rootForGrab point |
	"evt hand toolType ifNil: ["
		point := evt hand firstClickCursorPoint ifNil: [ evt cursorPoint ].
		rootForGrab := self rootForGrabOf: self.
		rootForGrab ifNil: [^ self].
		evt hand grabMorph: rootForGrab.
		rootForGrab position: evt hand position + (rootForGrab topLeft - point)
		"]".

	"self handleTool: evt hand toolType hand: evt hand"