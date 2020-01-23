stepping
step

	isKeyboardFocus ifFalse: [^ self].
	blinkState ifNil: [blinkState := false].
	blinkState := blinkState not.
	selectionStart = selectionEnd ifTrue: [self changed].
