accessing
currentTab: aString
	super currentTab: aString.
	self target ifNil: [ ^ self ].
	self plotterContents: self target plotter