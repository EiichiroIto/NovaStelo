accessing
currentCategory: aString
	currentCategory := aString asLowercase.
	self updateButtons.
	self updateContents