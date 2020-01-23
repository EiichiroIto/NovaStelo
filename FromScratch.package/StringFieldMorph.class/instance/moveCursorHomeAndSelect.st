text editing
moveCursorHomeAndSelect
	"Move the cursor (selectionStart), and select contents, to the beginning of the current line."

	self recordUndoState.
	selectionStart := 0.
	self changed.
