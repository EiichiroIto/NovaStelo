text editing
paste
	"Paste the last cut or copy over the current selection."

	| strToInsert str newStr |
	strToInsert := ScratchTranslator unicodeClipboard.
	strToInsert isEmpty ifTrue: [^ self].

	self recordUndoState.
	str := stringMorph contents.
	newStr :=
		(str copyFrom: 1 to: self leftSelection),
		strToInsert,
		(str copyFrom: (self rightSelection + 1) to: str size).
	selectionEnd := selectionStart := self leftSelection + strToInsert size.
	stringMorph contentsClipped: newStr.
	self stringChanged.
