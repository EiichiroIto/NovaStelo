text editing
moveCursorEnd
	"Move the cursor (selectionStart) to the end of the current line."

	self moveCursorEndAndSelect.
	selectionEnd := selectionStart.
	self changed.
