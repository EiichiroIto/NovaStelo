event handling
mouseDown: evt

	self isEditable ifFalse: [^ self].
	evt hand newKeyboardFocus: self.
	startLoc := self indexForPoint: evt cursorPoint.
	selectionStart := selectionEnd := startLoc.
	evt hand waitForClicksOrDrag: self event: evt.
	self changed.
