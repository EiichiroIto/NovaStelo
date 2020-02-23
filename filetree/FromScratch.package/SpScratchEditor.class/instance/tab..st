accessing
tab: aString
	self target ifNil: [ ^ self ].
	self editorContents: self target blocksBin.
	self editorContents color: ScratchTheme scriptsPaneColor.
	notebook pages
		detect: [ :page | page title = aString ]
		ifFound: [ :page | notebook selectPage: page ]