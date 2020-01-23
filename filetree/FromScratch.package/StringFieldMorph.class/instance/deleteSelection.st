text editing
deleteSelection
	"Delete the current selection. If there is no selection, delete the character after the cursor."

	| str newStr |
	str := stringMorph contents.
	(self rightSelection - self leftSelection) > 0 ifTrue: [^ self removeSelection].
	(self rightSelection >= str size) ifTrue: [^ self].
	self recordUndoState.
	newStr :=
		(str copyFrom: 1 to: self leftSelection),
		(str copyFrom: self leftSelection + 2 to: str size).
	stringMorph contentsClipped: newStr.
	selectionEnd := selectionStart := self leftSelection max: 0.
	self stringChanged.
