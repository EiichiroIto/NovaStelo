drawing
drawOn: aCanvas 

	self computeHighlightColors.
	isBoolean
		ifTrue: [self drawBooleanOn: aCanvas]
		ifFalse: [self drawNumericOn: aCanvas].
