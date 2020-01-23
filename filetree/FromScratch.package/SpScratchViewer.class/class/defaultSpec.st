specs
defaultSpec
	| myLayout |
	myLayout := SpBoxLayout newVertical.
	self addButtonsTo: myLayout.
	myLayout add: #pageViewer.
	^ myLayout