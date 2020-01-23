editing
deleteNextChar
	"If there is a selection, delete it. Otherwise delete the character just after the insertion point (i.e. delete)."

	selectionStart = selectionEnd ifFalse: [^ self deleteSelection].

	selectionEnd := selectionStart + 1.
	self deleteSelection.
