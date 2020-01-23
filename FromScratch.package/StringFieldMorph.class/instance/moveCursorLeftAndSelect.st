text editing
moveCursorLeftAndSelect
	"Move the cursor (selectionStart), and select, left by one character."

	self recordUndoState.
	selectionStart := (selectionStart - 1) max: 0.
	self changed.
