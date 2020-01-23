event handling
click: evt

	| hadFocus |
	hadFocus := isKeyboardFocus.
	evt hand newKeyboardFocus: self.
	hadFocus
		ifTrue: [
			selectionStart := self characterOffsetForXOffset: evt cursorPoint x.
			selectionEnd := selectionStart]
		ifFalse: [
			self selectAll].
	self stringChanged.
