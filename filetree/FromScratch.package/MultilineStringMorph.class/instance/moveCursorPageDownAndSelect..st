editing
moveCursorPageDownAndSelect: selectFlag

	| i lastLine |
	i := (self lineAndIndexFor: selectionStart) second.
	lastLine := lines at: lines size.
	selectionEnd := (self startOfLine: lines size) + (i min: lastLine size + 1).
	selectFlag ifFalse: [selectionStart := selectionEnd].
	startLoc := selectionStart.
	self changed.
