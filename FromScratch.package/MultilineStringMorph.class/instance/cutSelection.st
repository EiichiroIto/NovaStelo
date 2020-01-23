editing
cutSelection
	"Record the current selection in the clipboard, then delete it."

	selectionStart = selectionEnd ifTrue: [^ self].  "no selection"
	self copySelection.
	self deleteSelection.
