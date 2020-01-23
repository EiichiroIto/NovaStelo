accessing
currentCategory: aString
	currentCategory := aString asLowercase.
	self updateButtonIcon.
	self updateContents.
	self selectButtons