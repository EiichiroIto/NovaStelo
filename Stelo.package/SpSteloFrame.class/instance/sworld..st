accessing
sworld: aWorld
	| display |
	display := self display.
	display
		sworld: aWorld;
		whenDoubleClickDo: [ :pos | self showBreedView: pos ]
		changed