initialization
initializePresenters
	pageViewer := self newMorph.
	pageViewer morph: (ScrollFrameMorph2 new growthFraction: 0.1).
	self setupButtons.
	self updateButtons