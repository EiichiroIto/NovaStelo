event handling
handlesMouseDown: evt

	^ "evt hand toolType isNil and:
		["
		(self topRight - (14@0) corner: self bottomRight) containsPoint: evt cursorPoint
		"]"
