event handling
mouseMove: evt

	| currIndex |
	dragStartIndex ifNil: [dragStartIndex := 0].
	currIndex := self characterOffsetForXOffset: evt cursorPoint x.
	selectionStart := currIndex min: dragStartIndex.
	selectionEnd := currIndex max: dragStartIndex.
	self changed.
