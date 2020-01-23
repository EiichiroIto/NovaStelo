initialization
initialize

	super initialize.
	color := Color transparent.
	textColor := Color black.
	selectionColor := Color r: 0.353 g: 0.607 b: 0.788.
	lines := Array with: self emptyLine.
	isEditable := true.
	centerText := false.
	hasFocus := false.
	selectionStart := selectionEnd := 1.
	blinkState := true.
	growWithText := false.
	inset := 5@3.
	suppressAntiAliasing := false.
	renderWithSqueak := false.
	self font: TextStyle defaultFont.
	super extent: 90@25.
