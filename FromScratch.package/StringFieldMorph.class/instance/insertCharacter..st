text editing
insertCharacter: unicodeChar
	"Insert the given character at the cursor position."

	| str newStr insertion |
	isNumeric ifTrue: [
		('-0123456789.,' asByteArray includes: unicodeChar)
			ifFalse: [^ self beep]].

	self recordUndoState.
	str := stringMorph contents.
	"insertion := UTF32 with: unicodeChar."
	insertion := (Unicode charFromUnicode: unicodeChar) asString.
	newStr :=
		(str copyFrom: 1 to: self leftSelection),
		insertion,
		(str copyFrom: (self rightSelection + 1) to: str size).
	selectionEnd := selectionStart := self leftSelection + 1.
	stringMorph contentsClipped: newStr.
	self stringChanged.
