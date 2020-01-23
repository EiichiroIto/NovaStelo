editing
moveCursorEndAndSelect: selectFlag

	| lineNum line |
	lineNum := (self lineAndIndexFor: selectionStart) first.
	line := lines at: lineNum.
	selectionEnd := (self startOfLine: lineNum) + line size.
	lineNum = lines size ifTrue: [selectionEnd := selectionEnd + 1].
	selectFlag ifFalse: [selectionStart := selectionEnd].
	startLoc := selectionStart.
	self changed.
