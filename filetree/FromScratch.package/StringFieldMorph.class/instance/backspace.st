text editing
backspace
	"Delete the current selection. If there is no selection, delete the character before the cursor."

	| str newStr |
	(self rightSelection - self leftSelection) > 0 ifTrue: [^ self removeSelection].
	self leftSelection < 1 ifTrue: [^ self].
	self recordUndoState.
	str := stringMorph contents.
	newStr :=
		(str copyFrom: 1 to: self leftSelection - 1),
		(str copyFrom: self leftSelection + 1 to: str size).
	stringMorph contentsClipped: newStr.
	selectionEnd := selectionStart := (self leftSelection - 1) max: 0.
	self stringChanged.
