accessing
tab: aString
	super tab: aString.
	self target ifNil: [ ^ self ].
	self plotterContents: self target plotter