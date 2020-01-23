text editing
selectWordOrAll: index

	| str wordStart wordEnd |
	str := stringMorph contents.
	(index < 1) | (index > str size) ifTrue: [^ self selectAll].  "off end, select all"
	(str at: index) isSeparator ifTrue: [^ self].  "on separator; do nothing"

	self recordUndoState.
	wordStart := index.
	[(wordStart >= 1) and: [(str at: wordStart) isSeparator not]]
		whileTrue: [wordStart := wordStart - 1].
	wordEnd := index.
	[(wordEnd < str size) and: [(str at: wordEnd) isSeparator not]]
		whileTrue: [wordEnd := wordEnd + 1].
	(str at: wordEnd) isSeparator ifTrue: [wordEnd := wordEnd - 1].

	selectionStart := wordStart.
	selectionEnd := wordEnd.
	self changed.
