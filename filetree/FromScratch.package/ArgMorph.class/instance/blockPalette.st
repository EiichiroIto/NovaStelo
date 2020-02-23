accessing
blockPalette
	owner ifNil: [ ^ nil ].
	^ owner blockPalette