event handling
doubleClick: evt
	| p |
	p := evt cursorPoint - self topLeft.
	self doDoubleClickAt: p