text editing
moveCursorRight
	"Move the cursor (selectionStart) right by one character."

	self moveCursorRightAndSelect.
	selectionEnd := selectionStart.
	self changed.
