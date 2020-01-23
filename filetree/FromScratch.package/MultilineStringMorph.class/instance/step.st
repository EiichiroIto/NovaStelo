stepping
step

	blinkState := blinkState not.
	selectionStart = selectionEnd ifTrue: [self changed].
