accessing
contents: aString

	doResizing
		ifTrue: [stringMorph contents: aString "asUTF32"]
		ifFalse: [stringMorph contentsClipped: aString "asUTF32"].

	self stringChanged.
