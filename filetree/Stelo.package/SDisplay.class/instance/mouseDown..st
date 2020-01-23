event handling
mouseDown: evt
	evt hand newKeyboardFocus: nil.
	evt hand waitForClicksOrDrag: self event: evt