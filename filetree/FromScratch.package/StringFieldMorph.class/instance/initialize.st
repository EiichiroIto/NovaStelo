initialization
initialize

	super initialize.

	stringMorph := StringMorph new
		contents: '';
		font: (StrikeFont familyName: 'Verdana' size: 12).
	self addMorph: stringMorph.

	self color: Color red.
	self textColor: ScratchTheme dialogBoxTextColor.
	doResizing := false.
	isNumeric := false.
	isKeyboardFocus := false.
	acceptWhenFocusLost := false.
	self keyboardFocusChange: false.
	selectionColor := ScratchTheme textSelectionColor.
	selectionStart := selectionEnd := 0.
	self recordUndoState.

	self borderInset; useNoFrame.
	self width: 100.