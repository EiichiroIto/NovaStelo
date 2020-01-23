text editing
moveCursorHome
	"Move the cursor (selectionStart) to the beginning of the current line."

	self moveCursorHomeAndSelect.
	selectionEnd := selectionStart.
	self changed.
