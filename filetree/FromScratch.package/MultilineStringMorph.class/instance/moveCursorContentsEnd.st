editing
moveCursorContentsEnd
	"Position the cursor at the end of my contents (i.e. at very end, not the end of the current line)."

	selectionStart := selectionEnd := self charCount + 1.
	self changed.
