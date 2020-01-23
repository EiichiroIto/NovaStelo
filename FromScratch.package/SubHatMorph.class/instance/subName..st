accessing
subName: aString
	subName := aString.
	scriptNameMorph contents: ('Sub ', aString).
	self fixBlockLayout.
	self applicationDo: [ :app | app updateContents ]