event handling
handlesMouseDown: evt
	^ (self topRight - (14 @ 0) corner: self bottomRight)
		containsPoint: evt cursorPoint