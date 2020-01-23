text editing
moveCursorEndAndSelect
	"Move the cursor (selectionStart), and select contents, to the end of the current line."

	self recordUndoState.
	selectionStart := stringMorph contents size.
	self changed.
