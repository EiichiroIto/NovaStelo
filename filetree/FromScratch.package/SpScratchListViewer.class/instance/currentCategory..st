accessing
currentCategory: aString
	aString ifNil: [ ^ self ].
	categories selectItem: aString asLowercase