editing
selectAll
	"Select all of my text."

	selectionStart := 1.
	selectionEnd := self charCount + 1.
	self changed.
