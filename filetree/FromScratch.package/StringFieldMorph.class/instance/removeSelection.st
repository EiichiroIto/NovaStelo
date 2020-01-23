text editing
removeSelection
	"Cut the current selection."

	| str newStr |
	self recordUndoState.
	str := stringMorph contents.
	newStr := 
		(str copyFrom: 1 to: self leftSelection), 
		(str copyFrom: self rightSelection + 1 to: str size).
	stringMorph contentsClipped: newStr.
	selectionEnd := selectionStart := self leftSelection.
	self stringChanged.
