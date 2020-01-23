drawing
drawOn: aCanvas

	| clipC |
	super drawOn: aCanvas.
	lineHeight ifNil: [self font: font].

	clipC := aCanvas
		copyOffset: bounds origin
		clipRect: (bounds insetBy: borderWidth).

	(hasFocus | owner isNil) ifTrue: [self drawSelectionOn: clipC].
	self drawTextOn: clipC.
