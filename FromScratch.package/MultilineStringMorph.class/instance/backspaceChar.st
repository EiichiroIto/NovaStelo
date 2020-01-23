editing
backspaceChar
	"If there is a selection, delete it. Otherwise delete the character just before the insertion point (i.e. backspace)."

	selectionStart = selectionEnd ifFalse: [^ self deleteSelection].

	selectionStart > 1 ifTrue: [
		selectionEnd := selectionStart.
		selectionStart := selectionStart - 1.
		self deleteSelection].
