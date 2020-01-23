editing
moveCursorHomeAndSelect: selectFlag

	selectionStart := (self startOfLine: (self lineAndIndexFor: selectionStart) first) + 1.
	selectFlag ifFalse: [selectionEnd := selectionStart].
	startLoc := selectionEnd.
	self changed.
