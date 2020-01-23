event handling
doubleClick: evt
	"Select a word."

	| lineAndIndex lineNum s index wordStart wordEnd lineStart |
	lines size = 0 ifTrue: [^ self].

	lineAndIndex := self lineAndIndexFor: (self indexForPoint: evt cursorPoint).
	lineNum := lineAndIndex first.
	s := lines at: lineNum.
	s size = 0 ifTrue: [^ self].  "empty line"

	index := lineAndIndex second.
	index > s size ifTrue: [index := s size].  "at end of line; try one char back"
	(s at: index) isSeparator ifTrue: [^ self].  "on separator; do nothing"

	wordStart := index.
	[(wordStart >= 1) and: [(s at: wordStart) isSeparator not]]
		whileTrue: [wordStart := wordStart - 1].
	wordEnd := index.
	[(wordEnd < s size) and: [(s at: wordEnd) isSeparator not]]
		whileTrue: [wordEnd := wordEnd + 1].
	(s at: wordEnd) isSeparator ifTrue: [wordEnd := wordEnd - 1].

	lineStart := self startOfLine: lineNum.
	selectionStart := lineStart + (wordStart + 1).
	selectionEnd := lineStart + (wordEnd + 1).
	startLoc := selectionStart.
	self changed.

