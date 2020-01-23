event handling
doubleClick: evt
	"Select word or entire contents."

	| xOffset i |
	evt hand newKeyboardFocus: self.
	xOffset := evt cursorPoint x - stringMorph left.
	xOffset < 3 ifTrue: [^ self selectAll].
	i := self characterOffsetForXOffset: evt cursorPoint x.
	self selectWordOrAll: i + 1.
