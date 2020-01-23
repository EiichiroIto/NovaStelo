accessing
stringExpression: aString

	isNumber := false.
	labelMorph isNumeric: false.
	labelMorph contents: aString.
	self fixArgLayout.
