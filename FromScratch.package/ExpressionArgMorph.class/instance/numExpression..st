accessing
numExpression: aNumber

	isNumber := true.
	labelMorph isNumeric: true.

	aNumber isFloat
		ifTrue: [labelMorph contents: aNumber printString]
		ifFalse: [labelMorph contents: aNumber asString].
	self fixArgLayout.
