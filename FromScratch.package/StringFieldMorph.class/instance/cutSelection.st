text editing
cutSelection
	"Cut the current selection."

	selectionStart = selectionEnd ifTrue: [^ self].  "no selection; do nothing"
	self copySelection.  "save the selection we're about to cut"
	self removeSelection.
