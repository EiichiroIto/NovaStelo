event handling
mouseDown: evt

	dragStartIndex := self characterOffsetForXOffset: evt cursorPoint x.
	evt hand waitForClicksOrDrag: self event: evt.
