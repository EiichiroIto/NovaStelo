accessing
addPlots: aCollection
	aCollection do: [ :each | self plot: each ].
	self updateDisplay