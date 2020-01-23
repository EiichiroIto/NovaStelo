text editing
moveCursorLeft
	"Move the cursor (selectionStart) left by one character."

	self moveCursorLeftAndSelect.
	selectionEnd := selectionStart.
	self changed.
