text editing
undo
	"Swap the undo buffer witht the current state. Doing this a second time will undo the undo operation."

	| oldUndoState |
	oldUndoState := undoState.
	self recordUndoState.
	stringMorph contentsClipped: (oldUndoState at: 1).
	selectionStart := (oldUndoState at: 2).
	selectionEnd := (oldUndoState at: 3).
	self stringChanged.
