text editing
moveCursorRightAndSelect
	"Move the cursor (selectionStart), and select, right by one character."

	self recordUndoState.
	selectionStart := (selectionStart + 1) min: stringMorph contents size.
	self changed.
