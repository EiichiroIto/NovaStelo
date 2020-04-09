api
addPlots: aCollection
	self acceptPlots
		ifFalse: [ ^ self ].
	aCollection do: [ :each | self plot: each ].
	self updateDisplay