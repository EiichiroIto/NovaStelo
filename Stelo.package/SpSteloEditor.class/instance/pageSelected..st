private
pageSelected: aNotebookPage
	aNotebookPage title = self plotterLabel
		ifFalse: [ ^ self ].
	self plotterContents
		ifNotNil: [ :p | p bounds: (self plotterBase bounds insetBy: 5) ]