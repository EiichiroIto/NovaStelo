editing
moveCursorPageUpAndSelect: selectFlag

	| i |
	i := (self lineAndIndexFor: selectionStart) second.
	selectionStart := i min: (lines at: 1) size max: 1.
	selectFlag ifFalse: [selectionEnd := selectionStart].
	startLoc := selectionEnd.
	self changed.
