event handling
mouseMove: evt

	| newLoc |
	self isEditable ifFalse: [^ self].
	newLoc := self indexForPoint: evt cursorPoint.
	startLoc ifNil: [startLoc := newLoc].
	newLoc < startLoc
		ifTrue: [selectionStart := newLoc. selectionEnd := startLoc]
		ifFalse: [selectionStart := startLoc. selectionEnd := newLoc].
	self changed.
